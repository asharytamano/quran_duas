import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/dua_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/header_logo.dart';
import '../widgets/dua_card.dart';
import '../core/router.dart';
import '../models/dua.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String query = '';
  int _tabIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<DuaProvider>().load());
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final duaProv = context.watch<DuaProvider>();
    final list = query.isEmpty ? duaProv.all : duaProv.search(query);

    Widget bodyForAll() {
      return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: list.length + 1,
        itemBuilder: (context, i) {
          if (i == 0) return const HeaderLogo();
          final d = list[i - 1];
          return DuaCard(
            dua: d,
            isFavorite: duaProv.isFavorite(d),
            onToggleFav: () => duaProv.toggleFavorite(d),
            onTap: () => Navigator.pushNamed(context, AppRouter.duaDetail, arguments: d),
          );
        },
      );
    }

    Widget bodyForSurah() {
      final groups = duaProv.groupedBySurah();
      final keys = groups.keys.toList()..sort();
      return CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: HeaderLogo()),
          for (final k in keys) ...[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                child: Text(k, style: Theme.of(context).textTheme.titleLarge),
              ),
            ),
            SliverList.separated(
              itemCount: groups[k]!.length,
              itemBuilder: (context, idx) {
                final d = groups[k]![idx];
                return DuaCard(
                  dua: d,
                  isFavorite: duaProv.isFavorite(d),
                  onToggleFav: () => duaProv.toggleFavorite(d),
                  onTap: () => Navigator.pushNamed(context, AppRouter.duaDetail, arguments: d),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 0),
            ),
          ]
        ],
      );
    }

    Widget bodyForFav() {
      final favs = duaProv.favorites;
      if (favs.isEmpty) {
        return ListView(
          children: const [
            HeaderLogo(),
            SizedBox(height: 32),
            Center(child: Text('No favorites yet. Tap the heart to save a dua.')),
            SizedBox(height: 24),
          ],
        );
      }
      return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: favs.length + 1,
        itemBuilder: (context, i) {
          if (i == 0) return const HeaderLogo();
          final d = favs[i - 1];
          return DuaCard(
            dua: d,
            isFavorite: true,
            onToggleFav: () => context.read<DuaProvider>().toggleFavorite(d),
            onTap: () => Navigator.pushNamed(context, AppRouter.duaDetail, arguments: d),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Duas in the Qur’an'),
        actions: [
          IconButton(
            tooltip: settings.darkMode ? 'Light Mode' : 'Dark Mode',
            onPressed: settings.toggleDarkMode,
            icon: Icon(settings.darkMode ? Icons.wb_sunny_rounded : Icons.dark_mode_rounded),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.text_increase_rounded),
            onSelected: (v) {
              switch (v) {
                case 'Small': context.read<SettingsProvider>().setFontScale(0.9); break;
                case 'Normal': context.read<SettingsProvider>().setFontScale(1.0); break;
                case 'Large': context.read<SettingsProvider>().setFontScale(1.2); break;
              }
            },
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'Small', child: Text('Small text')),
              PopupMenuItem(value: 'Normal', child: Text('Normal text')),
              PopupMenuItem(value: 'Large', child: Text('Large text')),
            ],
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              onChanged: (v) => setState(() => query = v),
              decoration: InputDecoration(
                hintText: 'Search Arabic, transliteration, translation, or tags...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              ),
            ),
          ),
        ),
      ),
      body: MediaQuery(
        data: MediaQuery.of(context).copyWith(
          textScaleFactor: context.watch<SettingsProvider>().fontScale,
        ),
        child: IndexedStack(
          index: _tabIndex,
          children: [
            bodyForAll(),
            bodyForSurah(),
            bodyForFav(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tabIndex,
        onDestinationSelected: (i) => setState(() => _tabIndex = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.menu_book_rounded), label: 'All'),
          NavigationDestination(icon: Icon(Icons.list_alt_rounded), label: 'By Surah'),
          NavigationDestination(icon: Icon(Icons.favorite_rounded), label: 'Favorites'),
        ],
      ),
    );
  }
}
