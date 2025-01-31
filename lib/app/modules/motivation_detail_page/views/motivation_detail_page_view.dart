import 'dart:typed_data';
import 'package:ebookapp/app/modules/motivasi/controllers/motivasi_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MotivationDetailPage extends GetView<MotivasiController> {
  const MotivationDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Motivasi Detail',
          style: GoogleFonts.leagueSpartan(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF32497B),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          debugPrint('⏳ Loading motivasi detail...');
          return const Center(child: CircularProgressIndicator());
        }

        // Memastikan motivasiDetail tidak null
        if (controller.motivasiDetail.value == null) {
          debugPrint('⚠️ Motivasi detail tidak ditemukan!');
          return const Center(
            child: Text('Detail motivasi tidak ditemukan'),
          );
        }

        // Memastikan imageUrls tidak null
        var imageUrls = controller.motivasiDetail.value!.imageUrls;

        // Memilih gambar responsif dengan ukuran terbaik
        String imageUrl = '';
        if (imageUrls.optimized.isNotEmpty) {
          imageUrl = imageUrls.optimized;
          debugPrint('✅ Menggunakan gambar optimized: $imageUrl');
        } else if (imageUrls.original.isNotEmpty) {
          imageUrl = imageUrls.original;
          debugPrint('✅ Menggunakan gambar original: $imageUrl');
        } else if (imageUrls.responsives.isNotEmpty) {
          imageUrl = imageUrls
              .responsives.first.url; // Ambil gambar pertama jika ada responsif
          debugPrint('✅ Menggunakan gambar responsif pertama: $imageUrl');
        }

        // Debug log untuk URL gambar yang terpilih
        debugPrint('🖼 Image URL terpilih: $imageUrl');

        // Jika imageUrl masih kosong, tampilkan pesan error
        if (imageUrl.isEmpty) {
          debugPrint('❌ Gambar tidak ditemukan, URL kosong!');
          return const Center(
            child: Icon(Icons.error, color: Colors.red, size: 50),
          );
        }

        // Ambil gambar yang telah diunduh dan simpan dalam controller
        return Obx(() {
          Uint8List? imageBytes = controller.imageBytesList.isNotEmpty
              ? controller.imageBytesList[0].value // Ambil gambar pertama
              : null;

          return imageBytes != null
              ? Image.memory(
                  imageBytes,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 250, // Ganti sesuai dengan kebutuhan
                )
              : Center(
                  child: LoadingAnimationWidget.flickr(
                    rightDotColor: Colors.black,
                    leftDotColor: const Color(0xfffd0079),
                    size: 35,
                  ),
                );
        });
      }),
    );
  }
}
