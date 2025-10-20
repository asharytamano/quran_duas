import 'package:flutter/material.dart';
import '../models/dua.dart';
import '../core/utils.dart';

class DuaProvider extends ChangeNotifier {
  final List<Dua> _all = [];
  final Set<String> _favorites = {}; // key: surah:ayah

  List<Dua> get all => List.unmodifiable(_all);
  List<Dua> get favorites => _all.where((d) => _favorites.contains(_key(d))).toList();

  Future<void> load() async {
    if (_all.isNotEmpty) return;
    final list = await loadJsonList('assets/data/duas.json');
    _all.addAll(list.map((m) => Dua.fromMap(m as Map<String, dynamic>)));
    notifyListeners();
  }

  Map<String, List<Dua>> groupedBySurah() {
    final map = <String, List<Dua>>{};
    for (final d in _all) {
      final key = '${d.surahNumber.toString().padLeft(3, '0')} • ${d.surahNameEn}';
      map.putIfAbsent(key, () => []).add(d);
    }
    return map;
  }

  List<Dua> search(String q) {
    final s = q.trim().toLowerCase();
    if (s.isEmpty) return all;
    return _all.where((d) {
      return d.surahNameEn.toLowerCase().contains(s) ||
          d.surahNameAr.contains(q) ||
          d.arabic.contains(q) ||
          d.transliteration.toLowerCase().contains(s) ||
          d.translationEn.toLowerCase().contains(s) ||
          d.tags.any((t) => t.toLowerCase().contains(s));
    }).toList();
  }

  void toggleFavorite(Dua d) {
    final k = _key(d);
    if (_favorites.contains(k)) {
      _favorites.remove(k);
    } else {
      _favorites.add(k);
    }
    notifyListeners();
  }

  bool isFavorite(Dua d) => _favorites.contains(_key(d));

  String _key(Dua d) => '${d.surahNumber}:${d.ayah}';
}
