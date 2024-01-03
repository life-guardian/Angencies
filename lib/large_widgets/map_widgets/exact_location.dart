import 'package:geocoding/geocoding.dart';

class ExactLocation {
  // final double lat;
  // final double lng;

  // ExactLocation({required this.lat, required this.lng});

  Future<String> locality({required double lat, required double lng}) async {
    String? locality;
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      Placemark placemark = placemarks[0];
      locality = placemark.locality;
    } catch (error) {
      print(
          "Error fetching locality for coordinates: ${error.toString()}"); // Add a placeholder for unknown localities
    }
    return locality!;
  }
}
