import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:share_plus/share_plus.dart';
import '../models/dua.dart';
import '../widgets/arabic_text.dart';

class DuaDetailScreen extends StatefulWidget {
  final Dua dua;
  const DuaDetailScreen({super.key, required this.dua});

  @override
  State<DuaDetailScreen> createState() => _DuaDetailScreenState();
}

class _DuaDetailScreenState extends State<DuaDetailScreen>
    with SingleTickerProviderStateMixin {
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
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Audio stopped.')));
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
        // Load from assets, write to temp, then play
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

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.dua.surahNameEn}:${widget.dua.ayah}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_rounded),
            onPressed: () {
              final shareText =
                  '${widget.dua.arabic}\n\n${widget.dua.translationEn}\n\n(${widget.dua.surahNameEn}:${widget.dua.ayah})';
              Share.share(shareText);
            },
          ),
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
            child: Text('${widget.dua.surahNameEn} • Ayah ${widget.dua.ayah}'),
          ),
          const SizedBox(height: 16),
          ArabicText(widget.dua.arabic, fontSize: 30, align: TextAlign.center),
          const SizedBox(height: 20),

          // 🎧 Animated Play Button
          Center(
            child: ScaleTransition(
              scale: Tween(begin: 1.0, end: 1.2)
                  .animate(CurvedAnimation(parent: _anim, curve: Curves.easeInOut)),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _toggleAudio,
                icon: Icon(
                    _isPlaying ? Icons.pause_circle : Icons.play_circle_outline),
                label: Text(_isPlaying ? "Pause Audio" : "Play Audio"),
              ),
            ),
          ),

          const SizedBox(height: 24),
          Text(
            widget.dua.translationEn,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: widget.dua.tags.map((t) => Chip(label: Text(t))).toList(),
          ),
        ],
      ),
    );
  }
}
