import 'package:geolocator/geolocator.dart';
import 'company_service.dart';

class GeolocationService {
  static const double maxDistance = 100.0; // meters

  Future<bool> isWithinWorkplace(Company company) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();

    double distance = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      company.latitude,
      company.longitude,
    );

    return distance <= maxDistance;
  }
}
