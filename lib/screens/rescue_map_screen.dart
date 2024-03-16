// ignore_for_file: library_prefixes

import 'dart:async';

import 'package:agencies_app/models/active_locations.dart';
import 'package:agencies_app/models/modal_bottom_sheet.dart';
import 'package:agencies_app/providers/location_provider.dart';
import 'package:agencies_app/small_widgets/custom_text_widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class RescueMapScreen extends ConsumerStatefulWidget {
  const RescueMapScreen({super.key});

  @override
  ConsumerState<RescueMapScreen> createState() => _RescueMapScreenState();
}

class _RescueMapScreenState extends ConsumerState<RescueMapScreen> {
  ModalBottomSheet modalBottomSheet = ModalBottomSheet();

  late IO.Socket socket;
  late String token;
  late Timer locationTimer;
  bool isSocketDisconnected = false;

  late List<double> latLng;
  List<LiveAgencies> liveAgencies = [];

  @override
  void initState() {
    super.initState();
    connectSocket();
  }

  @override
  void dispose() {
    super.dispose();
    disconnect();
  }

  void openModalBottomSheet({required LiveAgencies liveAgency}) {
    modalBottomSheet.openModal(
      context: context,
      widget: markerPointDetails(liveAgency: liveAgency),
    );
  }

  void connectSocket() {
    token = ref.read(tokenProvider);
    var baseUrl = dotenv.get("BASE_URL");
    socket = IO.io(baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'extraHeaders': {'Authorization': 'Bearer $token'}
    });
    socket.connect();
    socket.onConnect((data) {
      print("Socket Connected");
      getAgencyLocation();
    });

    locationTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      getDeviceLocation();
    });
  }

  void disconnect() async {
    isSocketDisconnected = true;
    locationTimer.cancel();
    socket.disconnect();
    socket.close();
    socket.onDisconnect((data) => print("Socket dis Connected"));
  }

  Future<void> getDeviceLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (!isSocketDisconnected) {
          ref.read(accessLiveLocationProvider.notifier).state = false;
          debugPrint("Location permission denied");
        }
      }
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      if (!isSocketDisconnected) {
        ref.read(deviceLocationProvider.notifier).state = [
          currentPosition.latitude,
          currentPosition.longitude
        ];
        emitLocationUpdate(currentPosition.latitude, currentPosition.longitude);
      }
      setState(() {});
    }
  }

  void emitLocationUpdate(double latitude, double longitude) {
    socket.emit('agencyLocationUpdate', {'lat': latitude, 'lng': longitude});
  }

  void getAgencyLocation() {
    setState(() {
      socket.on("agencyLocationUpdate", (data) {
        print(data);
        bool isPlotted = false;
        for (int i = 0; i < liveAgencies.length; i++) {
          if (liveAgencies[i].agencyId == data["agencyId"]) {
            liveAgencies[i].lat = data["lat"];
            liveAgencies[i].lng = data["lng"];
            isPlotted = true;
            break;
          }
        }

        if (!isPlotted) {
          liveAgencies.add(LiveAgencies.fromJson(data));
        }
      });
    });
  }

  Future<void> launchPhoneDial({required int phoneNo}) async {
    final Uri url = Uri(
      scheme: 'tel',
      path: phoneNo.toString(),
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      debugPrint("Cannot launch phoneCall url");
    }
  }

  @override
  Widget build(BuildContext context) {
    latLng = ref.watch(deviceLocationProvider);

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
              // Marker of this device
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
                      // openModalBottomSheet(liveAgencies: );
                    },
                    child: const Column(
                      children: [
                        Icon(
                          Icons.location_pin,
                          size: 40,
                          color: Colors.green,
                        ),
                        CustomTextWidget(
                          text: "Me",
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  );
                },
              ),

              for (LiveAgencies liveAgency in liveAgencies)
                Marker(
                  point: LatLng(liveAgency.lat!, liveAgency.lng!),
                  width: 60,
                  height: 60,
                  rotateAlignment: Alignment.centerLeft,
                  builder: (
                    context,
                  ) {
                    return GestureDetector(
                      onTap: () {
                        openModalBottomSheet(liveAgency: liveAgency);
                      },
                      child: Column(
                        children: [
                          const Icon(
                            Icons.location_pin,
                            size: 40,
                            color: Colors.green,
                          ),
                          CustomTextWidget(
                            text: liveAgency.agencyName!,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    );
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget markerPointDetails({required LiveAgencies liveAgency}) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        left: 12,
        right: 12,
        bottom: 5,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Agency Details',
            style: GoogleFonts.mulish().copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Agency Name'.toUpperCase(),
                      style: GoogleFonts.mulish().copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      liveAgency.agencyName!,
                      style: GoogleFonts.mulish().copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Representative Name'.toUpperCase(),
                      style: GoogleFonts.mulish().copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      liveAgency.representativeName!,
                      style: GoogleFonts.mulish().copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rescue Operation Name'.toUpperCase(),
                      style: GoogleFonts.mulish().copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      liveAgency.rescueOpsName!,
                      style: GoogleFonts.mulish().copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description'.toUpperCase(),
                      style: GoogleFonts.mulish().copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      liveAgency.rescueOpsDescription!,
                      style: GoogleFonts.mulish().copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Rescue Team Size'.toUpperCase(),
                      style: GoogleFonts.mulish().copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      liveAgency.rescueTeamSize!.toString(),
                      style: GoogleFonts.mulish().copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),

                Row(
                  children: [
                    const Icon(
                      Icons.star_border_outlined,
                      size: 30,
                      color: Colors.blue,
                    ),
                    const SizedBox(
                      width: 11,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Agency Phone'.toUpperCase(),
                          style: GoogleFonts.mulish().copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          liveAgency.phoneNumber.toString(),
                          style: GoogleFonts.mulish().copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // const Divider(thickness: 0.2),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 10),
                    child: SizedBox(
                      width: 200,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          await launchPhoneDial(
                            phoneNo: liveAgency.phoneNumber!,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              Theme.of(context).colorScheme.primary,
                          backgroundColor: const Color(0xff1E232C),
                        ),
                        child: const Text(
                          'CALL',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

TileLayer get openStreetMapTileLayer => TileLayer(
      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
    );
