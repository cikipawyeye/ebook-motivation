class ApiEndpoint {
  static final String baseUrl = 'https://ebook.dev.whatthefun.id/';

  static _AuthEndPoint get authEndPoint => _AuthEndPoint();
  static _ContentEndPoint get contentEndPoint => _ContentEndPoint();  // Menambahkan endpoint baru
}

class _AuthEndPoint {
  final String registerEmail = 'api/v1/register';
  final String loginEmail = 'api/v1/login';
}

class _ContentEndPoint {
  // Endpoint untuk mengambil konten dengan subcategory_id yang dinamis
  String getContents(int contentId) {
    return 'api/v1/contents/$contentId';  // Menggunakan parameter dinamis
  }
}
