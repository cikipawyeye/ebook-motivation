import 'package:ebookapp/core/constants/constant.dart' as constant;

class ApiEndpoint {
  static final String baseUrl = '${constant.baseUrl}/';

  static _AuthEndPoint get authEndPoint => _AuthEndPoint();
  static _ContentEndPoint get contentEndPoint =>
      _ContentEndPoint(); // Menambahkan endpoint baru
}

class _AuthEndPoint {
  final String registerEmail = 'api/v1/register';
  final String loginEmail = 'api/v1/login';
}

class _ContentEndPoint {
  // Endpoint untuk mengambil konten dengan subcategory_id yang dinamis
  String getContents(int contentId) {
    return 'api/v1/contents/$contentId'; // Menggunakan parameter dinamis
  }
}
