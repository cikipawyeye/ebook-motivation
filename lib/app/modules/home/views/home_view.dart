import 'dart:ui';
import 'package:ebookapp/app/modules/content/controllers/subcategory_controller.dart';
import 'package:ebookapp/app/modules/content/enums/category.dart';
import 'package:ebookapp/app/modules/home/controllers/home_controller.dart';
import 'package:ebookapp/app/modules/settings/controllers/setting_theme_controller.dart';
import 'package:ebookapp/app/routes/app_pages.dart';
import 'package:ebookapp/core/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  static const Color appBarColor = Color(0xFF32497B);

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchUserProfile();
    });

    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Home',
            style: _getTextStyle(color: Colors.white),
          ),
          backgroundColor: themeController.currentColor,
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.white),
              onPressed: () {
                Get.toNamed('/settings');
              },
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Template.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Obx(() {
            if (controller.isLoading.value ||
                controller.userResponse.value == null) {
              return Center(child: CircularProgressIndicator());
            }

            return RefreshIndicator(
              onRefresh: () async {
                await controller.fetchUserProfile();
              },
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Terima kasih.\nSemoga bermanfaat.",
                      style: GoogleFonts.leagueSpartan(
                          fontSize: 24, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Kartu Motivasi
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () {
                        _showMotivasiPopup(context);
                      },
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/images/Motivasi1.png',
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            left: 16,
                            bottom: 16,
                            child: Text(
                              'MOTIVASI',
                              style: _getTextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 5.0,
                                    color: Colors.black.withValues(alpha: 0.7),
                                    offset: const Offset(2, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            right: 16,
                            bottom: 16,
                            child: Text(
                              '>',
                              style: _getTextStyle(
                                  fontSize: 24, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Kartu Pengingat
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () {
                        _showPengingatPopup(context);
                      },
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/images/Pengingat1.png',
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            left: 16,
                            bottom: 10,
                            child: Text(
                              'PENGINGAT',
                              style: _getTextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 5.0,
                                    color: Colors.black.withValues(alpha: 0.7),
                                    offset: const Offset(2, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            right: 16,
                            bottom: 16,
                            child: Text(
                              '>',
                              style: _getTextStyle(
                                  fontSize: 24, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Tombol Premium
                  Row(
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {
                          Get.toNamed(Routes.accountStatus);
                        },
                        icon: Image.asset(
                          'assets/images/crown.png',
                          width: 20,
                          height: 20,
                        ),
                        label: Text(
                          'Coba Premium!',
                          style:
                              _getTextStyle(fontSize: 16, color: Colors.white),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          side: const BorderSide(color: appBarColor, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  TextStyle _getTextStyle({
    double fontSize = 20,
    Color color = Colors.black,
    List<Shadow>? shadows,
  }) {
    return GoogleFonts.leagueSpartan(
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeight.bold,
      height: 0.9,
      shadows: shadows ?? [],
    );
  }

  // Popup Motivasi
  void _showMotivasiPopup(BuildContext context) {
    _showDialog(context, Category.motivasi);
  }

  // Popup Pengingat
  void _showPengingatPopup(BuildContext context) {
    _showDialog(context, Category.pengingat);
  }

  void _showDialog(BuildContext context, Category category) {
    final SubcategoryController subcategoryController =
        Get.find<SubcategoryController>();
    final TextEditingController searchController = TextEditingController();
    final ValueNotifier<bool> isSearching = ValueNotifier<bool>(false);

    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      builder: (BuildContext context) {
        debugPrint('Popup Opened');

        if (category == Category.motivasi) {
          if (subcategoryController.motivationSubcategories.isEmpty) {
            subcategoryController.fetchMotivationSubcategories();
          }
        } else {
          if (subcategoryController.reminderSubcategories.isEmpty) {
            subcategoryController.fetchReminderSubcategories();
          }
        }

        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Dialog(
            backgroundColor: Colors.white.withValues(alpha: 0.9),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage("assets/images/Template.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: colorBackground,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back, color: Colors.white),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              category == Category.motivasi
                                  ? 'MOTIVASI'
                                  : 'PENGINGAT',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: Icon(Icons.search, color: Colors.white),
                              onPressed: () {
                                isSearching.value = !isSearching.value;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Search TextField
                    ValueListenableBuilder<bool>(
                      valueListenable: isSearching,
                      builder: (context, value, child) {
                        return value
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.search,
                                        color: Colors.white
                                            .withValues(alpha: 0.7)),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: TextField(
                                        controller: searchController,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 18),
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          hintText: 'Cari...',
                                          hintStyle: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white
                                                .withValues(alpha: 0.5),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide(
                                                color: Colors.white
                                                    .withValues(alpha: 0.5),
                                                width: 1.0),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            borderSide: BorderSide(
                                                color: Colors.white
                                                    .withValues(alpha: 0.5),
                                                width: 1.0),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        onChanged: (text) {
                                          subcategoryController
                                              .searchQuery.value = text;
                                        },
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.clear,
                                          color: Colors.white
                                              .withValues(alpha: 0.7)),
                                      onPressed: () {
                                        searchController.clear();
                                        subcategoryController
                                            .searchQuery.value = '';
                                        isSearching.value = false;
                                      },
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox();
                      },
                    ),

                    // Motivasi List
                    Flexible(
                      child: Obx(() {
                        if (subcategoryController.gettingData.value) {
                          return Center(
                            child: Text(
                              "Loading...",
                              style: TextStyle(color: Colors.grey),
                            ),
                          );
                        }

                        final subcategories = category == Category.motivasi
                            ? subcategoryController.motivationSubcategories
                            : subcategoryController.reminderSubcategories;

                        final filteredSubcategories = subcategories
                            .where((subcategory) => subcategory.name
                                .toLowerCase()
                                .contains(subcategoryController
                                    .searchQuery.value
                                    .toLowerCase()))
                            .toList();

                        if (filteredSubcategories.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  category == Category.motivasi
                                      ? "Tidak ada motivasi ditemukan"
                                      : "Tidak ada pengingat ditemukan",
                                  style: TextStyle(
                                      color:
                                          Colors.white.withValues(alpha: 0.6)),
                                ),
                                SizedBox(height: 20),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.white.withValues(alpha: 0.3),
                                    ),
                                    onPressed: () =>
                                        category == Category.motivasi
                                            ? subcategoryController
                                                .fetchMotivationSubcategories()
                                            : subcategoryController
                                                .fetchReminderSubcategories(),
                                    child: Text(
                                      "Refresh",
                                      style: TextStyle(color: Colors.white),
                                    ))
                              ],
                            ),
                          );
                        }

                        return GridView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(8),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemCount: filteredSubcategories.length,
                          itemBuilder: (context, index) {
                            final subcategory = filteredSubcategories[index];

                            return GestureDetector(
                              onTap: () {
                                Get.offNamed('/contents',
                                    arguments: subcategory);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: category == Category.motivasi
                                        ? AssetImage(
                                            'assets/images/Motivasi1.png')
                                        : AssetImage(
                                            'assets/images/Pengingat1.png'),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black45, BlendMode.darken),
                                  ),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          subcategory.name,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }
}
