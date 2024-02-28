import 'package:agencies_app/models/alert_history.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlertHistoryNotifier extends StateNotifier<List<AlertHistory>> {
  AlertHistoryNotifier({required this.ref}) : super([]);

  final Ref ref;

  void addList(List<AlertHistory> list) {
    state = list;
  }
}

final alertHistoryProvider =
    StateNotifierProvider<AlertHistoryNotifier, List<AlertHistory>>(
        (reff) => AlertHistoryNotifier(ref: reff));
