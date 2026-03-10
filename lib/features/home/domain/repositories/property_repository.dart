import 'package:flutter_application_1/features/home/domain/entities/property.dart';

abstract class PropertyRepository {
  Future<List<Property>> getProperties();
  Future<Property> getPropertyById(String id);
  Future<List<Property>> searchProperties(String query);
}
