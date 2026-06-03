import 'dart:math';
import '../core/models/animal_model.dart';

class MockDataService {
  static final List<Animal> mockAnimals = [
    Animal(
      id: '1',
      type: 'Dog',
      breed: 'Labrador',
      age: 24,
      gender: 'Male',
      price: 15000,
      negotiable: true,
      description: 'Friendly and well-trained Labrador. Very active and loves to play.',
      imageUrls: ['https://via.placeholder.com/300x300?text=Labrador'],
      city: 'Pune',
      state: 'Maharashtra',
      latitude: 18.5204,
      longitude: 73.8567,
      sellerId: 'seller1',
      sellerName: 'Rajesh Kumar',
      sellerRating: 4.5,
      vaccinated: true,
      vetChecked: true,
      featured: true,
      sold: false,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Animal(
      id: '2',
      type: 'Cat',
      breed: 'Persian',
      age: 12,
      gender: 'Female',
      price: 5000,
      negotiable: false,
      description: 'Beautiful Persian cat, very calm and affectionate.',
      imageUrls: ['https://via.placeholder.com/300x300?text=Persian+Cat'],
      city: 'Mumbai',
      state: 'Maharashtra',
      latitude: 19.0760,
      longitude: 72.8777,
      sellerId: 'seller2',
      sellerName: 'Priya Singh',
      sellerRating: 4.8,
      vaccinated: true,
      vetChecked: true,
      featured: false,
      sold: false,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Animal(
      id: '3',
      type: 'Goat',
      breed: 'Boer',
      age: 18,
      gender: 'Male',
      price: 12000,
      negotiable: true,
      description: 'Healthy Boer goat, suitable for farming or breeding.',
      imageUrls: ['https://via.placeholder.com/300x300?text=Boer+Goat'],
      city: 'Aurangabad',
      state: 'Maharashtra',
      latitude: 19.8762,
      longitude: 75.3433,
      sellerId: 'seller3',
      sellerName: 'Farmer Ramesh',
      sellerRating: 4.2,
      vaccinated: true,
      vetChecked: false,
      featured: false,
      sold: false,
      createdAt: DateTime.now(),
    ),
    Animal(
      id: '4',
      type: 'Cow',
      breed: 'Jersey',
      age: 36,
      gender: 'Female',
      price: 50000,
      negotiable: true,
      description: 'High milk-yielding Jersey cow. Perfect for dairy farming.',
      imageUrls: ['https://via.placeholder.com/300x300?text=Jersey+Cow'],
      city: 'Nashik',
      state: 'Maharashtra',
      latitude: 19.9975,
      longitude: 73.7898,
      sellerId: 'seller4',
      sellerName: 'Dairy Farm',
      sellerRating: 4.6,
      vaccinated: true,
      vetChecked: true,
      featured: true,
      sold: false,
      createdAt: DateTime.now().subtract(const Duration(hours: 3)),
    ),
  ];

  static List<Animal> getAnimals({String? city, String? type, int page = 1, int pageSize = 20}) {
    var filtered = mockAnimals;
    if (city != null && city.isNotEmpty) {
      filtered = filtered.where((a) => a.city.toLowerCase().contains(city.toLowerCase())).toList();
    }
    if (type != null && type.isNotEmpty) {
      filtered = filtered.where((a) => a.type.toLowerCase() == type.toLowerCase()).toList();
    }
    return filtered;
  }

  static Animal? getAnimalById(String id) {
    try {
      return mockAnimals.firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }

  static List<Animal> searchAnimals(String query) {
    if (query.isEmpty) return mockAnimals;
    return mockAnimals
        .where((a) => a.breed.toLowerCase().contains(query.toLowerCase()) || a.type.toLowerCase().contains(query.toLowerCase()) || a.city.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  static const List<String> animalTypes = ['Dog', 'Cat', 'Goat', 'Cow', 'Horse', 'Rabbit', 'Bird', 'Fish', 'Others'];
  static const List<String> indianStates = ['Maharashtra', 'Karnataka', 'Tamil Nadu', 'Telugu', 'Uttar Pradesh', 'Delhi', 'Rajasthan', 'Gujarat', 'Punjab', 'Haryana'];
}