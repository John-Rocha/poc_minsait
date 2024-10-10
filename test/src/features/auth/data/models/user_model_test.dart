import 'package:flutter_test/flutter_test.dart';
import 'package:poc_minsait/src/features/auth/data/models/user_model.dart';

void main() {
  group('UserModel', () {
    final Map<String, dynamic> json = {
      'id': 1,
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'password': 'password123',
    };

    const expectedUserModel = UserModel(
      id: 1,
      name: 'John Doe',
      email: 'john.doe@example.com',
      password: 'password123',
    );

    test('should create a valid UserModel from JSON', () {
      final result = UserModel.fromJson(json);

      expect(result, expectedUserModel);
    });

    test('should return true when two UserModels have the same properties', () {
      const user1 = UserModel(
        id: 1,
        name: 'John Doe',
        email: 'john.doe@example.com',
        password: 'password123',
      );

      const user2 = UserModel(
        id: 1,
        name: 'John Doe',
        email: 'john.doe@example.com',
        password: 'password123',
      );

      expect(user1, user2);
    });

    test('should return false when two UserModels have different properties',
        () {
      const user1 = UserModel(
        id: 1,
        name: 'John Doe',
        email: 'john.doe@example.com',
        password: 'password123',
      );

      const user2 = UserModel(
        id: 2,
        name: 'Jane Doe',
        email: 'jane.doe@example.com',
        password: 'password456',
      );

      expect(user1 == user2, false);
    });
  });
}
