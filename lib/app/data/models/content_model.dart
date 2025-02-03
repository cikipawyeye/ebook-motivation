class Content {
  final int id;
  final String title;
  final ImageUrls imageUrls;
  final int subcategoryId;

  Content({
    required this.id,
    required this.title,
    required this.imageUrls,
    required this.subcategoryId,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      imageUrls: ImageUrls.fromJson(json['image_urls']),
      subcategoryId: json['subcategory_id'],
    );
  }
}

class ImageUrls {
  final String alt;
  final String original;
  final String optimized; // URL gambar yang sudah dioptimasi
  final List<Responsives>? responsives;

  ImageUrls({
    required this.alt,
    required this.original,
    required this.optimized,
    this.responsives,
  });

  factory ImageUrls.fromJson(Map<String, dynamic> json) {
    var responsivesList = <Responsives>[];
    if (json['responsives'] != null) {
      responsivesList = (json['responsives'] as List)
          .map((i) => Responsives.fromJson(i))
          .toList();
    }
    return ImageUrls(
      original: json['original'] ?? '',
      optimized: json['optimized'] ?? '',
      responsives: responsivesList,
      alt: json['alt'] ?? '',
    );
  }
}

class Responsives {
  final int width;
  final int height;
  final String url;

  Responsives({
    required this.width,
    required this.height,
    required this.url,
  });

  factory Responsives.fromJson(Map<String, dynamic> json) {
    return Responsives(
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
      url: json['url'] ?? '',
    );
  }
}
