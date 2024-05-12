class CustomDateUtils {
  static String formatDateTransaction(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final twoDaysAgo = DateTime(now.year, now.month, now.day - 2);

    final dateToCompare = DateTime(date.year, date.month, date.day);

    if (dateToCompare.isAtSameMomentAs(today)) {
      return 'Hoje';
    } else if (dateToCompare.isAtSameMomentAs(yesterday)) {
      return 'Ontem';
    } else if (dateToCompare.isAtSameMomentAs(twoDaysAgo)) {
      return 'Anteontem';
    } else {
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    }
  }
}
