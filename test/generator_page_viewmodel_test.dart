import 'package:bodyflow/data/services/ai_workout_service.dart';
import 'package:bodyflow/domain/misc/globalenums.dart';
import 'package:bodyflow/ui/main_pages/view_models/generator_page_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('GeneratorPageViewModel', () {
    test('should initialize with default values', () {
      final viewModel = GeneratorPageViewModel();
      
      expect(viewModel.isGenerating, isFalse);
      expect(viewModel.activityType, ActivityType.session);
      expect(viewModel.selectedBodyParts, isEmpty);
      expect(viewModel.selectedDays, isEmpty);
      expect(viewModel.sessionLengthInMinutes, 30);
    });

    test('should switch activity types correctly', () {
      final viewModel = GeneratorPageViewModel();
      
      // Start with session
      expect(viewModel.activityType, ActivityType.session);
      
      // Switch to schedule
      viewModel.setActivityAsSchedule();
      expect(viewModel.activityType, ActivityType.schedule);
      
      // Switch back to session
      viewModel.setActivityAsSession();
      expect(viewModel.activityType, ActivityType.session);
    });

    test('should add and remove body parts', () {
      final viewModel = GeneratorPageViewModel();
      
      expect(viewModel.selectedBodyParts, isEmpty);
      
      // Add a body part
      viewModel.addOrRemoveBodyPart(BodyPart.chest);
      expect(viewModel.selectedBodyParts, contains(BodyPart.chest));
      expect(viewModel.selectedBodyParts.length, 1);
      
      // Add another body part
      viewModel.addOrRemoveBodyPart(BodyPart.legs);
      expect(viewModel.selectedBodyParts.length, 2);
      
      // Remove a body part
      viewModel.addOrRemoveBodyPart(BodyPart.chest);
      expect(viewModel.selectedBodyParts, isNot(contains(BodyPart.chest)));
      expect(viewModel.selectedBodyParts.length, 1);
    });

    test('should add and remove days', () {
      final viewModel = GeneratorPageViewModel();
      
      expect(viewModel.selectedDays, isEmpty);
      
      // Add a day
      viewModel.addOrRemoveDay(Days.monday);
      expect(viewModel.selectedDays, contains(Days.monday));
      expect(viewModel.selectedDays.length, 1);
      
      // Add another day
      viewModel.addOrRemoveDay(Days.friday);
      expect(viewModel.selectedDays.length, 2);
      
      // Remove a day
      viewModel.addOrRemoveDay(Days.monday);
      expect(viewModel.selectedDays, isNot(contains(Days.monday)));
      expect(viewModel.selectedDays.length, 1);
    });

    test('should clear selections when switching activity types', () {
      final viewModel = GeneratorPageViewModel();
      
      // Add some selections
      viewModel.addOrRemoveBodyPart(BodyPart.chest);
      viewModel.addOrRemoveDay(Days.monday);
      
      expect(viewModel.selectedBodyParts, isNotEmpty);
      expect(viewModel.selectedDays, isNotEmpty);
      
      // Switch activity type
      viewModel.setActivityAsSchedule();
      
      expect(viewModel.selectedBodyParts, isEmpty);
      expect(viewModel.selectedDays, isEmpty);
    });

    test('should update session length', () {
      final viewModel = GeneratorPageViewModel();
      
      expect(viewModel.sessionLengthInMinutes, 30);
      
      viewModel.setSessionLength(60);
      expect(viewModel.sessionLengthInMinutes, 60);
    });

    test('should be instantiable with AI service', () {
      final aiService = AiWorkoutService('test_key');
      final viewModel = GeneratorPageViewModel(aiService: aiService);
      
      expect(viewModel, isNotNull);
      expect(viewModel.isGenerating, isFalse);
    });

    test('should be instantiable without AI service', () {
      final viewModel = GeneratorPageViewModel();
      
      expect(viewModel, isNotNull);
      expect(viewModel.isGenerating, isFalse);
    });
  });
}
