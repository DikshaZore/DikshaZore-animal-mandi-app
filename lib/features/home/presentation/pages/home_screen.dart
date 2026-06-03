import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../services/mock_data_service.dart';
import '../../../../routes/app_router.dart';
import '../widgets/animal_card.dart';
import '../widgets/category_selector.dart';
import '../../search/presentation/pages/search_screen.dart';
import '../../post_animal/presentation/pages/post_animal_screen.dart';
import '../../saved/presentation/pages/saved_screen.dart';
import '../../profile/presentation/pages/profile_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String _selectedCategory = 'All';
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: _buildBody(),
        bottomNavigationBar: _buildBottomNav(),
      ),
    );
  }

  Widget _buildBody() {
    if (_currentIndex != 0) return _buildNavPage();

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('AnimalMandi'),
          centerTitle: true,
          backgroundColor: const Color(0xFF2D8659),
          elevation: 0,
          floating: true,
          snap: true,
          actions: [IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {})],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(hintText: 'Search animals...', prefixIcon: const Icon(Icons.search), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
              onTap: () => context.go(Routes.home),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: MockDataService.animalTypes.length,
                itemBuilder: (context, index) {
                  final type = MockDataService.animalTypes[index];
                  final isSelected = _selectedCategory == type;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedCategory = type),
                      child: CategoryCard(title: type, isSelected: isSelected),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('Featured Listings', style: Theme.of(context).textTheme.headlineSmall),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 12)),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final animals = MockDataService.mockAnimals.where((a) => a.featured).toList();
              if (animals.isEmpty) return const Padding(padding: EdgeInsets.all(16), child: Text('No featured'));
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: AnimalCard(
                  animal: animals[index],
                  onTap: () => context.go('${Routes.animalDetails}/${animals[index].id}'),
                ),
              );
            },
            childCount: MockDataService.mockAnimals.where((a) => a.featured).length,
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('Available Animals', style: Theme.of(context).textTheme.headlineSmall),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 12)),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final animals = _selectedCategory == 'All' ? MockDataService.mockAnimals : MockDataService.getAnimals(type: _selectedCategory);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: AnimalCard(
                  animal: animals[index],
                  onTap: () => context.go('${Routes.animalDetails}/${animals[index].id}'),
                ),
              );
            },
            childCount: _selectedCategory == 'All' ? MockDataService.mockAnimals.length : MockDataService.getAnimals(type: _selectedCategory).length,
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }

  Widget _buildNavPage() {
    switch (_currentIndex) {
      case 1:
        return const SearchScreen();
      case 2:
        return const PostAnimalScreen();
      case 3:
        return const SavedScreen();
      case 4:
        return const ProfileScreen();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) => setState(() => _currentIndex = index),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: 'Post'),
        BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Saved'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}