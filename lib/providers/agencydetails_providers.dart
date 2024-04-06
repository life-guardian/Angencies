import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final agencyNameProvider = StateProvider<String?>((ref) => null);

final eventsCountProvider = StateProvider<List<String>>((ref) => ['0', '0']);

final tokenProvider = StateProvider<String>((ref) => "");

final profileImageProvider = StateProvider<XFile?>((ref) => null);

final isRescueOperationOnGoingProvider = StateProvider<bool>((ref) => false);
final isLoadingHomeScreen = StateProvider<bool>((ref) => true);

final rescueOperationIdProvider = StateProvider<String?>((ref) {
  return null;
});
