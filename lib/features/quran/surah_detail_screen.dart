import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/mock_data.dart';
import 'quran_sheets.dart';
import '../../core/theme/theme.dart';
import '../../widgets/widgets.dart';

/// Shared reading header: 66px, #f8faf6, back · title · search.
class ReadingHeader extends StatelessWidget {
  const ReadingHeader({super.key, required this.title, this.onSearch});
  final String title;
  final VoidCallback? onSearch;

  @override
  Widget build(BuildContext context) => Container(
        color: AppColors.surface,
        padding: EdgeInsets.fromLTRB(24, MediaQuery.of(context).padding.top + 10 + 8, 24, 8),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          GestureDetector(onTap: () => Navigator.maybePop(context), child: const AppIcon('button_margin_35cdaed2', w: 32, h: 46)),
          Text(title, style: AppTextStyles.titleTight),
          GestureDetector(onTap: onSearch, child: const AppIcon('button_margin_437cb4d7', w: 32, h: 34)),
        ]),
      );
}

/// Figma: "AI Baqara Details" (6001:5622) + Audio Play (6001:5923).
class SurahDetailScreen extends StatefulWidget {
  const SurahDetailScreen({super.key});

  @override
  State<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  int? _playing;
  bool _paused = false;
  double _progress = 0.3;
  Timer? _ticker;

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  void _play(Verse v) {
    if (_playing == v.number) {
      setState(() => _paused = !_paused);
      return;
    }
    _ticker?.cancel();
    setState(() {
      _playing = v.number;
      _paused = false;
      _progress = 0;
    });
    // Simulated playback – swap for just_audio + Quran.com recitation URLs.
    _ticker = Timer.periodic(const Duration(milliseconds: 200), (_) {
      if (_paused || !mounted) return;
      if (_progress >= 1) {
        _skip(1);
      } else {
        setState(() => _progress = (_progress + 0.01).clamp(0, 1));
      }
    });
  }

  void _skip(int d) {
    final i = kBaqarahVerses.indexWhere((v) => v.number == _playing);
    setState(() {
      _playing = kBaqarahVerses[(i + d).clamp(0, kBaqarahVerses.length - 1)].number;
      _progress = 0;
    });
  }

  void _stop() {
    _ticker?.cancel();
    setState(() => _playing = null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      bottomNavigationBar: Column(mainAxisSize: MainAxisSize.min, children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          child: _playing == null
              ? const SizedBox(width: double.infinity)
              : AudioPlayerBar(
                  title: 'Al-Baqarah - verse $_playing',
                  reciter: kReciters.first.name,
                  playing: !_paused,
                  progress: _progress,
                  onToggle: () => setState(() => _paused = !_paused),
                  onPrev: () => _skip(-1),
                  onNext: () => _skip(1),
                  onClose: _stop,
                ),
        ),
        const PushedBottomNav(),
      ]),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: AppColors.pageGradient,
        ),
        child: Column(children: [
          const ReadingHeader(title: 'Al Baqara'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 21, 24, 24),
              children: [
                const SurahHeroCard(title: '2. Al-Baqarah', subtitle: 'The Cow', summary: kBaqarahSummary, badge: 'Verses 21–22'),
                for (final v in kBaqarahVerses) ...[
                  const SizedBox(height: 21),
                  VerseCard(
                    verse: v,
                    playing: _playing == v.number && !_paused,
                    onTafsir: () => showTafsirSheet(context, v),
                    onPlay: () => _play(v),
                    onShare: () => showShareSheet(context, v),
                  ),
                ],
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
