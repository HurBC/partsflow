import 'package:flutter_test/flutter_test.dart';
import 'package:partsflow/data/models/clients/client.dart';
import 'package:partsflow/data/models/clients/enums/client_enums.dart';

void main() {
  group('ClientModel', () {
    test('fromJson creates a valid ClientModel', () {
      final json = {
        "id": "1",
        "first_name": "Jane",
        "last_name": "Doe",
        "full_name": "Jane Doe",
        "run": "12345678-9",
        "name": "Jane",
        "email": "jane@example.com",
        "phone": "987654321",
        "is_new": true,
        "is_active": true,
        "is_chat_hidden_from_admin": false,
        "is_chat_resolved": false,
        "is_last_message_inbound": true,
        "is_last_outbound_message_ai": false,
        "unread_message_count": 0,
        "last_message": "Hello",
        "lead_generation_channel": "web",
        "profile_picture_url": null,
        "is_quote_agent_active": true,
        "is_order_taker_agent_restricted": false,
        "operation_mode": "manual",
        "origin": "widget",
        "status": "pending_quote",
        "importance_level": "none",
        "chat_resolved_at": null,
        "last_message_at": "2023-01-01T10:00:00",
        "last_ai_active_mode_at": null,
        "last_manual_active_mode_at": null,
        "last_seller_outbound_message_at": null,
        "created_at": "2023-01-01T09:00:00",
        "updated_at": "2023-01-01T09:00:00",
        "responsible": null,
        "general_attributes": null,
        "last_ai_generated_message": null,
        "last_ai_generated_message_at": null,
        "is_from_today": true,
        "is_ai_active": false,
        "is_recent": true,
        "is_important": false,
        "is_agent_pending_resolution": true,
      };

      final client = ClientModel.fromJson(json);

      expect(client.id, "1");
      expect(client.firstName, "Jane");
      expect(client.operationMode, ClientOperationModeEnum.manual);
      expect(client.leadGenerationChannel, ClientLeadGenerationChannel.web);
      expect(client.status, ClientStatusChoices.pendingQuote);
    });
  });
}
