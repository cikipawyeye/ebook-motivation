import 'package:ebookapp/app/data/models/motivasi_model.dart';
import 'package:ebookapp/app/modules/settings/controllers/setting_theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/motivasi_controller.dart';

class MotivasiView extends GetView<MotivasiController> {
  const MotivasiView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    final TextEditingController searchController = TextEditingController();
    final isSearching = false.obs; // RxBool untuk status pencarian

    return Obx(() => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Center(
              child: AnimatedContainer(
                height: 40,
                duration: const Duration(milliseconds: 300),
                padding: isSearching.value
                    ? const EdgeInsets.symmetric(horizontal: 16.0)
                    : EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: isSearching.value ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: isSearching.value
                      ? Border.all(color: Colors.grey.shade300)
                      : null,
                ),
                child: isSearching.value
                    ? Row(
                        children: [
                          const Icon(Icons.search, color: Colors.grey),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                hintText: 'Cari...',
                                border: InputBorder.none,
                              ),
                              onChanged: (value) {
                                // Trigger search logic here
                                controller.searchQuery.value = value;
                              },
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.clear, color: Colors.black),
                            onPressed: () {
                              searchController.clear();
                              isSearching.value =
                                  false; // Kembali ke tampilan semula
                              controller.searchQuery.value = ''; // Reset query
                            },
                          ),
                        ],
                      )
                    : Text(
                        'Motivasi',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
            backgroundColor: themeController.currentColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Get.back();
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  isSearching.value = true; // Aktifkan pencarian
                },
              ),
            ],
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
                // Gambar di bagian atas (ini bisa diubah dinamis)
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

                          int contentCount = subcategory.contentsCount;

                          return GestureDetector(
                            onTap: () {
                              Get.toNamed('/motivation/contents',
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
                    );
                  }
                }),
              ],
            ),
          ),
        ));
  }
}
