import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../models/dua.dart';
import '../widgets/arabic_text.dart';

class DuaCard extends StatelessWidget {
  final Dua dua;
  final VoidCallback onTap;
  final bool isFavorite;
  final VoidCallback onToggleFav;

  const DuaCard({
    super.key,
    required this.dua,
    required this.onTap,
    required this.isFavorite,
    required this.onToggleFav,
  });

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Surah + Ayah line
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: c.secondaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${dua.surahNameEn} • ${dua.ayah}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    tooltip: 'Share',
                    icon: const Icon(Icons.share_rounded),
                    onPressed: () {
                      final shareText =
                          '${dua.arabic}\n\n${dua.transliteration}\n\n${dua.translationEn}\n\n(${dua.surahNameEn}:${dua.ayah})';
                      Share.share(shareText);
                    },
                  ),
                  IconButton(
                    tooltip: isFavorite ? 'Remove from Favorites' : 'Add to Favorites',
                    onPressed: onToggleFav,
                    icon: Icon(isFavorite ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                        color: isFavorite ? c.primary : null),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ArabicText(dua.arabic, fontSize: 24),
              const SizedBox(height: 10),
              Text(
                dua.translationEn,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 6),
              Text(
                dua.transliteration,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: -6,
                children: [
                  for (final t in dua.tags)
                    Chip(
                      label: Text(t),
                      visualDensity: VisualDensity.compact,
                      side: BorderSide.none,
                      backgroundColor: c.surfaceContainerHighest.withOpacity(0.6),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
