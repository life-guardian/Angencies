import 'package:agencies_app/model/alert_history.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlertHistoryNotifier extends StateNotifier<List<AlertHistory>> {
  AlertHistoryNotifier({required this.ref}) : super([]);

  final Ref ref;

  void addList(List<AlertHistory> list) {
    state = list;
  }

  void removeAt({required int index}) {
    state.removeAt(index);
  }

  void insertAt({required int index, required AlertHistory alert}) {
    state.insert(index, alert);
  }

  void reset() {
    state = [];
  }
}

final alertHistoryProvider =
    StateNotifierProvider<AlertHistoryNotifier, List<AlertHistory>>(
        (reff) => AlertHistoryNotifier(ref: reff));
