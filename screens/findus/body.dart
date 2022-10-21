// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meggycakes/Widgets/size_config.dart';
import 'package:meggycakes/components/default_button.dart';
import 'package:meggycakes/screens/home/home_screen.dart';

class FindUs extends StatefulWidget {
  @override
  _FindUs createState() => _FindUs();
}

class _FindUs extends State<FindUs> {
  static final LatLng _kMapCenter =
      LatLng(-6.776202436733419, 39.22240351063052);

  static final CameraPosition _kInitialPosition =
      CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kInitialPosition,
        markers: _createMarker(),
      ),
    );
  }

  Set<Marker> _createMarker() {
    return {
      Marker(
          markerId: MarkerId("marker_1"),
          position: LatLng(-6.777409566368173, 39.23680737146053),
          infoWindow: InfoWindow(title: 'Meggy Cakes Tanzania'))
    };
  }
}
