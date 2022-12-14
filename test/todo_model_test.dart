import 'package:cmsc23_project_villavicencio/models/todo_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Todo Model", () {
    test('Todo Model constructor', () {
      final modelInstance = Todo(
        userId: "sampleid",
        title: "Test Todo",
        description: "Test Description",
        deadline: DateTime.parse("2012-02-27"),
        completed: false,
        lastEditedBy: "Beili",
        lastEditedOn: "December 12, 2022",
      );
      expect(modelInstance.userId, "sampleid");
      expect(modelInstance.title, "Test Todo");
      expect(modelInstance.description, "Test Description");
      expect(modelInstance.deadline, DateTime.parse("2012-02-27"));
      expect(modelInstance.completed, false);
      expect(modelInstance.lastEditedBy, "Beili");
      expect(modelInstance.lastEditedOn, "December 12, 2022");
    });
    test("Todo Model toJson method", () {
      final modelInstance = Todo(
        userId: "sampleid",
        title: "Test Todo",
        description: "Test Description",
        deadline: DateTime.parse("2012-02-27"),
        completed: false,
        lastEditedBy: "Beili",
        lastEditedOn: "December 12, 2022",
      );
      final converted = modelInstance.toJson(modelInstance);

      expect(converted, {
        "userId": "sampleid",
        "title": "Test Todo",
        "description": "Test Description",
        "deadline": DateTime.parse("2012-02-27"),
        "completed": false,
        "lastEditedBy": "Beili",
        "lastEditedOn": "December 12, 2022",
      });
    });
  });
}
