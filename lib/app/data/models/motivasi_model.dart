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
  final bool premium;
  final int contentsCount;

  Subcategory({
    required this.id,
    required this.name,
    required this.category,
    required this.categoryName,
    required this.isActive,
    required this.premium,
    required this.contentsCount,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      categoryName: json['category_name'] ?? '',
      isActive: json['is_active'] ?? false,
      premium: json['premium'] ?? true,
      contentsCount: json['contents_count'] ?? 0,
    );
  }
}

// class Motivasi {
//   final int id;
//   final int subcategoryId;
//   final String title;
//   final String createdAt;
//   final String updatedAt;
//   final ImageUrls imageUrls;
//   final Subcategory subcategory;

//   Motivasi({
//     required this.id,
//     required this.subcategoryId,
//     required this.title,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.imageUrls,
//     required this.subcategory,
//   });

//   factory Motivasi.fromJson(Map<String, dynamic> json) {
//     return Motivasi(
//       id: json['id'],
//       subcategoryId: json['subcategory_id'] ?? 0,
//       title: json['title'] ?? 'No Title',
//       createdAt: json['created_at'] ?? '',
//       updatedAt: json['updated_at'] ?? '',
//       imageUrls: ImageUrls.fromJson(json['image_urls'] ?? {}),
//       subcategory: Subcategory.fromJson(json['subcategory'] ?? {}),
//     );
//   }
// }

// class ImageUrls {
//   final String original;
//   final String optimized;
//   final List<ResponsiveImage> responsives;
//   final String alt;

//   ImageUrls({
//     required this.original,
//     required this.optimized,
//     required this.responsives,
//     required this.alt,
//   });

//   factory ImageUrls.fromJson(Map<String, dynamic> json) {
//     return ImageUrls(
//       original: json['original'] ?? '',
//       optimized: json['optimized'] ?? '',
//       responsives: (json['responsives'] as List<dynamic>?)
//               ?.map((e) => ResponsiveImage.fromJson(e))
//               .toList() ??
//           [],
//       alt: json['alt'] ?? '',
//     );
//   }
// }

// class ResponsiveImage {
//   final int width;
//   final int height;
//   final String url;

//   ResponsiveImage(
//       {required this.width, required this.height, required this.url});

//   factory ResponsiveImage.fromJson(Map<String, dynamic> json) {
//     return ResponsiveImage(
//       width: json['width'],
//       height: json['height'],
//       url: json['url'],
//     );
//   }
// }

// class Subcategory {
//   final int id;
//   final String name;
//   final String category;
//   final bool isActive;
//   final String categoryName;

//   Subcategory({
//     required this.id,
//     required this.name,
//     required this.category,
//     required this.isActive,
//     required this.categoryName,
//   });

//   factory Subcategory.fromJson(Map<String, dynamic> json) {
//     return Subcategory(
//       id: json['id'] ?? 0,
//       name: json['name'] ?? '',
//       category: json['category'] ?? '',
//       isActive: json['is_active'] ?? false,
//       categoryName: json['category_name'] ?? '',
//     );
//   }
// }
