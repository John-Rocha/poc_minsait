import 'package:flutter_test/flutter_test.dart';
import 'package:poc_minsait/src/features/auth/data/models/auth_model.dart';

void main() {
  const authModel = AuthModel(
    accessToken: 'access_token_123',
    refreshToken: 'refresh_token_123',
  );

  group('AuthModel', () {
    test('should return a valid AuthModel from JSON', () {
      final Map<String, dynamic> json = {
        'access_token': 'access_token_123',
        'refresh_token': 'refresh_token_123',
      };

      final result = AuthModel.fromJson(json);

      expect(result, authModel);
    });

    test('should correctly expose properties', () {
      expect(authModel.accessToken, 'access_token_123');
      expect(authModel.refreshToken, 'refresh_token_123');
    });

    test('should return true when two AuthModels have the same properties', () {
      const authModel1 = AuthModel(
        accessToken: 'access_token_123',
        refreshToken: 'refresh_token_123',
      );

      const authModel2 = AuthModel(
        accessToken: 'access_token_123',
        refreshToken: 'refresh_token_123',
      );

      expect(authModel1, equals(authModel2));
    });

    test('should return false when two AuthModels have different properties',
        () {
      const authModel1 = AuthModel(
        accessToken: 'access_token_123',
        refreshToken: 'refresh_token_123',
      );

      const authModel2 = AuthModel(
        accessToken: 'access_token_456',
        refreshToken: 'refresh_token_456',
      );

      expect(authModel1 == authModel2, false);
    });
  });
}
