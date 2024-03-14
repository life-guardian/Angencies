import 'package:agencies_app/api_urls/config.dart';
import 'package:agencies_app/providers/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class OpenStreetMap extends ConsumerWidget {
  const OpenStreetMap({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<double> latLng = ref.watch(deviceLocationProvider);

    return OpenStreetMapSearchAndPick(
      center: LatLong(latLng[0], latLng[1]),
      buttonColor: Colors.blue,
      buttonText: 'Pick Location',
      onPicked: (pickedData) {
        Navigator.of(context).pop(pickedData);
      },
    );
  }
}
