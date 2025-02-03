import 'package:ebookapp/app/data/models/motivasi_model.dart';
import 'package:ebookapp/app/modules/motivasi/controllers/content_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ContentView extends GetView<ContentController> {
  const ContentView({super.key});

  @override
  Widget build(BuildContext context) {
    Subcategory subcategory = Get.arguments;

    controller.fetchContents(subcategoryId: subcategory.id);

    return Scaffold(
      // appBar: AppBar(title: Text(subcategory.name)),
      appBar: AppBar(
        title: Text(
          subcategory.name,
          style: GoogleFonts.leagueSpartan(
            color: Colors.white,
            fontWeight: FontWeight.w700,
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
        if (controller.imageBytesList.isEmpty && controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.imageBytesList.isEmpty) {
          return Center(child: Text("No images available"));
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent &&
                controller.nextCursor.value != null) {
              controller.fetchContents(subcategoryId: subcategory.id);
            }
            return true;
          },
          child: PageView.builder(
            scrollDirection: Axis.vertical, // Scroll ke atas & bawah
            itemCount:
                subcategory.contentsCount > controller.imageBytesList.length
                    ? controller.imageBytesList.length + 1
                    : controller.imageBytesList.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  // Gambar Fullscreen
                  Positioned.fill(
                    child: index >= controller.imageBytesList.length ||
                            controller.imageBytesList[index].value == null
                        ? Center(child: CircularProgressIndicator())
                        : Image.memory(
                            controller.imageBytesList[index].value!,
                            fit: BoxFit.contain,
                          ),
                  ),
                  /**
                   *  Overlay konten seperti teks atau tombol
                   * TODO: Konfirmasi apakah perlu ditambahkan overlay konten 
                   * sebagai penanda nomor halaman atau langsung dari gambar
                   */
                  Positioned(
                    bottom: 100,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          "(${index + 1})",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        );
      }),
    );
  }
}
