import 'package:agencies_app/api_urls/config.dart';
import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class OpenStreetMap extends StatelessWidget {
  const OpenStreetMap({super.key});

  @override
  Widget build(BuildContext context) {
    return OpenStreetMapSearchAndPick(
      center: LatLong(globalLat, globallng),
      buttonColor: Colors.blue,
      buttonText: 'Pick Location',
      onPicked: (pickedData) {
        Navigator.of(context).pop(pickedData);
      },
    );
  }
}
