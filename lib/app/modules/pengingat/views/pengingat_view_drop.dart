import 'package:ebookapp/app/data/models/motivasi_model.dart';
import 'package:ebookapp/app/modules/pengingat/controllers/pengingat_category_controller.dart';
import 'package:ebookapp/app/modules/pengingat/controllers/pengingat_category_drop.dart';
import 'package:ebookapp/app/modules/settings/controllers/setting_theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PengingatViewDrop extends GetView<PengingatIdControllerDrop> {
  const PengingatViewDrop({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
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
                    image: AssetImage("assets/images/Pengingat1.png"),
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
                // Filter subcategories based on search query
                final filteredSubcategories =
                    controller.subcategories.where((subcategory) {
                  return subcategory.name
                      .toLowerCase()
                      .contains(controller.searchQuery.value.toLowerCase());
                }).toList();

                if (filteredSubcategories.isEmpty) {
                  return const Center(child: Text("Konten tidak ada"));
                } else {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredSubcategories.length,
                      itemBuilder: (context, index) {
                        final subcategory = filteredSubcategories[index];

                        // Pastikan subcategory tidak null
                        if (subcategory == null) {
                          return const SizedBox
                              .shrink(); // Atau tampilkan pesan error
                        }

                        int contentCount = subcategory.contentsCount ??
                            0; // Pastikan tidak null

                        return GestureDetector(
                          onTap: () {
                            print(
                                'Navigating to contents for: ${subcategory.name}');
                            Get.toNamed('/reminders/contents',
                                arguments: subcategory);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 18),
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
                                child: Text(
                                  "Page: $contentCount",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Divider(
                                color: Colors.black26,
                                height: 1,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
