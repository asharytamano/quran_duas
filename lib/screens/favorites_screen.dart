import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/dua_provider.dart';
import '../widgets/dua_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final duaProv = context.watch<DuaProvider>();
    final favorites = duaProv.favorites;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0A6A49), Color(0xFFB7D18A)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Favorites'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: favorites.isEmpty
            ? const Center(
          child: Text(
            'No favorites yet.\nTap the heart ♥ icon to save a Dua.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        )
            : ListView.builder(
          padding:
          const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          itemCount: favorites.length,
          itemBuilder: (context, index) {
            final dua = favorites[index];
            return DuaCard(dua: dua);
          },
        ),
      ),
    );
  }
}
