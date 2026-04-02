import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationResult {
  final bool isSuccess;
  final String? city;
  final double? lat;
  final double? lng;
  final String? errorMessage;

  LocationResult.success({
    required String this.city,
    required double this.lat,
    required double this.lng,
  })  : isSuccess = true,
        errorMessage = null;

  LocationResult.error(this.errorMessage)
      : isSuccess = false,
        city = null,
        lat = null,
        lng = null;
}

class LocationService {
  LocationService._();

  /// GPS'ten mevcut sehir adini al
  static Future<LocationResult> getCurrentCity() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return LocationResult.error('Konum izni reddedildi');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return LocationResult.error(
          'Konum izni kalıcı olarak reddedildi. Ayarlardan açın.',
        );
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      );

      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isEmpty) {
        return LocationResult.error('Konum bulunamadı');
      }

      final place = placemarks.first;
      final city = place.subAdministrativeArea ??
          place.administrativeArea ??
          place.locality ??
          'Bilinmeyen';

      return LocationResult.success(
        city: city,
        lat: position.latitude,
        lng: position.longitude,
      );
    } catch (e) {
      return LocationResult.error('Konum alınamadı: $e');
    }
  }
}
