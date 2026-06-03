import 'package:flutter/material.dart';
import '../../../home/presentation/widgets/animal_card.dart';
import '../../../../services/mock_data_service.dart';
import 'package:go_router/go_router.dart';
import '../../../../routes/app_router.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final savedAnimals = MockDataService.mockAnimals.take(3).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Saved Listings')),
      body: savedAnimals.isEmpty
          ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.bookmark_border, size: 64, color: Colors.grey[300]), const SizedBox(height: 16), Text('No saved listings', style: Theme.of(context).textTheme.bodyLarge)]))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: savedAnimals.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: AnimalCard(
                  animal: savedAnimals[index],
                  onTap: () => context.go('${Routes.animalDetails}/${savedAnimals[index].id}'),
                ),
              ),
            ),
    );
  }
}