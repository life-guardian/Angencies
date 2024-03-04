import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class OpenStreetMap extends StatelessWidget {
  const OpenStreetMap({super.key});

  @override
  Widget build(BuildContext context) {
    return OpenStreetMapSearchAndPick(
        center: const LatLong(16.401627, 74.2368399),
        buttonColor: Colors.blue,
        buttonText: 'Pick Location',
        onPicked: (pickedData) {
          Navigator.of(context).pop(pickedData);
        });
  }
}
