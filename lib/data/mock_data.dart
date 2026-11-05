import 'package:flutter/material.dart';

class Surah {
  const Surah(this.number, this.name, this.meaning, this.arabic, this.verses, this.place);
  final int number;
  final String name;
  final String meaning;
  final String arabic;
  final int verses;
  final String place;
}

const List<Surah> kSurahs = [
  Surah(1, 'Al-Fatihah', 'The Opening', 'الفاتحة', 7, 'Makkah'),
  Surah(2, 'Al-Baqarah', 'The Cow', 'البقرة', 286, 'Madinah'),
  Surah(3, 'Āl-‘Imrān', 'The Family of Imran', 'آل عمران', 200, 'Madinah'),
  Surah(4, 'An-Nisā’', 'The Women', 'النساء', 176, 'Madinah'),
  Surah(5, 'Al-Mā’idah', 'The Table Spread', 'المائدة', 120, 'Madinah'),
  Surah(6, 'Al-An‘ām', 'The Cattle', 'الأنعام', 165, 'Makkah'),
  Surah(7, 'Al-A‘rāf', 'The Heights', 'الأعراف', 206, 'Makkah'),
  Surah(8, 'Al-Anfāl', 'The Spoils of War', 'الأنفال', 75, 'Madinah'),
  Surah(9, 'At-Tawbah', 'The Repentance', 'التوبة', 129, 'Madinah'),
  Surah(10, 'Yūnus', 'Jonah', 'يونس', 109, 'Makkah'),
  Surah(18, 'Al-Kahf', 'The Cave', 'الكهف', 110, 'Makkah'),
  Surah(36, 'Yā-Sīn', 'Ya Sin', 'يس', 83, 'Makkah'),
  Surah(55, 'Ar-Raḥmān', 'The Most Merciful', 'الرحمن', 78, 'Madinah'),
  Surah(56, 'Al-Wāqi‘ah', 'The Inevitable', 'الواقعة', 96, 'Makkah'),
  Surah(67, 'Al-Mulk', 'The Sovereignty', 'الملك', 30, 'Makkah'),
];

class Verse {
  const Verse(this.number, this.arabic, this.translation);
  final int number;
  final String arabic;
  final String translation;
}

const String kAyah21Arabic =
    'يَا أَيُّهَا النَّاسُ اعْبُدُوا رَبَّكُمُ الَّذِي خَلَقَكُمْ وَالَّذِينَ مِنْ قَبْلِكُمْ لَعَلَّكُمْ تَتَّقُونَ';
const String kAyah21Translation = 'O mankind, worship your Lord, who created you and those before you, that you may become righteous -';

const List<Verse> kBaqarahVerses = [
  Verse(21, kAyah21Arabic, kAyah21Translation),
  Verse(
    22,
    'الَّذِي جَعَلَ لَكُمُ الْأَرْضَ فِرَاشًا وَالسَّمَاءَ بِنَاءً وَأَنزَلَ مِنَ السَّمَاءِ مَاءً فَأَخْرَجَ بِهِ مِنَ الثَّمَرَاتِ رِزْقًا لَّكُمْ',
    '[He] who made for you the earth a bed [spread out] and the sky a ceiling and sent down from the sky, rain and brought forth thereby fruits as provision for you.',
  ),
  Verse(
    23,
    'وَإِن كُنتُمْ فِي رَيْبٍ مِّمَّا نَزَّلْنَا عَلَىٰ عَبْدِنَا فَأْتُوا بِسُورَةٍ مِّن مِّثْلِهِ',
    'And if you are in doubt about what We have sent down upon Our Servant, then produce a surah the like thereof.',
  ),
  Verse(
    24,
    'فَإِن لَّمْ تَفْعَلُوا وَلَن تَفْعَلُوا فَاتَّقُوا النَّارَ الَّتِي وَقُودُهَا النَّاسُ وَالْحِجَارَةُ',
    'But if you do not - and you will never be able to - then fear the Fire, whose fuel is men and stones.',
  ),
];

const String kBaqarahSummary =
    'The longest Surah of the Quran, encompassing vast foundational principles of faith, divine laws, and the historic narratives of previous nations to guide the believers.';

const String kTafsirAiSummary =
    'This verse is a fundamental call to all of humanity to worship Allah alone, the One who created them and all those who came before them. The purpose of creation is so that we may develop consciousness of Allah (Taqwa). It emphasizes the oneness of Allah, the universality of the message, and the ultimate goal of human life.';

const String kTafsirIbnKathir =
    'Allah – may He be exalted – says,\n“O mankind! Worship your Lord, who created you and those before you, that you may become righteous.”\n'
    'Allah addresses all of mankind – Arabs and non-Arabs, believers and disbelievers – with this comprehensive and general address, commanding them to worship their Lord alone, without associating anything with Him.\n'
    '“Who created you” – that is, He originated you from nothing, then gave you form, provided for you, and perfected His creation of you.\n'
    '“And those before you” – meaning, He created the generations that came before you, such as Prophet Adam, Noah, Abraham, and others.\n'
    '“That you may become righteous (muttaqoon).” – The purpose of creating mankind and sending Messengers is that they worship Allah alone and develop Taqwa by obeying His commands and avoiding His prohibitions.';

/// Surah Al-Mulk 1–11 for the Mushaf (Arabic reading) page.
const List<Verse> kMulkVerses = [
  Verse(
    1,
    'تَبَٰرَكَ ٱلَّذِى بِيَدِهِ ٱلۡمُلۡكُ وَهُوَ عَلَىٰ كُلِّ شَىۡءٍ قَدِيرٌ',
    'Blessed is He in whose hand is dominion, and He is over all things competent.',
  ),
  Verse(
    2,
    'ٱلَّذِى خَلَقَ ٱلۡمَوۡتَ وَٱلۡحَيَوٰةَ لِيَبۡلُوَكُمۡ أَيُّكُمۡ أَحۡسَنُ عَمَلًا ۚ وَهُوَ ٱلۡعَزِيزُ ٱلۡغَفُورُ',
    'He who created death and life that He may test you [as to] which of you is best in deed - and He is the Exalted in Might, the Forgiving.',
  ),
  Verse(
    3,
    'ٱلَّذِى خَلَقَ سَبۡعَ سَمَٰوَٰتٍ طِبَاقًا ۖ مَّا تَرَىٰ فِى خَلۡقِ ٱلرَّحۡمَٰنِ مِن تَفَٰوُتٍ ۖ فَٱرۡجِعِ ٱلۡبَصَرَ هَلۡ تَرَىٰ مِن فُطُورٍ',
    '[And] who created seven heavens in layers. You do not see in the creation of the Most Merciful any inconsistency. So return [your] vision [to the sky]; do you see any breaks?',
  ),
  Verse(
    4,
    'ثُمَّ ٱرۡجِعِ ٱلۡبَصَرَ كَرَّتَيۡنِ يَنقَلِبۡ إِلَيۡكَ ٱلۡبَصَرُ خَاسِئًا وَهُوَ حَسِيرٌ',
    'Then return [your] vision twice again. [Your] vision will return to you humbled while it is fatigued.',
  ),
  Verse(
    5,
    'وَلَقَدۡ زَيَّنَّا ٱلسَّمَآءَ ٱلدُّنۡيَا بِمَصَٰبِيحَ وَجَعَلۡنَٰهَا رُجُومًا لِّلشَّيَٰطِينِ ۖ وَأَعۡتَدۡنَا لَهُمۡ عَذَابَ ٱلسَّعِيرِ',
    'And We have certainly beautified the nearest heaven with stars and have made [from] them what is thrown at the devils and have prepared for them the punishment of the Blaze.',
  ),
  Verse(
    6,
    'وَلِلَّذِينَ كَفَرُواْ بِرَبِّهِمۡ عَذَابُ جَهَنَّمَ ۖ وَبِئۡسَ ٱلۡمَصِيرُ',
    'And for those who disbelieved in their Lord is the punishment of Hell, and wretched is the destination.',
  ),
  Verse(
    7,
    'إِذَآ أُلۡقُواْ فِيهَا سَمِعُواْ لَهَا شَهِيقًا وَهِىَ تَفُورُ',
    'When they are thrown into it, they hear from it a [dreadful] inhaling while it boils up.',
  ),
  Verse(
    8,
    'تَكَادُ تَمَيَّزُ مِنَ ٱلۡغَيۡظِ ۖ كُلَّمَآ أُلۡقِىَ فِيهَا فَوۡجٌ سَأَلَهُمۡ خَزَنَتُهَآ أَلَمۡ يَأۡتِكُمۡ نَذِيرٌ',
    'It almost bursts with rage. Every time a company is thrown into it, its keepers ask them, "Did there not come to you a warner?"',
  ),
  Verse(
    9,
    'قَالُواْ بَلَىٰ قَدۡ جَآءَنَا نَذِيرٌ فَكَذَّبۡنَا وَقُلۡنَا مَا نَزَّلَ ٱللَّهُ مِن شَىۡءٍ إِنۡ أَنتُمۡ إِلَّا فِى ضَلَٰلٍ كَبِيرٍ',
    'They will say, "Yes, a warner had come to us, but we denied and said, \'Allah has not sent down anything. You are not but in great error.\'"',
  ),
  Verse(
    10,
    'وَقَالُواْ لَوۡ كُنَّا نَسۡمَعُ أَوۡ نَعۡقِلُ مَا كُنَّا فِىٓ أَصۡحَٰبِ ٱلسَّعِيرِ',
    'And they will say, "If only we had been listening or reasoning, we would not be among the companions of the Blaze."',
  ),
  Verse(
    11,
    'فَٱعۡتَرَفُواْ بِذَنۢبِهِمۡ فَسُحۡقًا لِّأَصۡحَٰبِ ٱلسَّعِيرِ',
    'And they will admit their sin, so [it is] alienation for the companions of the Blaze.',
  ),
];

class PrayerTime {
  const PrayerTime(this.name, this.time, this.icon, {this.notify = true, this.serif = false});
  final String name;
  final String time;
  final IconData icon;
  final bool notify;
  final bool serif;
}

const List<PrayerTime> kPrayerTimes = [
  PrayerTime('Fajr', '04:55 AM', Icons.wb_twilight_rounded),
  PrayerTime('Sunrise', '06:15 AM', Icons.wb_sunny_outlined, notify: false, serif: true),
  PrayerTime('Dhuhr', '12:32 PM', Icons.light_mode_rounded),
  PrayerTime('Asr', '03:58 PM', Icons.brightness_5_outlined),
  PrayerTime('Maghrib', '06:45 PM', Icons.wb_twilight_outlined),
  PrayerTime('Isha', '08:02 PM', Icons.nightlight_round),
];

enum AchievementStatus { completed, inProgress, locked }

class Reciter {
  const Reciter(this.name, this.arabicMark, this.subtitle);
  final String name;
  final String arabicMark;
  final String subtitle;
}

const List<Reciter> kReciters = [
  Reciter('Mishary Rashid Alafasy', 'مشاري', 'مشاري بن راشد العفاسي • Murattal • Clear & Melodic'),
  Reciter('Abdul Rahman Al-Sudais', 'سديس', 'Grand Mosque of Makkah • Emotional'),
  Reciter('Abu Bakr Al-Shatri', 'شاطري', "Hafs 'an 'Asim • Calm & Reverent"),
  Reciter('Saad Al-Ghamdi', 'غامدي', 'Deep & Contemplative'),
  Reciter('Maher Al-Muaiqly', 'معيقلي', 'Imam of Masjid Al-Haram'),
];

const List<String> kLanguages = ['English', 'العربية', 'हिन्दी', 'اردو', 'Bahasa Indonesia', 'Türkçe', 'Français', 'বাংলা'];

const List<String> kTranslators = [
  'Saheeh International',
  'Pickthall',
  'Yusuf Ali',
  'Dr. Mustafa Khattab (The Clear Quran)',
  'Muhsin Khan',
];

const List<String> kCities = [
  'Chennai, Tamil Nadu, India',
  'Mumbai, Maharashtra, India',
  'Delhi, India',
  'Hyderabad, Telangana, India',
  'Bengaluru, Karnataka, India',
  'Makkah, Saudi Arabia',
  'Madinah, Saudi Arabia',
  'Dubai, United Arab Emirates',
  'Istanbul, Türkiye',
  'London, United Kingdom',
  'Karachi, Pakistan',
  'Dhaka, Bangladesh',
  'Jakarta, Indonesia',
];
