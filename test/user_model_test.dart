import 'package:cmsc23_project_villavicencio/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("user Model", () {
    test('User Model constructor', () {
      final userInstance = User(
        username: "sampleusername",
        email: "sampleEmail",
        firstName: "sampleFirstName",
        lastName: "sampleLastName",
        birthday: "2012-02-27",
        location: "Manila",
        bio: "",
        friends: [],
        receivedFriendRequests: [],
        sentFriendRequest: [],
      );
      expect(userInstance.username, "sampleusername");
      expect(userInstance.email, "sampleEmail");
      expect(userInstance.firstName, "sampleFirstName");
      expect(userInstance.lastName, "sampleLastName");
      expect(userInstance.birthday, "2012-02-27");
      expect(userInstance.location, "Manila");
      expect(userInstance.bio, "");
      expect(userInstance.friends, <dynamic>[]);
      expect(userInstance.receivedFriendRequests, <dynamic>[]);
      expect(userInstance.sentFriendRequest, <dynamic>[]);
    });
    test("User Model toJson method", () {
      final userInstance = User(
        username: "sampleusername",
        email: "sampleEmail",
        firstName: "sampleFirstName",
        lastName: "sampleLastName",
        birthday: "2012-02-27",
        location: "Manila",
        bio: "",
        friends: [],
        receivedFriendRequests: [],
        sentFriendRequest: [],
      );
      final converted = userInstance.toJson(userInstance);

      expect(converted, {
        "id": null,
        "username": "sampleusername",
        "email": "sampleEmail",
        "firstName": "sampleFirstName",
        "lastName": "sampleLastName",
        "birthday": "2012-02-27",
        "location": "Manila",
        "bio": "",
        "friends": [],
        "receivedFriendRequests": [],
        "sentFriendRequest": [],
      });
    });
    test("User Model fromJson method", () {
      final userInstance = {
        "id": null,
        "username": "sampleusername",
        "email": "sampleEmail",
        "firstName": "sampleFirstName",
        "lastName": "sampleLastName",
        "birthday": "2012-02-27",
        "location": "Manila",
        "bio": "",
        "friends": [],
        "receivedFriendRequests": [],
        "sentFriendRequest": [],
      };
      final converted = User.fromJson(userInstance);

      expect(converted.username, "sampleusername");
      expect(converted.email, "sampleEmail");
      expect(converted.firstName, "sampleFirstName");
      expect(converted.lastName, "sampleLastName");
      expect(converted.birthday, "2012-02-27");
      expect(converted.location, "Manila");
      expect(converted.bio, "");
      expect(converted.friends, <dynamic>[]);
      expect(converted.receivedFriendRequests, <dynamic>[]);
      expect(converted.sentFriendRequest, <dynamic>[]);
    });
  });
}
