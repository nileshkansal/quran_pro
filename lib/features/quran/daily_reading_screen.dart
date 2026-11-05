import 'package:flutter/material.dart';

import '../../core/assets.dart';
import '../../core/figma.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../data/mock_data.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/verse_card.dart';
import 'quran_sheets.dart';
import 'surah_detail_screen.dart';

/// Figma: "Daily Reading" (6001:6818). One reading-plan section: summary
/// card, its verses, completion banner, actions and the next section preview.
class DailyReadingScreen extends StatelessWidget {
  const DailyReadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final verses = kBaqarahVerses.take(2).toList();
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAF6),
      bottomNavigationBar: const PushedBottomNav(),
      body: Column(children: [
        const ReadingHeader(title: 'Daily Reading'),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 21, 24, 24),
            children: [
              const SurahHeroCard(title: '2. Al-Baqarah', subtitle: 'The Cow', summary: kBaqarahSummary, badge: 'Verses 21–22'),
              for (final v in verses) ...[
                const SizedBox(height: 21),
                VerseCard(
                  verse: v,
                  onTafsir: () => showTafsirSheet(context, v),
                  onPlay: () => Navigator.of(context).pushNamed(AppRoutes.surahDetail),
                  onShare: () => showShareSheet(context, v),
                ),
              ],
              const SizedBox(height: 21),
              // Completion banner: 72px, #f3f1e8, r12.
              Container(
                height: 72,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: const Color(0xFFF3F1E8), borderRadius: BorderRadius.circular(12)),
                child: Row(children: [
                  const FigIcon('frame_2085667896_172a6c0f', w: 40, h: 40),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text('Wahoo! You have completed your daily goal! ', maxLines: 1, style: ts(Ff.inter, 12, w700, AppColors.textPrimary, lh: 24)),
                      Text('Keep it up! Consistency is the key.', style: ts(Ff.inter, 12, w500, AppColors.textSecondary, lh: 16)),
                    ]),
                  ),
                ]),
              ),
              const SizedBox(height: 21),
              Row(children: [
                Expanded(
                  child: _btn(
                    label: 'Continue Reading',
                    color: const Color(0xFF014630),
                    leading: const FigIcon('f7_book_484eb584', w: 22, h: 22),
                    onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.surahDetail),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(child: _btn(label: 'Finish for Today', onTap: () => Navigator.of(context).pushReplacementNamed(AppRoutes.success))),
              ]),
              const SizedBox(height: 21),
              // Next section preview: 343×135, image offset −27.
              SizedBox(
                height: 135,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.1),
                  child: Stack(children: [
                    Positioned(top: -27, left: 0.5, right: 0, height: 196, child: Image.asset(AppImages.surahCard, fit: BoxFit.fill)),
                    const Positioned(left: 274.8, top: 19.5, child: FigIcon('at_icons_moon_cde903eb', w: 25.8, h: 25.8)),
                    Positioned(
                      left: 15.5,
                      top: 28.7,
                      width: 165,
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Verses 23-24', style: ts(Ff.inter, 17.6, w700, Colors.white, lh: 30.9)),
                        const SizedBox(height: 2.2),
                        Opacity(
                          opacity: 0.9,
                          child: Text(
                            'The Miraculous nature and eloquence of the Quran is Allah’s proof upon his creation, and a clarification of the punishment awaiting the disbelievers.',
                            style: ts(Ff.inter, 8, w400, AppColors.green300, lh: 11.3),
                          ),
                        ),
                      ]),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _btn({required String label, required VoidCallback onTap, Color? color, Widget? leading}) => Container(
        height: 48,
        decoration: BoxDecoration(
          color: color,
          gradient: color == null ? AppColors.goldGradient : null,
          border: Border.all(color: fc(0xBFC9C2, .5)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onTap,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              if (leading != null) ...[leading, const SizedBox(width: 5)],
              Text(label, style: ts(Ff.inter, 12, w600, Colors.white, lh: 16)),
            ]),
          ),
        ),
      );
}
