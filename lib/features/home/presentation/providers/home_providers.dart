import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/features/home/domain/entities/property.dart';
import 'package:flutter_application_1/features/home/domain/repositories/property_repository.dart';
import 'package:flutter_application_1/features/home/data/repositories/property_repository_impl.dart';

final propertyRepositoryProvider = Provider<PropertyRepository>((ref) {
  return MockPropertyRepository();
});

final propertiesFutureProvider = FutureProvider<List<Property>>((ref) {
  final repository = ref.watch(propertyRepositoryProvider);
  return repository.getProperties();
});

final categoriesProvider = Provider<List<String>>((ref) {
  return ['All', 'Apartment', 'Villa', 'Office', 'Studio', 'Penthouse'];
});

final selectedCategoryProvider = StateProvider<String>((ref) => 'All');

final searchQueryProvider = StateProvider<String>((ref) => '');


final priceRangeProvider = StateProvider<RangeValues>((ref) => const RangeValues(0, 20000000));
final bedroomsProvider = StateProvider<int>((ref) => 0);
final areaRangeProvider = StateProvider<RangeValues>((ref) => const RangeValues(0, 1000));

final filteredPropertiesProvider = Provider<AsyncValue<List<Property>>>((ref) {
  final propertiesAsync = ref.watch(propertiesFutureProvider);
  final selectedCategory = ref.watch(selectedCategoryProvider);
  final searchQuery = ref.watch(searchQueryProvider).toLowerCase();
  
  final priceRange = ref.watch(priceRangeProvider);
  final minBedrooms = ref.watch(bedroomsProvider);
  final areaRange = ref.watch(areaRangeProvider);

  return propertiesAsync.whenData((properties) {
    return properties.where((p) {
      final matchesCategory = selectedCategory == 'All' || p.type == selectedCategory;
      final matchesSearch = searchQuery.isEmpty || 
          p.title.toLowerCase().contains(searchQuery) || 
          p.address.toLowerCase().contains(searchQuery);
      
      final matchesPrice = p.price >= priceRange.start && p.price <= priceRange.end;
      final matchesBedrooms = p.bedrooms >= minBedrooms;
      final matchesArea = p.area >= areaRange.start && p.area <= areaRange.end;

      return matchesCategory && matchesSearch && matchesPrice && matchesBedrooms && matchesArea;
    }).toList();
  });
});



