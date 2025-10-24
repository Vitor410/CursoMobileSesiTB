
import 'package:geolocator/geolocator.dart';

class LocationService {
  // Coordenadas fixas do local de trabalho (Limeira, SP)
  static const double empresaLat = -22.5708894;
  static const double empresaLng = -47.4038541;

  Future<Position?> getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition();
  }

  bool isWithinRange(double userLat, double userLng) {
    double distance = Geolocator.distanceBetween(
      userLat,
      userLng,
      empresaLat,
      empresaLng,
    );
    return distance <= 100; // 100 metros
  }
}
