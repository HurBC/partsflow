import 'package:partsflow/data/models/clients/enums/client_enums.dart';
import 'package:partsflow/data/models/locality/address.dart';
import 'package:partsflow/data/models/users/user.dart';

class ClientGeneralAttributesRepository {
  final int id;
  final String client;
  final bool hasActiveIssues;
  final bool hasActiveQuotationOrders;
  final bool hasManualAssistanceTrigger;
  final bool hasPendingCloseOrders;
  final bool hasPendingInvoice;

  ClientGeneralAttributesRepository({
    required this.id,
    required this.client,
    required this.hasActiveIssues,
    required this.hasActiveQuotationOrders,
    required this.hasManualAssistanceTrigger,
    required this.hasPendingCloseOrders,
    required this.hasPendingInvoice,
  });

  factory ClientGeneralAttributesRepository.fromJson(Map<String, dynamic> json) =>
      ClientGeneralAttributesRepository(
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

class ClientRepository {
  // Information
  final String id;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? run;
  final String? name;
  final String? email;
  final String? phone;
  final bool isNew;
  final bool isActive;
  final bool isChatHiddenFromAdmin;
  final bool isChatResolved;
  final bool isLastMessageInbound;
  final bool isLastOutboundMessageAi;
  final int unreadMessageCount;
  final String? lastMessage;
  final ClientLeadGenerationChannel? leadGenerationChannel;
  final String? profilePictureUrl;
  final bool isQuoteAgentActive;
  final bool isOrderTakerAgentRestricted;

  final ClientOperationModeEnum operationMode;
  final ClientOriginChoices origin;
  final ClientStatusChoices? status;
  final ClientImportanceLevel importanceLevel;

  // Dates
  final String? chatResolvedAt;
  final String? lastMessageAt;
  final String? lastAiActiveModeAt;
  final String? lastManualActiveModeAt;
  final String? lastSellerOutboundMessageAt;
  final String createdAt;
  final String updatedAt;

  // Relations
  final List<AddressRepository>? addresses;
  final UserRepository? responsible;

  // Extra
  final ClientGeneralAttributesRepository? generalAttributes;

  // AI Generate Message
  final String? lastAiGeneratedMessage;
  final String? lastAiGeneratedMessageAt;

  // Computed (no necesariamente vienen en la API, pero útiles)
  final bool? isFromToday;
  final bool? isAiActive;
  final bool? isRecent;
  final bool? isImportant;
  final bool isAgentPendingResolution;

  ClientRepository({
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

  factory ClientRepository.fromJson(Map<String, dynamic> json) =>
      ClientRepository(
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
            : UserRepository.fromJson(json["responsible"]),
        generalAttributes: json["general_attributes"] == null
            ? null
            : ClientGeneralAttributesRepository.fromJson(json["general_attributes"]),
        lastAiGeneratedMessage: json["last_ai_generated_message"],
        lastAiGeneratedMessageAt: json["last_ai_generated_message_at"],
        isFromToday: json["is_from_today"],
        isAiActive: json["is_ai_active"],
        isRecent: json["is_recent"],
        isImportant: json["is_important"],
        isAgentPendingResolution: json["is_agent_pending_resolution"],
      );
}
