import 'package:partsflow/core/network/query_params.dart';

class SearcClientCarParams extends QueryParams {
  String? query;

  SearcClientCarParams({this.query, super.limit, super.offset});

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> params = {
      'limit': limit,
      'offset': offset,
      'query': query,
    };

    params.removeWhere((_, value) => value == null);

    return params;
  }
}
