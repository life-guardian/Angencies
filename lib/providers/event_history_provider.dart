import 'package:agencies_app/models/event_history.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventHistoryNotifier extends StateNotifier<List<EventHistory>> {
  EventHistoryNotifier({required this.ref}) : super([]);

  final Ref ref;

  void addList(List<EventHistory> list) {
    state = list;
  }
  void reset(){
    state=[];
  }
}

final eventHistoryProvider =
    StateNotifierProvider<EventHistoryNotifier, List<EventHistory>>(
        (reff) => EventHistoryNotifier(ref: reff));
