import 'package:partsflow/core/network/query_params.dart';

class SearchProducts extends QueryParams {
  String query;
  int? similarityThreshold;

  SearchProducts({required this.query, this.similarityThreshold, super.limit, super.offset});

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> params = {
      'limit': limit,
      'offset': offset,
      'query': query,
      "similarity_threshold": similarityThreshold
    };

    params.removeWhere((_, value) => value == null);

    return params;
  }

}
