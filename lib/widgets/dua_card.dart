import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../models/dua.dart';
import '../providers/dua_provider.dart';
import '../widgets/arabic_text.dart';

class DuaCard extends StatefulWidget {
  final Dua dua;
  final VoidCallback? onTap;

  const DuaCard({super.key, required this.dua, this.onTap});

  @override
  State<DuaCard> createState() => _DuaCardState();
}

class _DuaCardState extends State<DuaCard> with SingleTickerProviderStateMixin {
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  late AnimationController _anim;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  Future<void> _toggleAudio() async {
    final context = this.context;
    if (_isPlaying) {
      await _player.stop();
      _anim.stop();
      setState(() => _isPlaying = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Audio stopped.')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Playing audio...')),
    );

    try {
      if (kIsWeb) {
        await _player.play(UrlSource(
            'https://everyayah.com/data/Hani_Rifai_192kbps/${widget.dua.audio}'));
      } else {
        final bytes =
        await rootBundle.load('assets/audio/${widget.dua.audio}');
        final dir = await getTemporaryDirectory();
        final file = File('${dir.path}/${widget.dua.audio}');
        await file.writeAsBytes(bytes.buffer.asUint8List(), flush: true);
        await _player.play(DeviceFileSource(file.path));
      }

      _anim.repeat(reverse: true);
      setState(() => _isPlaying = true);

      _player.onPlayerComplete.listen((_) {
        _anim.stop();
        setState(() => _isPlaying = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Audio finished.')),
        );
      });
    } catch (e) {
      _anim.stop();
      setState(() => _isPlaying = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading audio: $e')),
      );
    }
  }

  @override
  void dispose() {
    _anim.dispose();
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).colorScheme;
    final duaProv = Provider.of<DuaProvider>(context);
    final isFav = duaProv.isFavorite(widget.dua);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0A6A49), Color(0xFFB7D18A)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        color: Colors.white.withOpacity(0.85),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${widget.dua.surahNameEn} • Ayah ${widget.dua.ayah}',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .copyWith(color: c.primary),
                ),
                const SizedBox(height: 8),
                ArabicText(widget.dua.arabic,
                    fontSize: 26, align: TextAlign.right),
                const SizedBox(height: 8),
                Text(
                  widget.dua.translationEn,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  children:
                  widget.dua.tags.map((t) => Chip(label: Text(t))).toList(),
                ),
                const SizedBox(height: 6),

                // 🔘 Row of Icons (Favorite, Share, Play)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        isFav
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: isFav ? Colors.red : c.primary,
                      ),
                      tooltip: 'Favorite',
                      onPressed: () {
                        duaProv.toggleFavorite(widget.dua);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(isFav
                              ? 'Removed from Favorites'
                              : 'Added to Favorites'),
                        ));
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.share_rounded),
                      tooltip: 'Share Dua',
                      onPressed: () {
                        final shareText =
                            '${widget.dua.arabic}\n\n${widget.dua.translationEn}\n\n(${widget.dua.surahNameEn}:${widget.dua.ayah})';
                        Share.share(shareText);
                      },
                    ),
                    ScaleTransition(
                      scale: Tween(begin: 1.0, end: 1.2).animate(
                        CurvedAnimation(
                            parent: _anim, curve: Curves.easeInOut),
                      ),
                      child: IconButton(
                        iconSize: 32,
                        icon: Icon(
                          _isPlaying
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_fill,
                          color: c.primary,
                        ),
                        tooltip: _isPlaying ? 'Pause' : 'Play',
                        onPressed: _toggleAudio,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
