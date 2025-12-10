class GifModel {
  final String id;
  final String title;
  final String imageUrl;

  GifModel({
    required this.id,
    required this.title,
    required this.imageUrl,
  });
  
  factory GifModel.fromJson(Map<String, dynamic> json) {
    return GifModel(
      id: json['id'],
      title: json['title'],
      imageUrl: json['images']['fixed_height']['url'],
    );
  }
}