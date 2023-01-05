import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';

const GOOGLE_API_KEY = "";

class LocationUtil {
  static String generateLocationPreviewImage({
    double? latitude,
    double? longitude
  }) {
    return "";
  }

  static Future<String> getAddressFrom(LatLng positon) async {
    final String url = "";
    final response = await get(Uri.parse(url));
    return jsonDecode(response.body)["results"][0]["formatted_address"];
  }
}