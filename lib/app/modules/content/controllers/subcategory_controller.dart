import 'package:ebookapp/app/data/models/motivasi_model.dart';
import 'package:ebookapp/app/modules/content/enums/category.dart';
import 'package:ebookapp/app/modules/content/repositories/subcategory_repository.dart';
import 'package:ebookapp/core/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SubcategoryController extends GetxController {
  final SubcategoryRepository repository = SubcategoryRepository();
  final motivationSubcategories = RxList<Subcategory>([]);
  final reminderSubcategories = RxList<Subcategory>([]);
  final searchQuery = RxString('');
  final gettingData = RxBool(false);

  Future<String?> getToken() async {
    return (await SharedPreferences.getInstance()).getString('token');
  }

  Future<List<Subcategory>> _fetchSubcategories(Category category) async {
    debugPrint('🔄 Fetching subcategories...');

    final response = await repository.get(category);
    if (response == null) {
      showErrorSnackbar();
      return [];
    }

    final jsonResponse = json.decode(response.body);

    if (jsonResponse['data'] != null) {
      debugPrint('✅ Subcategories fetched successfully');

      return (jsonResponse['data'] as List)
          .map((item) => Subcategory.fromJson(item))
          .toList();
    } else {
      debugPrint('❌ No subcategories found');
      return [];
    }
  }

  Future<void> fetchMotivationSubcategories() async {
    gettingData.value = true;

    try {
      motivationSubcategories.value =
          await _fetchSubcategories(Category.motivasi);
    } catch (e) {
      debugPrint("Error: $e");
      showErrorSnackbar();
      return;
    } finally {
      gettingData.value = false;
    }
  }

  Future<void> fetchReminderSubcategories() async {
    gettingData.value = true;

    try {
      reminderSubcategories.value =
          await _fetchSubcategories(Category.pengingat);
    } catch (e) {
      debugPrint("Error: $e");
      showErrorSnackbar();
      return;
    } finally {
      gettingData.value = false;
    }
  }

  void showErrorSnackbar() {
    Get.snackbar(errorTitle, errorDescription);
  }
}
