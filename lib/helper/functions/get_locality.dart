import 'package:geocoding/geocoding.dart';

Future<String> getLocality({
  required double lat,
  required double lng,
}) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
    Placemark placemark = placemarks[0];
    return placemark.locality!;
  } catch (error) {
    return "Unknown";
  }
}
