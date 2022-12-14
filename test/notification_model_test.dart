import 'package:cmsc23_project_villavicencio/models/notification_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Notification Model", () {
    test('Notification Model constructor', () {
      final notificationInstance = Notifications(
        type: "sampletype",
        sourceId: "sampleSourceID",
        body: "sampleBody",
        timestamp: DateTime.parse("2012-02-27"),
      );
      expect(notificationInstance.type, "sampletype");
      expect(notificationInstance.sourceId, "sampleSourceID");
      expect(notificationInstance.body, "sampleBody");
      expect(notificationInstance.timestamp, DateTime.parse("2012-02-27"));
    });
    test("Notifications Model toJson method", () {
      final notificationInstance = Notifications(
        type: "sampletype",
        sourceId: "sampleSourceID",
        body: "sampleBody",
        timestamp: DateTime.parse("2012-02-27"),
      );
      final converted = notificationInstance.toJson(notificationInstance);

      expect(converted, {
        "type": "sampletype",
        "sourceId": "sampleSourceID",
        "body": "sampleBody",
        "timestamp": DateTime.parse("2012-02-27"),
      });
    });
  });
}
