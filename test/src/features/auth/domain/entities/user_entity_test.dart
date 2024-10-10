import 'package:flutter_test/flutter_test.dart';
import 'package:poc_minsait/src/features/auth/domain/entities/user_entity.dart';

void main() {
  group('UserEntity', () {
    const user1 = UserEntity(
      id: 1,
      name: 'John Doe',
      email: 'john.doe@example.com',
      password: 'password123',
    );

    const user2 = UserEntity(
      id: 1,
      name: 'John Doe',
      email: 'john.doe@example.com',
      password: 'password123',
    );

    const user3 = UserEntity(
      id: 2,
      name: 'Jane Doe',
      email: 'jane.doe@example.com',
      password: 'password123',
    );

    test('should return true when two entities have the same properties', () {
      expect(user1, user2);
    });

    test('should return false when two entities have different properties', () {
      expect(user1 == user3, false);
    });

    test('should return a list of properties', () {
      expect(
        user1.props,
        [1, 'John Doe', 'john.doe@example.com', 'password123'],
      );
    });

    test('should create a valid UserEntity instance', () {
      expect(user1.id, 1);
      expect(user1.name, 'John Doe');
      expect(user1.email, 'john.doe@example.com');
      expect(user1.password, 'password123');
    });
  });
}
