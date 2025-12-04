import 'package:partsflow/core/network/query_params.dart';

class SearchClientParams extends QueryParams {
  String? query;
  bool? isActive;

  SearchClientParams({this.query, this.isActive, super.limit, super.offset});

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> params = {
      'limit': limit,
      'offset': offset,
      'query': query,
      'is_active': isActive,
    };

    params.removeWhere((_, value) => value == null);

    return params;
  }
  
}
