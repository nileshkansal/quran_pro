import 'package:flutter/material.dart';

import '../core/assets.dart';
import '../core/figma.dart';
import '../core/state/app_state.dart';
import '../core/theme/app_colors.dart';
import '../data/mock_data.dart';
import 'common.dart';
import 'fig_widgets.dart';

/// Figma verse card (AI Baqara Details): 342 wide, pad 16, r20, #ecefeb border,
/// gap 14 · badge/menu row · Arabic (Amiri Bold 16/41 #003b29) · divider ·
/// translation (Inter Medium 12/16 #404944) · rule · Tafsir | Play | Share.
class VerseCard extends StatelessWidget {
  const VerseCard({super.key, required this.verse, this.onTafsir, this.onPlay, this.onShare, this.playing = false});

  final Verse verse;
  final VoidCallback? onTafsir;
  final VoidCallback? onPlay;
  final VoidCallback? onShare;
  final bool playing;

  @override
  Widget build(BuildContext context) {
    final s = AppState.instance;
    final scale = 0.8 + s.fontScale * 0.4; // "Normal" (0.5) = 1.0
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: playing ? AppColors.goldSoft : AppColors.surfaceDim),
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(children: [
        SizedBox(
          height: 32,
          child: Row(children: [
            SizedBox(
              width: 32,
              height: 32,
              child: Stack(alignment: Alignment.center, children: [
                Image.asset(AppIcons.verseBadge, width: 32, height: 32, color: Colors.black),
                Text('${verse.number}', style: ts(Ff.inter, 14, w500, Colors.black, lh: 21.3, ls: 0.8)),
              ]),
            ),
            const Spacer(),
            PopupMenuButton<String>(
              padding: EdgeInsets.zero,
              tooltip: 'More',
              onSelected: (v) => showComingSoon(context, v),
              itemBuilder: (_) => const [
                PopupMenuItem(value: 'Bookmark', child: Text('Bookmark')),
                PopupMenuItem(value: 'Copy', child: Text('Copy')),
                PopupMenuItem(value: 'Add note', child: Text('Add note')),
              ],
              child: const FigIcon('pinhead_three_dot_horizontal_d970d4eb', w: 15, h: 15),
            ),
          ]),
        ),
        const SizedBox(height: 14),
        SizedBox(
          width: 258 * (scale > 1 ? 1.15 : 1),
          child: Text(
            verse.arabic,
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: ts(s.script == QuranScript.uthmani ? Ff.amiri : Ff.scheherazade, 16 * scale, w700, AppColors.green800, lh: 41 * scale),
          ),
        ),
        const SizedBox(height: 10),
        const DecorDivider(lineWidth: 131),
        const SizedBox(height: 10),
        SizedBox(
          width: 298,
          child: Text(
            '${verse.number}. ${verse.translation}',
            textAlign: TextAlign.center,
            style: ts(Ff.inter, 12 * scale, w500, AppColors.textSecondary, lh: 16 * scale),
          ),
        ),
        const SizedBox(height: 14),
        // Full-bleed rule across the card.
        Transform.scale(scaleX: 342 / 310, child: Container(height: 1, color: AppColors.surfaceDim)),
        const SizedBox(height: 14),
        SizedBox(
          height: 16,
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            _action('bi_book_890145c4', 'Tafsir', onTafsir),
            _sep(),
            _action(playing ? 'frame_2085667691_e364f79f' : 'fluent_play_16_regular_858d43a9', playing ? 'Pause' : 'Play', onPlay),
            _sep(),
            _action('basil_share_outline_e39ef3fa', 'Share', onShare),
          ]),
        ),
      ]),
    );
  }

  Widget _sep() => Container(width: 1, height: 8, color: Colors.black);

  Widget _action(String icon, String label, VoidCallback? onTap) => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            FigIcon(icon, w: 16, h: 16),
            const SizedBox(width: 10),
            Text(label, style: ts(Ff.inter, 12, w500, AppColors.textSecondary, lh: 16)),
          ]),
        ),
      );
}

/// Surah hero card (343×196, r15.1) with the illustrated arch.
class SurahHeroCard extends StatelessWidget {
  const SurahHeroCard({super.key, required this.title, required this.subtitle, required this.summary, required this.badge});
  final String title;
  final String subtitle;
  final String summary;
  final String badge;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 196,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.1),
        child: Stack(fit: StackFit.expand, children: [
          Image.asset(AppImages.surahCard, fit: BoxFit.fill),
          const Positioned(left: 274.8, top: 46.5, child: FigIcon('at_icons_moon_98864fe5', w: 25.8, h: 25.8)),
          Positioned(
            left: 15.5,
            top: 15,
            width: 162,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 2.2),
                child: Text(title, style: ts(Ff.inter, 17.6, w600, Colors.white, lh: 30.9)),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 13.2),
                child: Opacity(opacity: 0.9, child: Text(subtitle, style: ts(Ff.inter, 11, w500, AppColors.green300, lh: 15.4, ls: -0.1))),
              ),
              Opacity(
                opacity: 0.9,
                child: SizedBox(
                  height: 72,
                  child: Text(summary, overflow: TextOverflow.fade, style: ts(Ff.inter, 8.8, w400, AppColors.green300, lh: 14.3)),
                ),
              ),
              const SizedBox(height: 13.2),
              Container(
                height: 18.9,
                padding: const EdgeInsets.symmetric(horizontal: 8.8),
                decoration: BoxDecoration(
                  color: fc(0x003B29, .2),
                  gradient: LinearGradient(colors: [fc(0xFFFFFF, .4), fc(0xFFFFFF, .1)]),
                  border: Border.all(color: fc(0xFFFFFF, .2), width: 0.6),
                  borderRadius: BorderRadius.circular(9999),
                ),
                alignment: Alignment.center,
                child: Text(badge, style: ts(Ff.inter, 6.6, w500, AppColors.green300, lh: 8.8, ls: 0.3)),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
