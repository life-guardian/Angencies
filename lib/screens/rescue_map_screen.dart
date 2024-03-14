import 'package:agencies_app/models/modal_bottom_sheet.dart';
import 'package:agencies_app/providers/location_provider.dart';
import 'package:agencies_app/small_widgets/custom_text_widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

class RescueMapScreen extends ConsumerStatefulWidget {
  const RescueMapScreen({super.key});

  @override
  ConsumerState<RescueMapScreen> createState() => _RescueMapScreenState();
}

class _RescueMapScreenState extends ConsumerState<RescueMapScreen> {
  ModalBottomSheet modalBottomSheet = ModalBottomSheet();

  void openModalBottomSheet() {
    modalBottomSheet.openModal(
      context: context,
      widget: markerPointDetails(),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<double> latLng = ref.watch(deviceLocationProvider);

    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(latLng[0], latLng[1]),
          zoom: 12,
          interactiveFlags: InteractiveFlag.all,
        ),
        children: [
          openStreetMapTileLayer,
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(16.6719917, 74.20847),
                width: 60,
                height: 60,
                rotateAlignment: Alignment.centerLeft,
                builder: (context) {
                  return IconButton(
                    onPressed: () {
                      openModalBottomSheet();
                    },
                    icon: const Icon(
                      Icons.location_pin,
                      size: 40,
                      color: Colors.red,
                    ),
                  );
                },
              ),
              Marker(
                point: LatLng(latLng[0], latLng[1]),
                width: 60,
                height: 60,
                rotateAlignment: Alignment.centerLeft,
                builder: (
                  context,
                ) {
                  return GestureDetector(
                    onTap: () {
                      openModalBottomSheet();
                    },
                    child: const Column(
                      children: [
                        Icon(
                          Icons.location_pin,
                          size: 40,
                          color: Colors.green,
                        ),
                        CustomTextWidget(
                          text: "Its me",
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  );
                },
              ),
              Marker(
                point: LatLng(16.6719917, 74.20417),
                width: 60,
                height: 60,
                rotateAlignment: Alignment.centerLeft,
                builder: (context) {
                  return IconButton(
                    onPressed: () {
                      openModalBottomSheet();
                    },
                    icon: const Icon(
                      Icons.location_pin,
                      size: 40,
                      color: Colors.blue,
                    ),
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget markerPointDetails() {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Text("data"),
        ),
      ],
    );
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
    );
