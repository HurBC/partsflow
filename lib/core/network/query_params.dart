abstract class QueryParams {
  final int? limit, offset;

  const QueryParams({this.limit, this.offset});

  Map<String, dynamic> toMap();
}
