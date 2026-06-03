import 'package:flutter/material.dart';
import '../../../../services/mock_data_service.dart';
import '../../../home/presentation/widgets/animal_card.dart';
import 'package:go_router/go_router.dart';
import '../../../../routes/app_router.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  List _searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_performSearch);
  }

  void _performSearch() {
    final query = _searchController.text;
    setState(() {
      if (query.isEmpty) {
        _searchResults = [];
      } else {
        _searchResults = MockDataService.searchAnimals(query);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Animals')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Dog, Bangalore, breed...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty ? IconButton(icon: const Icon(Icons.clear), onPressed: () => _searchController.clear()) : null,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          if (_searchResults.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('${_searchResults.length} results found', style: Theme.of(context).textTheme.bodyMedium)],
              ),
            ),
          Expanded(
            child: _searchResults.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, size: 64, color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        Text('No animals found', style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: AnimalCard(
                        animal: _searchResults[index],
                        onTap: () => context.go('${Routes.animalDetails}/${_searchResults[index].id}'),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}