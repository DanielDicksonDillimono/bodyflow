import 'package:bodyflow/data/services/ai_workout_service.dart';
import 'package:bodyflow/domain/misc/globalenums.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AiWorkoutService', () {
    test('should be instantiable with API key', () {
      // This test verifies the service can be created
      // Actual API calls require a valid key and internet connection
      final service = AiWorkoutService('test_api_key');
      expect(service, isNotNull);
    });

    test('should accept valid body parts for workout generation', () {
      // Verify that body parts enum is properly defined
      expect(BodyPart.values, isNotEmpty);
      expect(BodyPart.values.contains(BodyPart.fullBody), isTrue);
      expect(BodyPart.values.contains(BodyPart.chest), isTrue);
      expect(BodyPart.values.contains(BodyPart.legs), isTrue);
    });

    test('should accept valid days for schedule generation', () {
      // Verify that Days enum is properly defined
      expect(Days.values, isNotEmpty);
      expect(Days.values.contains(Days.monday), isTrue);
      expect(Days.values.contains(Days.friday), isTrue);
      expect(Days.values.contains(Days.sunday), isTrue);
    });
  });
}
