import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class OpenStreetMap extends StatelessWidget {
  const OpenStreetMap({super.key});

  @override
  Widget build(BuildContext context) {
    return OpenStreetMapSearchAndPick(
        center: const LatLong(16.701627066501707, 74.23683705576299),
        buttonColor: Colors.blue,
        buttonText: 'Set Current Location',
        onPicked: (pickedData) {
          Navigator.of(context).pop(pickedData);
        });
  }
}
