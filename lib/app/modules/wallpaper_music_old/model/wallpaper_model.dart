// Wallpaper model
class Wallpaper {
  final int id;
  final String name;
  final String type;
  final String thumbnailUrl;
  final String fileUrl;

  Wallpaper({
    required this.id,
    required this.name,
    required this.type,
    required this.thumbnailUrl,
    required this.fileUrl,
  });

  factory Wallpaper.fromJson(Map<String, dynamic> json) {
    return Wallpaper(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      thumbnailUrl: json['thumbnail_url'],
      fileUrl: json['file_url'],
    );
  }
}