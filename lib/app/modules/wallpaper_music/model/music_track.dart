// MusicTrack model
class MusicTrack {
  final int id;
  final String title;
  final String fileUrl;

  MusicTrack({
    required this.id,
    required this.title,
    required this.fileUrl,
  });

  factory MusicTrack.fromJson(Map<String, dynamic> json) {
    return MusicTrack(
      id: json['id'],
      title: json['title'],
      fileUrl: json['file_url'],
    );
  }
}