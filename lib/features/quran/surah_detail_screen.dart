import 'dart:async';

import 'package:flutter/material.dart';

import '../../core/figma.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/verse_card.dart';
import 'quran_sheets.dart';

/// Shared reading header: 66px, #f8faf6, back · title · search.
class ReadingHeader extends StatelessWidget {
  const ReadingHeader({super.key, required this.title, this.onSearch});
  final String title;
  final VoidCallback? onSearch;

  @override
  Widget build(BuildContext context) => Container(
        color: const Color(0xFFF8FAF6),
        padding: EdgeInsets.fromLTRB(24, MediaQuery.of(context).padding.top + 10 + 8, 24, 8),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          GestureDetector(onTap: () => Navigator.maybePop(context), child: const FigIcon('button_margin_35cdaed2', w: 32, h: 46)),
          Text(title, style: ts(Ff.inter, 20, w700, AppColors.green800, lh: 28, ls: -0.5)),
          GestureDetector(onTap: onSearch, child: const FigIcon('button_margin_437cb4d7', w: 32, h: 34)),
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
      backgroundColor: const Color(0xFFF8FAF6),
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
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFFF8FAF6), Colors.white]),
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
