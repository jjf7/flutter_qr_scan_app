import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/scan_model.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {
    final ScanModel scan =
        ModalRoute.of(context)?.settings.arguments as ScanModel;

    CameraPosition initialPoint =
        CameraPosition(target: scan.getLatLng(), zoom: 17.5, tilt: 50);

    // marcadores
    Set<Marker> markers = <Marker>{};
    markers.add(
      Marker(
          markerId: const MarkerId('geo-location'), position: scan.getLatLng()),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Mapa'),
        actions: [
          IconButton(
              onPressed: () async {
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(
                    CameraUpdate.newCameraPosition(initialPoint));
              },
              icon: const Icon(Icons.location_disabled_rounded))
        ],
      ),
      body: GoogleMap(
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        mapType: mapType,
        markers: markers,
        initialCameraPosition: initialPoint,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (mapType == MapType.normal) {
            mapType = MapType.satellite;
          } else {
            mapType = MapType.normal;
          }

          setState(() {});
        },
        child: const Icon(Icons.layers),
      ),
    );
  }
}
