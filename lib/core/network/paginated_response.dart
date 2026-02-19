class PaginatedResponse<T> {
  final List<T> data;
  final int currentPage;
  final int totalItems;

  const PaginatedResponse({
    required this.data,
    required this.currentPage,
    required this.totalItems,
  });

  bool get hasMore => data.length < totalItems;
}
