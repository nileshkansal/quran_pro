/// Sample content for the Dua and Virtues of Deeds screens (from the Figma
/// frames). Replace with the verified dataset before release.
class DuaItem {
  const DuaItem(this.title, this.arabicLines, this.meaning, this.reference);
  final String title;
  final List<String> arabicLines;
  final String meaning;
  final String reference;
}

class DuaCategory {
  const DuaCategory(this.title, this.items, {this.icon});
  final String title;
  final List<DuaItem> items;
  final String? icon;
}

const _enteringHome = DuaItem(
  'Entering the home',
  ['بِسْمِ اللهِ وَلَجْنَا،', 'وَبِسْمِ اللهِ خَرَجْنَا،', 'وَعَلَى اللهِ رَبِّنَا تَوَكَّلْنَا'],
  'In the name of Allah we enter, in the name of Allah we leave, and upon Allah, our Lord, we rely',
  'Abu Dawood (5096), At-Tirmidhi (3426).',
);

const List<DuaCategory> kDuaCategories = [
  DuaCategory('Morning Remembrance', []),
  DuaCategory('Evening Remembrance', []),
  DuaCategory('Waking Up & Sleeping', []),
  DuaCategory('Home & Daily Life', [
    _enteringHome,
    DuaItem('Leaving the home', ['بِسْمِ اللهِ، تَوَكَّلْتُ عَلَى اللهِ،', 'وَلَا حَوْلَ وَلَا قُوَّةَ إِلَّا بِاللهِ'],
        'In the name of Allah, I place my trust in Allah, and there is no might nor power except with Allah.', 'Abu Dawood (5095), At-Tirmidhi (3426).'),
    DuaItem('Getting dressed', ['الْحَمْدُ لِلَّهِ الَّذِي كَسَانِي هَذَا', 'وَرَزَقَنِيهِ مِنْ غَيْرِ حَوْلٍ مِنِّي وَلَا قُوَّةٍ'],
        'All praise is for Allah who has clothed me with this and provided it for me without any might or power from myself.', 'Abu Dawood (4023), At-Tirmidhi (3458).'),
    DuaItem('Wearing new clothes', ['اللَّهُمَّ لَكَ الْحَمْدُ أَنْتَ كَسَوْتَنِيهِ'], 'O Allah, for You is all praise, You have clothed me with it.',
        'Abu Dawood (4020), At-Tirmidhi (1767).'),
    DuaItem('Entering the bathroom', ['اللَّهُمَّ إِنِّي أَعُوذُ بِكَ', 'مِنَ الْخُبُثِ وَالْخَبَائِثِ'], 'O Allah, I seek refuge with You from all evil and evil-doers.',
        'Sahih al-Bukhari (142), Sahih Muslim (375).'),
    DuaItem('Leaving the bathroom', ['غُفْرَانَكَ'], 'I seek Your forgiveness.', 'Abu Dawood (30), At-Tirmidhi (7).'),
  ]),
  DuaCategory('Wudu & Purification', []),
  DuaCategory('Mosque & Prayer', []),
  DuaCategory('Witr & Night Prayer', []),
  DuaCategory('Food & Fasting', []),
  DuaCategory('Family & Children', []),
  DuaCategory('Health & Illness', []),
  DuaCategory('Anxiety, Hardship & Protection', []),
  DuaCategory('Travel', []),
  DuaCategory('Weather & Nature', []),
  DuaCategory('Death & Funeral', []),
  DuaCategory('Hajj & Umrah', []),
  DuaCategory('Social & Relationships', []),
  DuaCategory('Gratitude, Repentance & Dhikr', []),
];

class VirtueItem {
  const VirtueItem(this.title, this.icon, this.narrator, this.hadith, this.source);
  final String title;
  final String icon;
  final String narrator;
  final String hadith;
  final String source;
}

class VirtueCategory {
  const VirtueCategory(this.title, this.icon, this.iconW, this.items);
  final String title;
  final String icon;
  final double iconW;
  final List<VirtueItem> items;
}

const _congregation = VirtueItem(
  'Praying in Congregation',
  'overlay_a9c42b2e',
  'Narrated Abdullah bin Umar: Allah\'s Messenger ﷺ said:',
  'The prayer in congregation is twenty-seven times superior to the prayer offered by a person alone.',
  'Sahih al-Bukhari (645), Sahih Muslim (650)',
);

const List<VirtueCategory> kVirtueCategories = [
  VirtueCategory('Prayer & Mosque', 'fluent_building_mosque_12_fi_6dff1910', 16, [
    _congregation,
    VirtueItem('Walking to the Mosque', 'overlay_f9822c3e', 'Narrated Abu Hurairah: The Prophet ﷺ said:',
        'Whoever goes to the mosque in the morning or evening, Allah prepares for him a place in Paradise every time he goes.', 'Sahih al-Bukhari (662)'),
    VirtueItem('Waiting for Prayer', 'overlay_f54255ec', 'Narrated Abu Hurairah: The Prophet ﷺ said:',
        'One of you remains in prayer as long as he is waiting for the prayer.', 'Sahih al-Bukhari (659)'),
    VirtueItem('Praying Sunnah Prayers', 'overlay_3a90d514', 'Narrated Umm Habibah: The Prophet ﷺ said:',
        'Whoever prays twelve rak\'ahs in a day and night, a house will be built for him in Paradise.', 'Sahih Muslim (728)'),
    VirtueItem('Praying at Night', 'overlay_58f5df64', 'Narrated Abu Hurairah: The Prophet ﷺ said:',
        'The best prayer after the obligatory prayers is the night prayer.', 'Sahih Muslim (1163)'),
    VirtueItem('Maintaining the Prayer', 'overlay_611860a4', 'Narrated Abdullah bin Mas\'ud:',
        'I asked the Prophet ﷺ which deed is most loved by Allah. He said: Prayer at its proper time.', 'Sahih al-Bukhari (527)'),
  ]),
  VirtueCategory('Wudu & Purification', 'famicons_water_4623145b', 16, []),
  VirtueCategory('Character & Manners', 'fa6_solid_users_44baaabf', 20, []),
  VirtueCategory('Patience & Self-Control', 'fluent_leaf_two_20_filled_6613b6f4', 16, []),
  VirtueCategory('Dhikr & Remembrance', 'fluent_emoji_high_contrast_p_6d15ce37', 16, []),
  VirtueCategory('Charity & Helping Others', 'fa6_solid_hand_holding_heart_025b7e37', 18, []),
];
