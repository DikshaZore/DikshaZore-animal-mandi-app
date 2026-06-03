import 'package:flutter/material.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  final List<Map<String, String>> savedAnimals = [
    {
      'name': 'Cow',
      'price': '₹50,000',
      'location': 'Delhi',
    },
    {
      'name': 'Buffalo',
      'price': '₹75,000',
      'location': 'Punjab',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Animals'),
        centerTitle: true,
      ),
      body: savedAnimals.isEmpty
          ? const Center(
              child: Text('No saved animals yet'),
            )
          : ListView.builder(
              itemCount: savedAnimals.length,
              itemBuilder: (context, index) {
                final animal = savedAnimals[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.pets),
                    ),
                    title: Text(animal['name'] ?? ''),
                    subtitle: Text('${animal['location']} • ${animal['price']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.bookmark, color: Colors.blue),
                      onPressed: () {
                        setState(() {
                          savedAnimals.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Removed from saved')),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
