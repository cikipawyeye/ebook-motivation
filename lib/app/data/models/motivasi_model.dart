class Motivasi {
  final int id;
  final String title;
  final ImageUrls imageUrls;
  final Subcategory subcategory;

  Motivasi({
    required this.id,
    required this.title,
    required this.imageUrls,
    required this.subcategory,
  });

  factory Motivasi.fromJson(Map<String, dynamic> json) {
    return Motivasi(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      imageUrls: ImageUrls.fromJson(json['image_urls']),
      subcategory: Subcategory.fromJson(json['subcategory']),
    );
  }
}

class ImageUrls {
  final String original;
  final String optimized; // URL gambar yang sudah dioptimasi
  final List<Responsives> responsives;
  final String alt;

  ImageUrls({
    required this.original,
    required this.optimized,
    required this.responsives,
    required this.alt,
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

class Subcategory {
  final int id;
  final String name;
  final String category;
  final String categoryName;
  final bool isActive;

  Subcategory({
    required this.id,
    required this.name,
    required this.category,
    required this.categoryName,
    required this.isActive,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      categoryName: json['category_name'] ?? '',
      isActive: json['is_active'] ?? false,
    );
  }
}