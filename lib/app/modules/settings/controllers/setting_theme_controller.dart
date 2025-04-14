import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  // Warna default
  Color defaultColor = const Color(0xFF32497B);
  Rx<Color> selectedColor = const Color(0xFF32497B).obs; // Warna yang dipilih

  @override
  void onInit() {
    super.onInit();
    loadThemeColor(); // Memuat warna tema saat inisialisasi
  }

  void selectColor(Color color) {
    selectedColor.value = color; // Mengubah warna yang dipilih
    saveThemeColor(color); // Menyimpan warna yang dipilih
  }

  void resetColor() {
    selectedColor.value = defaultColor; // Mengatur kembali ke warna default
    saveThemeColor(defaultColor); // Menyimpan warna default
  }

  Color get currentColor => selectedColor.value; // Mendapatkan warna saat ini

  // Menyimpan warna ke SharedPreferences
  Future<void> saveThemeColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeColor', color.value);
  }

  // Memuat warna dari SharedPreferences
  Future<void> loadThemeColor() async {
    final prefs = await SharedPreferences.getInstance();
    int? colorValue = prefs.getInt('themeColor');
    if (colorValue != null) {
      selectedColor.value = Color(colorValue);
    }
  }
}
