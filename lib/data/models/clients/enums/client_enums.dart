import 'package:collection/collection.dart';

// Helpers
String _toSnakeCase(String str) {
  return str
      .replaceAllMapped(
        RegExp(r'(?<!^)(?=[A-Z])'),
        (match) => '_${match.group(0)}',
      )
      .toLowerCase();
}

/* Enums */
enum ClientOperationModeEnum {
  manual,
  automatic,
}

enum ClientImportanceLevel {
  none,
  low,
  medium,
  high,
}

enum ClientOriginChoices {
  widget,
  backoffice,
  webhook,
  other,
}

enum ClientLeadGenerationChannel {
  facebookCampaign,
  instagramCampaign,
  web,
}

enum ClientStatusChoices {
  pendingQuote,
  quoting,
  quoted,
  accepted,
  waitingPayment,
  toInvoice,
  toPickup,
  toShip,
  issues,
  return_,
}

/* Eextensions */
extension ClientOperationModeEnumExtension on ClientOperationModeEnum {
  String toJson() => _toSnakeCase(name);

  static ClientOperationModeEnum? fromJson(String? json) {
    if (json == null) return null;

    return ClientOperationModeEnum.values.firstWhereOrNull(
      (e) => e.toJson() == json,
    );
  }
}

extension ClientImportanceLevelExtension on ClientImportanceLevel {
  String toJson() => _toSnakeCase(name);

  static ClientImportanceLevel? fromJson(String? json) {
    if (json == null) return null;
    
    return ClientImportanceLevel.values.firstWhereOrNull(
      (e) => e.toJson() == json,
    );
  }
}

extension ClientOriginChoicesExtension on ClientOriginChoices {
  String toJson() => _toSnakeCase(name);

  static ClientOriginChoices? fromJson(String? json) {
    if (json == null) return null;

    return ClientOriginChoices.values.firstWhereOrNull(
      (e) => e.toJson() == json,
    );
  }
}

extension ClientLeadGenerationChannelExtension on ClientLeadGenerationChannel {
  String toJson() => _toSnakeCase(name);

  static ClientLeadGenerationChannel? fromJson(String? json) {
    if (json == null) return null;

    return ClientLeadGenerationChannel.values.firstWhereOrNull(
      (e) => e.toJson() == json,
    );
  }
}

extension ClientStatusChoicesExtension on ClientStatusChoices {
  String toJson() => _toSnakeCase(name);

  static ClientStatusChoices? fromJson(String? json) {
    if (json == null) return null;
    
    return ClientStatusChoices.values.firstWhereOrNull(
      (e) => e.toJson() == json,
    );
  }
}
