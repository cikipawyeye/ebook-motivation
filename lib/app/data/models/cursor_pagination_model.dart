class CursorPagination {
  final int perPage;
  final String? nextCursor;
  final String? nextPageUrl;
  final String? prevCursor;
  final String? prevPageUrl;

  CursorPagination({
    required this.perPage,
    this.nextCursor,
    this.nextPageUrl,
    this.prevCursor,
    this.prevPageUrl,
  });

  factory CursorPagination.fromJson(Map<String, dynamic> json) {
    return CursorPagination(
      perPage: json['per_page'] ?? 25,
      nextCursor: json['next_cursor'],
      nextPageUrl: json['next_page_url'],
      prevCursor: json['prev_cursor'],
      prevPageUrl: json['prev_page_url'],
    );
  }
}
