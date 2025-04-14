import 'package:ebookapp/app/data/models/motivasi_model.dart';
import 'package:ebookapp/app/modules/pengingat/controllers/pengingat_category_controller.dart';
import 'package:ebookapp/app/modules/settings/controllers/setting_theme_controller.dart';
import 'package:ebookapp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PengingatView extends GetView<PengingatIdController> {
  const PengingatView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    final TextEditingController searchController = TextEditingController();
    final isSearching = false.obs;

    return Obx(() {
      return Scaffold(
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
                  ? _buildSearchField(searchController, isSearching)
                  : const Text(
                      'Pengingat',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
            ),
          ),
          backgroundColor: themeController.currentColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: () => isSearching.value = true,
            ),
          ],
        ),
        body: _buildBody(),
      );
    });
  }

  Widget _buildSearchField(
      TextEditingController searchController, RxBool isSearching) {
    return Row(
      children: [
        const Icon(Icons.search, color: Colors.grey),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: searchController,
            decoration: const InputDecoration(
              hintText: 'Cari...',
              border: InputBorder.none,
            ),
            onChanged: (value) {
              // Update search query
              Get.find<PengingatIdController>().searchQuery.value = value;
            },
          ),
        ),
        IconButton(
          icon: const Icon(Icons.clear, color: Colors.black),
          onPressed: () {
            searchController.clear();
            isSearching.value = false;
            Get.find<PengingatIdController>().searchQuery.value = '';
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/Watermark.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          _buildHeaderImage(),
          Expanded(child: _buildSubcategoryList()),
        ],
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/Pengingat1.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildSubcategoryList() {
    return Obx(() {
      final controller = Get.find<PengingatIdController>();
      final filteredSubcategories =
          controller.subcategories.where((subcategory) {
        return subcategory.name
            .toLowerCase()
            .contains(controller.searchQuery.value.toLowerCase());
      }).toList();

      if (filteredSubcategories.isEmpty) {
        return const Center(child: Text("Konten tidak ditemukan"));
      } else {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: filteredSubcategories.length,
          itemBuilder: (context, index) {
            final subcategory = filteredSubcategories[index];
            final contentCount = subcategory.contentsCount ?? 0;

            return GestureDetector(
              onTap: () {
                // Navigasi ke halaman /motivation/contents dengan subcategory sebagai argumen
                Get.toNamed(Routes.pengingatContents, arguments: subcategory);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${index + 1}. ${subcategory.name}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const Icon(Icons.chevron_right, color: Colors.black),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Page: $contentCount",
                      style: GoogleFonts.leagueSpartan(
                          fontSize: 15, color: Colors.black87),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Colors.black26, height: 1),
                ],
              ),
            );
          },
        );
      }
    });
  }
}
