import 'package:ebookapp/app/modules/content/enums/category.dart';
import 'package:ebookapp/app/modules/content/repositories/repository.dart';
import 'package:ebookapp/core/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SubcategoryRepository extends Repository {
  Future<http.Response?> get(Category category) async {
    final token = await getToken();
    final url = category == Category.motivasi
        ? '$baseUrl/api/v1/0/subcategories?paginate=false'
        : '$baseUrl/api/v1/1/subcategories?paginate=false';

    if (token == null) {
      throw Exception('User not authenticated!');
    }

    try {
      return await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );
    } catch (e) {
      debugPrint("Error: $e");
      return null;
    }
  }
}
