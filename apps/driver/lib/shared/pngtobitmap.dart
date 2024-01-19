import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<BitmapDescriptor> pngToBitmapDescriptor(String path) async {
  return await BitmapDescriptor.fromAssetImage(
    const ImageConfiguration(),
    path,
  );
}
