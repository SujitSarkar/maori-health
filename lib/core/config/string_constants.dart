import 'package:maori_health/core/config/app_constants.dart';

abstract class StringConstants {
  // Bottom Navigation
  static const String dashboard = 'Dashboard';
  static const String schedule = 'Schedule';
  static const String notification = 'Notification';
  static const String settings = 'Settings';

  // Settings Menu
  static const String myProfile = 'My Profile';
  static const String assets = 'Assets';
  static const String timesheets = 'Timesheets';
  static const String darkMode = 'Dark Mode';
  static const String signOut = 'Sign Out';

  // Login
  static const String email = 'Email';
  static const String password = 'Password';
  static const String login = 'Login';
  static const String forgotPassword = 'Forgot Password?';
  static const String areYouSureYouWantToSignOut = 'Are you sure you want to sign out?';

  // Dashboard
  static const String welcomeTo = 'Welcome to ${AppConstants.appName}';
  static const String availableJobs = 'Available Jobs';
  static const String currentScheduled = 'Current Scheduled';
  static const String nextSchedule = 'Next Schedule';
  static const String todaySchedule = 'Today’s Schedule';
  static const String upcomingSchedule = 'Upcoming Schedule';
  static const String startTime = 'Start Time';
  static const String endTime = 'End Time';
  static const String totalHours = 'Total Hours';
  static const String startedAt = 'Started At';
  static const String totalJob = 'Total Job';
  static const String activeJob = 'Active Job';
  static const String cancelJob = 'Cancel Job';
  static const String completeJob = 'Complete job';
  static const String totalClient = 'Total Client';
  static const String missedTimesheets = 'Missed\nTimesheets';

  // Common
  static const String ok = 'OK';
  static const String cancel = 'Cancel';
  static const String refresh = 'Refresh';
  static const String noData = 'No data found';
  static const String thisFieldIsRequired = 'This field is required';
  static const String invalidEmail = 'Invalid email address';
  static const String nameTooShort = 'Name must be at least 2 characters long';
  static const String invalidName = 'Invalid name';
  static const String passwordTooShort = 'Password must be at least 6 characters long';
  static const String noInternet = 'No internet connection. Please check your network.';
  static const String somethingWentWrong = 'Something went wrong. Please try again.';
}
