import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../../services/mock_data_service.dart';

class PostAnimalScreen extends StatefulWidget {
  const PostAnimalScreen({Key? key}) : super(key: key);

  @override
  State<PostAnimalScreen> createState() => _PostAnimalScreenState();
}

class _PostAnimalScreenState extends State<PostAnimalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _imagePicker = ImagePicker();
  String? _animalType;
  String? _breed;
  int? _age;
  String? _gender;
  double? _price;
  bool _negotiable = true;
  String? _city;
  String? _state;
  String? _description;
  bool _vaccinated = false;
  bool _vetChecked = false;
  List<XFile>? _images;

  void _pickImages() async {
    final List<XFile> images = await _imagePicker.pickMultiImage(maxWidth: 1200, maxHeight: 1200, imageQuality: 80) ?? [];
    if (images.length > 10) images.removeRange(10, images.length);
    setState(() => _images = images);
  }

  void _publishListing() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Animal listing published successfully!'), duration: Duration(seconds: 2)));
      Future.delayed(const Duration(seconds: 2), () => Navigator.pop(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post Animal'), elevation: 0),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Post Your Animal', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text('Publish in 2 minutes', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: const Color(0xFF757575))),
              const SizedBox(height: 24),
              DropdownButtonFormField<String>(
                value: _animalType,
                decoration: const InputDecoration(labelText: 'Animal Type'),
                items: MockDataService.animalTypes.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (value) => setState(() => _animalType = value),
                validator: (value) => value == null ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Breed'),
                onChanged: (value) => _breed = value,
                validator: (value) => (value?.isEmpty ?? true) ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Age (months)'),
                keyboardType: TextInputType.number,
                onChanged: (value) => _age = int.tryParse(value),
                validator: (value) => (value?.isEmpty ?? true) ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _gender,
                decoration: const InputDecoration(labelText: 'Gender'),
                items: ['Male', 'Female', 'Not Sure'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (value) => setState(() => _gender = value),
                validator: (value) => value == null ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price (₹)', prefixText: '₹ '),
                keyboardType: TextInputType.number,
                onChanged: (value) => _price = double.tryParse(value),
                validator: (value) => (value?.isEmpty ?? true) ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              CheckboxListTile(title: const Text('Negotiable'), value: _negotiable, onChanged: (value) => setState(() => _negotiable = value ?? false)),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'City'),
                onChanged: (value) => _city = value,
                validator: (value) => (value?.isEmpty ?? true) ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _state,
                decoration: const InputDecoration(labelText: 'State'),
                items: MockDataService.indianStates.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (value) => setState(() => _state = value),
                validator: (value) => value == null ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description', hintText: 'Describe the animal...'),
                maxLines: 4,
                onChanged: (value) => _description = value,
                validator: (value) => (value?.isEmpty ?? true) ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              CheckboxListTile(title: const Text('Vaccinated'), value: _vaccinated, onChanged: (value) => setState(() => _vaccinated = value ?? false)),
              CheckboxListTile(title: const Text('Vet Checked'), value: _vetChecked, onChanged: (value) => setState(() => _vetChecked = value ?? false)),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(border: Border.all(color: const Color(0xFFE0E0E0)), borderRadius: BorderRadius.circular(8)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Icon(Icons.image_not_supported, size: 48, color: Colors.grey[400]),
                          const SizedBox(height: 12),
                          Text('Upload 2–10 images', style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 8),
                          Text('${_images?.length ?? 0} images selected', style: Theme.of(context).textTheme.bodySmall),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(onPressed: _pickImages, icon: const Icon(Icons.add_a_photo), label: const Text('Pick Images')),
                        ],
                      ),
                    ),
                    if (_images != null && _images!.isNotEmpty)
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _images!.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8),
                            child: Image.file(File(_images![index].path), fit: BoxFit.cover),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: _publishListing, child: const Text('Publish Listing'))),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}