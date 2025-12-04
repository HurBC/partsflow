import 'package:partsflow/core/models/json.dart';

class ListApiResponse<Data> {
  int count;
  String? next;
  String? previous;
  List<Data> results;

  ListApiResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory ListApiResponse.fromJson(Map<String, dynamic> json, Data Function(Map<String, dynamic>) Data) {
    return ListApiResponse(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List<dynamic>)
          .map((item) => Data(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
