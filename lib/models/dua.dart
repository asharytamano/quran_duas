class Dua {
  final int surahNumber;
  final String surahNameAr;
  final String surahNameEn;
  final int ayah;
  final String arabic;
  final String transliteration;
  final String translationEn;
  final List<String> tags;

  Dua({
    required this.surahNumber,
    required this.surahNameAr,
    required this.surahNameEn,
    required this.ayah,
    required this.arabic,
    required this.transliteration,
    required this.translationEn,
    required this.tags,
  });

  factory Dua.fromMap(Map<String, dynamic> m) => Dua(
    surahNumber: m['surah_number'],
    surahNameAr: m['surah_name_ar'],
    surahNameEn: m['surah_name_en'],
    ayah: m['ayah'],
    arabic: m['arabic'],
    transliteration: m['transliteration'],
    translationEn: m['translation_en'],
    tags: (m['tags'] as List).map((e) => e.toString()).toList(),
  );
}
