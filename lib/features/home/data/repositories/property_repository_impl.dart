import 'package:flutter_application_1/features/home/domain/entities/property.dart';
import 'package:flutter_application_1/features/home/domain/repositories/property_repository.dart';

class MockPropertyRepository implements PropertyRepository {
  final List<Property> _mockProperties = [
    Property(
      id: '1',
      title: 'Modern Luxury Villa',
      address: 'New Cairo, Egypt',
      price: 12500000,
      imageUrl: 'https://images.unsplash.com/photo-1613490493576-7fde63acd811?q=80&w=2071&auto=format&fit=crop',
      bedrooms: 5,
      bathrooms: 4,
      area: 450,
      type: 'Villa',
      isFavorite: true,
    ),
    Property(
      id: '2',
      title: 'Skyview Apartment',
      address: 'Sheikh Zayed, Egypt',
      price: 4500000,
      imageUrl: 'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?q=80&w=2070&auto=format&fit=crop',
      bedrooms: 3,
      bathrooms: 2,
      area: 180,
      type: 'Apartment',
    ),
    Property(
      id: '3',
      title: 'Ocean Breeze Penthouse',
      address: 'North Coast, Egypt',
      price: 8900000,
      imageUrl: 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?q=80&w=2070&auto=format&fit=crop',
      bedrooms: 4,
      bathrooms: 3,
      area: 320,
      type: 'Penthouse',
    ),
    Property(
      id: '4',
      title: 'Business Center Office',
      address: 'New Cairo, Egypt',
      price: 15000000,
      imageUrl: 'https://images.unsplash.com/photo-1497366216548-37526070297c?q=80&w=2069&auto=format&fit=crop',
      bedrooms: 0,
      bathrooms: 2,
      area: 250,
      type: 'Office',
    ),
    Property(
      id: '5',
      title: 'Cozy Smart Studio',
      address: 'Maadi, Egypt',
      price: 2800000,
      imageUrl: 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?q=80&w=1980&auto=format&fit=crop',

      bedrooms: 1,
      bathrooms: 1,
      area: 65,
      type: 'Studio',
    ),
  ];


  @override
  Future<List<Property>> getProperties() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network lag
    return _mockProperties;
  }

  @override
  Future<Property> getPropertyById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockProperties.firstWhere((p) => p.id == id);
  }

  @override
  Future<List<Property>> searchProperties(String query) async {
    await Future.delayed(const Duration(seconds: 1));
    return _mockProperties.where((p) => 
      p.title.toLowerCase().contains(query.toLowerCase()) || 
      p.address.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }
}
