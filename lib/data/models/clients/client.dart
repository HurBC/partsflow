import 'package:partsflow/data/abstract_models/client/client.dart';
import 'package:partsflow/data/abstract_models/client/client_general_atributes.dart';
import 'package:partsflow/data/models/clients/enums/client_enums.dart';
import 'package:partsflow/data/models/locality/address.dart';
import 'package:partsflow/data/models/users/user.dart';

class ClientGeneralAttributesModel extends ClientGeneralAtributes {
  @override
  final int id;
  @override
  final String client;
  @override
  final bool hasActiveIssues;
  @override
  final bool hasActiveQuotationOrders;
  @override
  final bool hasManualAssistanceTrigger;
  @override
  final bool hasPendingCloseOrders;
  @override
  final bool hasPendingInvoice;

  ClientGeneralAttributesModel({
    required this.id,
    required this.client,
    required this.hasActiveIssues,
    required this.hasActiveQuotationOrders,
    required this.hasManualAssistanceTrigger,
    required this.hasPendingCloseOrders,
    required this.hasPendingInvoice,
  });

  factory ClientGeneralAttributesModel.fromJson(Map<String, dynamic> json) =>
      ClientGeneralAttributesModel(
        id: json["id"],
        client: json["client"],
        hasActiveIssues: json["has_active_issues"],
        hasActiveQuotationOrders: json["has_active_quotation_orders"],
        hasManualAssistanceTrigger: json["has_manual_assitance_trigger"],
        hasPendingCloseOrders: json["has_pending_close_orders"],
        hasPendingInvoice: json["has_pending_invoice"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client": client,
        "has_active_issues": hasActiveIssues,
        "has_active_quotation_orders": hasActiveQuotationOrders,
        "has_manual_assitance_trigger": hasManualAssistanceTrigger,
        "has_pending_close_orders": hasPendingCloseOrders,
        "has_pending_invoice": hasPendingInvoice,
      };
}

class ClientModel extends Client{
  // Information
  @override
  final String id;
  @override
  final String? firstName;
  @override
  final String? lastName;
  @override
  final String? fullName;
  @override
  final String? run;
  @override
  final String? name;
  @override
  final String? email;
  @override
  final String? phone;
  @override
  final bool isNew;
  @override
  final bool isActive;
  @override
  final bool isChatHiddenFromAdmin;
  @override
  final bool isChatResolved;
  @override
  final bool isLastMessageInbound;
  @override
  final bool isLastOutboundMessageAi;
  @override
  final int unreadMessageCount;
  @override
  final String? lastMessage;
  @override
  final ClientLeadGenerationChannel? leadGenerationChannel;
  @override
  final String? profilePictureUrl;
  @override
  final bool isQuoteAgentActive;
  @override
  final bool isOrderTakerAgentRestricted;

  @override
  final ClientOperationModeEnum operationMode;
  @override
  final ClientOriginChoices origin;
  @override
  final ClientStatusChoices? status;
  @override
  final ClientImportanceLevel importanceLevel;

  // Dates
  @override
  final String? chatResolvedAt;
  @override
  final String? lastMessageAt;
  @override
  final String? lastAiActiveModeAt;
  @override
  final String? lastManualActiveModeAt;
  @override
  final String? lastSellerOutboundMessageAt;
  @override
  final String createdAt;
  @override
  final String updatedAt;

  // Relations
  @override
  final List<AddressModel>? addresses;
  @override
  final UserModel? responsible;

  // Extra
  @override
  final ClientGeneralAttributesModel? generalAttributes;

  // AI Generate Message
  @override
  final String? lastAiGeneratedMessage;
  @override
  final String? lastAiGeneratedMessageAt;

  // Computed (no necesariamente vienen en la API, pero útiles)
  @override
  final bool? isFromToday;
  @override
  final bool? isAiActive;
  @override
  final bool? isRecent;
  @override
  final bool? isImportant;
  @override
  final bool isAgentPendingResolution;

  ClientModel({
    required this.id,
    this.firstName,
    this.lastName,
    this.fullName,
    this.run,
    this.name,
    this.email,
    this.phone,
    required this.isNew,
    required this.isActive,
    required this.isChatHiddenFromAdmin,
    required this.isChatResolved,
    required this.isLastMessageInbound,
    required this.isLastOutboundMessageAi,
    required this.unreadMessageCount,
    this.lastMessage,
    this.leadGenerationChannel,
    this.profilePictureUrl,
    required this.isQuoteAgentActive,
    required this.isOrderTakerAgentRestricted,
    required this.operationMode,
    required this.origin,
    this.status,
    required this.importanceLevel,
    this.chatResolvedAt,
    this.lastMessageAt,
    this.lastAiActiveModeAt,
    this.lastManualActiveModeAt,
    this.lastSellerOutboundMessageAt,
    required this.createdAt,
    required this.updatedAt,
    this.addresses,
    this.responsible,
    this.generalAttributes,
    this.lastAiGeneratedMessage,
    this.lastAiGeneratedMessageAt,
    this.isFromToday,
    this.isAiActive,
    this.isRecent,
    this.isImportant,
    required this.isAgentPendingResolution,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) =>
      ClientModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        fullName: json["full_name"],
        run: json["run"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        isNew: json["is_new"],
        isActive: json["is_active"],
        isChatHiddenFromAdmin: json["is_chat_hidden_from_admin"],
        isChatResolved: json["is_chat_resolved"],
        isLastMessageInbound: json["is_last_message_inbound"],
        isLastOutboundMessageAi: json["is_last_outbound_message_ai"],
        unreadMessageCount: json["unread_message_count"],
        lastMessage: json["last_message"],
        leadGenerationChannel:
            ClientLeadGenerationChannelExtension.fromJson(json["lead_generation_channel"]),
        profilePictureUrl: json["profile_picture_url"],
        isQuoteAgentActive: json["is_quote_agent_active"],
        isOrderTakerAgentRestricted: json["is_order_taker_agent_restricted"],
        operationMode:
            ClientOperationModeEnumExtension.fromJson(json["operation_mode"])!,
        origin: ClientOriginChoicesExtension.fromJson(json["origin"])!,
        status: ClientStatusChoicesExtension.fromJson(json["status"]),
        importanceLevel:
            ClientImportanceLevelExtension.fromJson(json["importance_level"])!,
        chatResolvedAt: json["chat_resolved_at"],
        lastMessageAt: json["last_message_at"],
        lastAiActiveModeAt: json["last_ai_active_mode_at"],
        lastManualActiveModeAt: json["last_manual_active_mode_at"],
        lastSellerOutboundMessageAt: json["last_seller_outbound_message_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        addresses: null,
        responsible: json["responsible"] == null
            ? null
            : UserModel.fromJson(json["responsible"]),
        generalAttributes: json["general_attributes"] == null
            ? null
            : ClientGeneralAttributesModel.fromJson(json["general_attributes"]),
        lastAiGeneratedMessage: json["last_ai_generated_message"],
        lastAiGeneratedMessageAt: json["last_ai_generated_message_at"],
        isFromToday: json["is_from_today"],
        isAiActive: json["is_ai_active"],
        isRecent: json["is_recent"],
        isImportant: json["is_important"],
        isAgentPendingResolution: json["is_agent_pending_resolution"],
      );
}
