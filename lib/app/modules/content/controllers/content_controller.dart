import 'dart:convert';

import 'package:ebookapp/app/data/models/content_model.dart';
import 'package:ebookapp/app/data/models/cursor_pagination_model.dart';
import 'package:ebookapp/app/modules/content/repositories/content_repository.dart';
import 'package:ebookapp/app/modules/settings/controllers/user_controller.dart';
import 'package:ebookapp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContentController extends GetxController {
  final ContentRepository _contentRepository = ContentRepository();

  final images = <Content>[].obs;
  final currentPage = 0.obs;
  final isLoading = true.obs;
  final isFetchingData = false.obs;
  String? nextCursor;

  final int fetchThreshold = 4;

  final token = RxnString();
  late SharedPreferences _prefs;
  final UserController userController = Get.find<UserController>();

  @override
  void onInit() {
    super.onInit();

    getSharedPreferenceInstance().then((prefs) {
      _prefs = prefs;

      if (!userController.isPremium.value &&
          (_prefs.getStringList('contentViewed') ?? []).length >= 3) {
        Future.microtask(() => Get.offNamed(Routes.ticketPremium));
        return;
      }

      token.value = _prefs.getString('token');
      isLoading.value = false;
    });
  }

  Future<void> fetchImages(
      {required int subcategoryId, bool reset = false}) async {
    if (isFetchingData.value) return;
    isFetchingData.value = true;

    final response = await fetchApi(
        subcategoryId: subcategoryId, cursor: reset ? null : nextCursor);

    if (reset) {
      images.clear();

      if (!response['images'].isEmpty) {
        addSlideCount(response['images'][0]);
      }
    }

    images.addAll(response['images']);

    nextCursor = response['nextCursor'];
    isFetchingData.value = false;
  }

  void handlePageChanged(int subcategoryId, int index) {
    currentPage.value = index;

    if (images.length - index <= fetchThreshold && nextCursor != null) {
      fetchImages(subcategoryId: subcategoryId);
    }

    if (index < 3 && index < images.length) {
      addSlideCount(images[index]);
    }
  }

  Future<Map<String, dynamic>> fetchApi(
      {required int subcategoryId, String? cursor}) async {
    final response = await _contentRepository.get(subcategoryId, cursor);

    if (response == null) {
      return {
        'images': [],
        'nextCursor': null,
      };
    }

    final jsonResponse = json.decode(response.body);

    return {
      'images': jsonResponse['data'].map<Content>((item) {
        return Content.fromJson(item);
      }).toList(),
      'nextCursor': jsonResponse['meta'] != null
          ? CursorPagination.fromJson(jsonResponse['meta']).nextCursor
          : null,
    };
  }

  Future<SharedPreferences> getSharedPreferenceInstance() async {
    return await SharedPreferences.getInstance();
  }

  void addSlideCount(Content content) {
    if (!userController.isPremium.value) {
      final current = _prefs.getStringList('contentViewed') ?? [];
      final Set<String> uniqueSet = Set<String>.from(current);

      uniqueSet.add(content.id.toString());

      _prefs.setStringList('contentViewed', uniqueSet.toList()).then((_) {
        if (uniqueSet.length > 3) {
          Future.microtask(() => Get.offNamed(Routes.ticketPremium));
        }
      });
    } else {
      _prefs.setStringList('contentViewed', []);
    }
  }
}

// Simulasi API dummy
