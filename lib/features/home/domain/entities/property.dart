class Property {
  final String id;
  final String title;
  final String address;
  final double price;
  final String imageUrl;
  final int bedrooms;
  final int bathrooms;
  final double area;
  final String type;
  final bool isFavorite;

  Property({
    required this.id,
    required this.title,
    required this.address,
    required this.price,
    required this.imageUrl,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.type,
    this.isFavorite = false,
  });
}
