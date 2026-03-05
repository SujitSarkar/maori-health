import 'package:maori_health/presentation/shared/widgets/horizontal_week_calender.dart';

class ScheduleUtils {
  static List<DateTime> getWeekDates({required WeekStartFrom weekStartFrom, DateTime? currentDate}) {
    final DateTime now = currentDate ?? DateTime.now();
    final DateTime dateOnly = DateTime(now.year, now.month, now.day);

    // 2. Determine the offset based on the starting day
    // If Monday: Mon(1) -> 0, Tue(2) -> 1 ... Sun(7) -> 6
    // If Sunday: Sun(7) -> 0, Mon(1) -> 1 ... Sat(6) -> 5
    int offset = (weekStartFrom == WeekStartFrom.monday) ? dateOnly.weekday - 1 : dateOnly.weekday % 7;

    final DateTime firstDayOfWeek = dateOnly.subtract(Duration(days: offset));

    // 3. Generate the 7-day list
    return List.generate(7, (index) => firstDayOfWeek.add(Duration(days: index)));
  }
}
