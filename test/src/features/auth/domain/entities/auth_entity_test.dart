import 'package:flutter_test/flutter_test.dart';
import 'package:poc_minsait/src/features/auth/domain/entities/auth_entity.dart';

void main() {
  group('AuthEntity', () {
    const authEntity1 = AuthEntity(
      accessToken: 'access_token_123',
      refreshToken: 'refresh_token_123',
    );

    const authEntity2 = AuthEntity(
      accessToken: 'access_token_123',
      refreshToken: 'refresh_token_123',
    );

    const authEntity3 = AuthEntity(
      accessToken: 'access_token_456',
      refreshToken: 'refresh_token_456',
    );

    test('should return true when two entities have the same properties', () {
      expect(authEntity1, equals(authEntity2));
    });

    test('should return false when two entities have different properties', () {
      expect(authEntity1 == authEntity3, false);
    });

    test('should correctly expose properties', () {
      expect(authEntity1.accessToken, 'access_token_123');
      expect(authEntity1.refreshToken, 'refresh_token_123');
    });

    test('props should return a list of properties', () {
      expect(authEntity1.props, ['access_token_123', 'refresh_token_123']);
    });
  });
}
