class SimpleProductRepository {
  final int id;
  final String name;
  final bool? isVisible;

  SimpleProductRepository({
    required this.id,
    required this.name,
    this.isVisible,
  });

  factory SimpleProductRepository.fromJson(Map<String, dynamic> json) {
    return SimpleProductRepository(
      id: json['id'] as int,
      name: json['name'] as String,
      isVisible: json['is_visible'] as bool?,
    );
  }
}
