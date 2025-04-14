import 'package:ebookapp/app/modules/motivasi/controllers/motivasi_controller_drop.dart';
import 'package:ebookapp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ContentViewDrop extends GetView<MotivasiControllerDrop> {
  const ContentViewDrop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.clear_sharp, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Watermark.png'),
            fit: BoxFit.cover, // Mengatur gambar agar menutupi seluruh area
          ),
        ),
        child: Column(
          children: [
            // Gambar di bagian atas
            Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/Motivasi1.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 36),
            Text(
              'Motivasi',
              style: GoogleFonts.leagueSpartan(
                  fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(
              'By E.N.N. Sari',
              style: GoogleFonts.leagueSpartan(
                  fontSize: 12, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 37),
            Obx(() {
              // Pastikan controller.subcategories tidak null
              if (controller.subcategories == null) {
                return const Center(child: CircularProgressIndicator());
              }

              // Pastikan controller.searchQuery.value tidak null
              final searchQuery = controller.searchQuery.value ?? '';

              // Filter subcategories based on search query
              final filteredSubcategories =
                  controller.subcategories!.where((subcategory) {
                return subcategory.name
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase());
              }).toList();

              if (filteredSubcategories.isEmpty) {
                return const Center(child: Text("Konten tidak ada"));
              } else {
                return Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListView.builder(
                      itemCount: filteredSubcategories.length,
                      itemBuilder: (context, index) {
                        final subcategory = filteredSubcategories[index];
                        int contentCount = subcategory.contentsCount;

                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.contentViewPush,
                                arguments: subcategory);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 18),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${index + 1}. ${subcategory.name}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.chevron_right,
                                    color: Colors.black,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text("Page: $contentCount",
                                    style: GoogleFonts.leagueSpartan(
                                        fontSize: 15, color: Colors.black87)),
                              ),
                              const SizedBox(height: 10),
                              const Divider(color: Colors.black26, height: 1),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
