import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class GooglePlacesService {
  GooglePlacesService._();

  static String get _apiKey => dotenv.env['GOOGLE_PLACES_API_KEY'] ?? '';
  static const _baseUrl = 'https://maps.googleapis.com/maps/api/place';

  static bool get isConfigured => _apiKey.isNotEmpty;

  /// Autocomplete search — returns list of predictions.
  static Future<List<PlacePrediction>> autocomplete(String query) async {
    if (query.length < 3) return [];
    if (!isConfigured) return [];

    final url =
        '$_baseUrl/autocomplete/json'
        '?input=${Uri.encodeComponent(query)}'
        '&language=tr'
        '&components=country:tr'
        '&key=$_apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) return [];

    final data = jsonDecode(response.body);
    final predictions = data['predictions'] as List?;
    if (predictions == null) return [];

    return predictions
        .map((p) => PlacePrediction(
              placeId: p['place_id'] as String,
              description: p['description'] as String,
              mainText:
                  (p['structured_formatting']?['main_text'] as String?) ?? '',
            ))
        .toList();
  }

  /// Get place details (lat, lng, address, photo) by place_id.
  static Future<PlaceDetails?> getDetails(String placeId) async {
    if (!isConfigured) return null;
    final url =
        '$_baseUrl/details/json'
        '?place_id=$placeId'
        '&fields=name,geometry,formatted_address,photos,place_id'
        '&language=tr'
        '&key=$_apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) return null;

    final data = jsonDecode(response.body)['result'];
    if (data == null) return null;

    String? photoUrl;
    final photos = data['photos'] as List?;
    if (photos != null && photos.isNotEmpty) {
      final photoRef = photos[0]['photo_reference'] as String;
      photoUrl =
          '$_baseUrl/photo?maxwidth=800&photo_reference=$photoRef&key=$_apiKey';
    }

    return PlaceDetails(
      placeId: data['place_id'] as String,
      name: data['name'] as String,
      address: (data['formatted_address'] as String?) ?? '',
      lat: (data['geometry']['location']['lat'] as num).toDouble(),
      lng: (data['geometry']['location']['lng'] as num).toDouble(),
      photoUrl: photoUrl,
    );
  }
}

class PlacePrediction {
  final String placeId;
  final String description;
  final String mainText;

  const PlacePrediction({
    required this.placeId,
    required this.description,
    required this.mainText,
  });
}

class PlaceDetails {
  final String placeId;
  final String name;
  final String address;
  final double lat;
  final double lng;
  final String? photoUrl;

  const PlaceDetails({
    required this.placeId,
    required this.name,
    required this.address,
    required this.lat,
    required this.lng,
    this.photoUrl,
  });
}
