import 'package:flutter_test/flutter_test.dart';
import 'package:invelop/utils/custom_date_utils.dart';

void main() {
  group('CustomDateUtils', () {
    test('formatDateTransaction should format today\'s date as "Hoje"', () {
      final date = DateTime.now();
      final result = CustomDateUtils.formatDateTransaction(date);
      expect(result, 'Hoje');
    });

    test('formatDateTransaction should format yesterday\'s date as "Ontem"',
        () {
      final date = DateTime.now().subtract(const Duration(days: 1));
      final result = CustomDateUtils.formatDateTransaction(date);
      expect(result, 'Ontem');
    });

    test(
        'formatDateTransaction should format the day before yesterday\'s date as "Anteontem"',
        () {
      final date = DateTime.now().subtract(const Duration(days: 2));
      final result = CustomDateUtils.formatDateTransaction(date);
      expect(result, 'Anteontem');
    });

    test('formatDateTransaction should format any other date as "dd/mm/yyyy"',
        () {
      final date = DateTime(2022, 1, 1);
      final result = CustomDateUtils.formatDateTransaction(date);
      expect(result, '01/01/2022');
    });
  });
}
