import 'package:firebase_analytics/firebase_analytics.dart';

abstract class AnalyticsScreen {
  String get screenName;
  void logEvent() => FirebaseAnalytics().logEvent(name: screenName);
}