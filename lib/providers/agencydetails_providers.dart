import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final agencyNameProvider = StateProvider<String?>((ref) => null);

final eventsCountProvider = StateProvider<List<String>>((ref) => ['0', '0']);

final tokenProvider = StateProvider<String>((ref) => "");

final profileImageProvider = StateProvider<XFile?>((ref) => null);

final isRescueOperationOnGoingProvider = StateProvider<bool>((ref) => false);

final isLoadingHomeScreen = StateProvider<bool>((ref) => true);

final greetingProvider = StateProvider<String>((ref) => getGreetingMessage());

final rescueOperationIdProvider = StateProvider<String?>((ref) {
  return null;
});

String getGreetingMessage() {
  final now = DateTime.now();
  final hour = now.hour;

  if (hour < 12) {
    return 'Good Morning';
  } else if (hour < 17) {
    return 'Good Afternoon';
  } else {
    return 'Good Evening';
  }
}
