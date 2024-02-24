import 'package:flutter_riverpod/flutter_riverpod.dart';

final agencyNameProvider = StateProvider<String>((ref) => "Loading...");

final eventsCountProvider = StateProvider<List<String>>((ref) => ['0', '0']);
