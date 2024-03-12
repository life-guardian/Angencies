import 'package:agencies_app/models/operation_history.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RescueHistoryNotifier extends StateNotifier<List<OperationHistory>> {
  RescueHistoryNotifier({required this.ref}) : super([]);

  final Ref ref;

  void addList(List<OperationHistory> list) {
    state = list;
  }

  void reset(){
    state=[];
  }
}

final rescueHistoryProvider =
    StateNotifierProvider<RescueHistoryNotifier, List<OperationHistory>>(
        (reff) => RescueHistoryNotifier(ref: reff));
