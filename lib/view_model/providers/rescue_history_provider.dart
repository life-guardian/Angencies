import 'package:agencies_app/model/operation_history.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RescueOperationHistoryNotifier
    extends StateNotifier<List<RescueOperationHistory>> {
  RescueOperationHistoryNotifier({required this.ref}) : super([]);

  final Ref ref;

  void addList(List<RescueOperationHistory> list) {
    state = list;
  }

  void removeAt({required int index}) {
    state.removeAt(index);
  }

  void insertAt(
      {required int index, required RescueOperationHistory rescueOperation}) {
    state.insert(index, rescueOperation);
  }

  void reset() {
    state = [];
  }
}

final rescueOperationHistoryProvider = StateNotifierProvider<
        RescueOperationHistoryNotifier, List<RescueOperationHistory>>(
    (reff) => RescueOperationHistoryNotifier(ref: reff));
