import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../models/dua.dart';
import '../widgets/arabic_text.dart';

class DuaDetailScreen extends StatelessWidget {
  final Dua dua;
  const DuaDetailScreen({super.key, required this.dua});

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('${dua.surahNameEn}:${dua.ayah}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_rounded),
            onPressed: () {
              final shareText =
                  '${dua.arabic}\n\n${dua.transliteration}\n\n${dua.translationEn}\n\n(${dua.surahNameEn}:${dua.ayah})';
              Share.share(shareText);
            },
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 32),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: c.secondaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text('${dua.surahNameEn} • Ayah ${dua.ayah}'),
          ),
          const SizedBox(height: 16),
          ArabicText(dua.arabic, fontSize: 30, align: TextAlign.center),
          const SizedBox(height: 16),
          Text(
            dua.translationEn,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 10),
          Text(
            dua.transliteration,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: dua.tags.map((t) => Chip(label: Text(t))).toList(),
          ),
        ],
      ),
    );
  }
}
