import 'package:ebookapp/app/modules/content/repositories/repository.dart';
import 'package:ebookapp/core/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ContentRepository extends Repository {
  Future<http.Response?> get(int subcategoryId, String? cursor) async {
    final token = await getToken();
    final url =
        '$baseUrl/api/v1/contents?subcategory_id=$subcategoryId&cursor=${cursor ?? ''}&limit=5';

    debugPrint('🔄 Fetching motivasi data for subcategoryId: $subcategoryId');
    debugPrint('🔄 $url');

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
