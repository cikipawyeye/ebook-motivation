import 'package:cached_network_image/cached_network_image.dart';
import 'package:ebookapp/app/data/models/motivasi_model.dart';
import 'package:ebookapp/app/modules/motivasi/controllers/motivasi_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MotivationDetailPage extends StatelessWidget {
  final MotivasiController controller = Get.find<MotivasiController>();

  MotivationDetailPage({super.key});

  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token') ?? '';
  }

  String _getResponsiveImageUrl(
      List<Responsives> responsives, double screenWidth) {
    for (var responsive in responsives) {
      if (responsive.width >= screenWidth) {
        print("URL Gambar yang dipakai: ${responsive.url}");
        return responsive.url;
      }
    }
    print(
        "URL Gambar yang dipakai (fallback): ${responsives.isNotEmpty ? responsives.last.url : ''}");
    return responsives.isNotEmpty ? responsives.last.url : '';
  }

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments;

    print("Get.arguments: $arguments");

    int? id;
    if (arguments is Map<String, dynamic>) {
      id = arguments['id'] as int?;
    } else if (arguments is int) {
      id = arguments;
    }

    if (id == null) {
      return Scaffold(
        backgroundColor: Colors.white, // Background putih
        appBar: AppBar(title: const Text('Motivation Detail')),
        body: const Center(child: Text('Invalid argument: ID is missing')),
      );
    }

    controller.fetchMotivationDetail(id);
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white, // Background seluruh halaman menjadi putih
      appBar: AppBar(
        title: const Text('Motivation Detail'),
      ),
      body: Obx(() {
        if (controller.isDetailLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.motivasiDetail.value == null) {
          return const Center(child: Text('No data found'));
        } else {
          final motivasi = controller.motivasiDetail.value!;
          List<String> imageUrls = [
            motivasi.imageUrls.optimized,
            motivasi.imageUrls.original,
            ...motivasi.imageUrls.responsives.map((e) => e.url),
          ]
              .where((url) => url.isNotEmpty)
              .toList(); // Hanya menampilkan URL yang tidak kosong

          // Cek panjang imageUrls, jika lebih dari 0 lakukan loop
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    motivasi.title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  FutureBuilder<String>(
                    future: _getToken(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox(
                          height: 200,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else if (snapshot.hasError ||
                          !snapshot.hasData ||
                          snapshot.data!.isEmpty) {
                        return const SizedBox(
                          height: 200,
                          child: Center(child: Icon(Icons.error)),
                        );
                      } else {
                        final token = snapshot.data!;

                        // Cek apakah ada gambar untuk ditampilkan
                        if (imageUrls.isNotEmpty) {
                          // Looping gambar sesuai dengan jumlah ID yang ada
                          return Column(
                            children: List.generate(imageUrls.length, (index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: CachedNetworkImage(
                                  imageUrl: imageUrls[index],
                                  httpHeaders: {
                                    'Authorization': 'Bearer $token'
                                  },
                                  placeholder: (context, url) => const SizedBox(
                                    height: 200,
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const SizedBox(
                                    height: 200,
                                    child: Center(child: Icon(Icons.error)),
                                  ),
                                  fit: BoxFit
                                      .contain, // Gambar tetap proporsional
                                  width: double.infinity,
                                  height: 200,
                                  alignment:
                                      Alignment.center, // Gambar di tengah
                                  imageBuilder: (context, imageProvider) {
                                    return Image(
                                      image: imageProvider,
                                      fit: BoxFit
                                          .contain, // Menyesuaikan gambar agar tidak terpotong
                                    );
                                  },
                                ),
                              );
                            }),
                          );
                        } else {
                          return const Center(
                              child: Text('No images available.'));
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
