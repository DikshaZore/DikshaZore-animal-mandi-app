import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../services/mock_data_service.dart';
import '../../../../core/models/animal_model.dart';

class AnimalDetailsScreen extends StatefulWidget {
  final String animalId;
  const AnimalDetailsScreen({Key? key, required this.animalId}) : super(key: key);

  @override
  State<AnimalDetailsScreen> createState() => _AnimalDetailsScreenState();
}

class _AnimalDetailsScreenState extends State<AnimalDetailsScreen> {
  late Animal? animal;
  int _currentImageIndex = 0;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    animal = MockDataService.getAnimalById(widget.animalId);
  }

  void _callSeller() async {
    final url = 'tel:+919876543210';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  void _whatsappSeller() async {
    final url = 'https://wa.me/919876543210?text=Hi, I found your listing on AnimalMandi. I\'m interested in your ${animal!.breed} ${animal!.type}.';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (animal == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Animal Details')),
        body: const Center(child: Text('Animal not found')),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Image.network(animal!.imageUrls[_currentImageIndex], fit: BoxFit.cover, width: double.infinity, errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[300], child: const Center(child: Icon(Icons.image_not_supported)))),
                  Positioned(
                    top: MediaQuery.of(context).padding.top,
                    left: 16,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                      style: IconButton.styleFrom(backgroundColor: Colors.black26, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text('${animal!.breed} ${animal!.type}', style: Theme.of(context).textTheme.headlineLarge),
                      ),
                      IconButton(
                        icon: Icon(_isSaved ? Icons.bookmark : Icons.bookmark_border, color: const Color(0xFF2D8659), size: 28),
                        onPressed: () {
                          setState(() => _isSaved = !_isSaved);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_isSaved ? 'Added to saved' : 'Removed from saved')));
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('₹${animal!.price.toStringAsFixed(0)}', style: const TextStyle(fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xFF2D8659))),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Color(0xFF2D8659)),
                      const SizedBox(width: 8),
                      Text('${animal!.city}, ${animal!.state}', style: Theme.of(context).textTheme.bodyLarge),
                    ],
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: [
                      _buildDetailCard(context, 'Age', '${animal!.age} months'),
                      _buildDetailCard(context, 'Gender', animal!.gender),
                      _buildDetailCard(context, 'Vaccinated', animal!.vaccinated ? 'Yes' : 'No'),
                      _buildDetailCard(context, 'Vet Checked', animal!.vetChecked ? 'Yes' : 'No'),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text('Description', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 8),
                  Text(animal!.description, style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(child: ElevatedButton.icon(onPressed: _callSeller, icon: const Icon(Icons.phone), label: const Text('Call'), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2D8659)))),
            const SizedBox(width: 12),
            Expanded(child: ElevatedButton.icon(onPressed: _whatsappSeller, icon: const Icon(Icons.chat), label: const Text('WhatsApp'), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF25D366)))),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(BuildContext context, String label, String value) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE0E0E0)), borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: const Color(0xFF757575))),
          const SizedBox(height: 4),
          Text(value, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}