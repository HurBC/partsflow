import 'package:partsflow/data/abstract_models/client/client_general_atributes.dart';
import 'package:partsflow/data/abstract_models/locality/address.dart';
import 'package:partsflow/data/abstract_models/user/user.dart';
import 'package:partsflow/data/models/clients/enums/client_enums.dart';

abstract class Client {
  String get id;

  String? get firstName;
  String? get lastName;
  String? get fullName;
  String? get run;
  String? get name;
  String? get email;
  String? get phone;
  String? get lastMessage;
  String? get profilePictureUrl;

  bool get isNew;
  bool get isActive;
  bool get isChatHiddenFromAdmin;
  bool get isChatResolved;
  bool get isLastMessageInbound;
  bool get isLastOutboundMessageAi;
  bool get isQuoteAgentActive;
  bool get isOrderTakerAgentRestricted;

  int get unreadMessageCount;

  ClientLeadGenerationChannel? get leadGenerationChannel;
  ClientOperationModeEnum get operationMode;
  ClientOriginChoices get origin;
  ClientStatusChoices? get status;
  ClientImportanceLevel get importanceLevel;

  // Dates
  String? get chatResolvedAt;
  String? get lastMessageAt;
  String? get lastAiActiveModeAt;
  String? get lastManualActiveModeAt;
  String? get lastSellerOutboundMessageAt;
  String get createdAt;
  String get updatedAt;

  // Relations
  List<Address>? get addresses;
  User? get responsible;

  // Extra
  ClientGeneralAtributes? get generalAttributes;

  // AI Generate Message
  String? get lastAiGeneratedMessage;
  String? get lastAiGeneratedMessageAt;

  // Computed (no necesariamente vienen en la API, pero útiles)
  bool? get isFromToday;
  bool? get isAiActive;
  bool? get isRecent;
  bool? get isImportant;
  bool get isAgentPendingResolution;
}
