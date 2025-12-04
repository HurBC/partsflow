class ClientKanbanModel {
  final String? id;
  final String? fullName;
  final String? profilePictureUrl;
  final String? phone;
  final bool isNew;
  final bool? isRecent;
  final String? chatId;
  final bool isLastMessageInbound;
  final bool? isAiActive;
  final int unreadMessageCount;
  final String? lastMessage;
  final String? lastMessageAt;

  ClientKanbanModel({
    this.id,
    required this.fullName,
    required this.profilePictureUrl,
    required this.phone,
    required this.isNew,
    required this.isRecent,
    required this.chatId,
    required this.isLastMessageInbound,
    required this.isAiActive,
    required this.unreadMessageCount,
    required this.lastMessage,
    required this.lastMessageAt,
  });

  factory ClientKanbanModel.fromJson(Map<String, dynamic> json) =>
      ClientKanbanModel(
        id: json["id"],
        fullName: json["full_name"],
        profilePictureUrl: json["profile_picture_url"],
        phone: json["phone"],
        isNew: json["is_new"],
        isRecent: json["is_recent"],
        chatId: json["chat_id"],
        isLastMessageInbound: json["is_last_message_inbound"],
        isAiActive: json["is_ai_active"],
        unreadMessageCount: json["unread_message_count"],
        lastMessage: json["last_message"],
        lastMessageAt: json["last_message_at"],
      );
}
