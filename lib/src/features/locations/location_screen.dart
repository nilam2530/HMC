import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return const LocationMaain();
  }
}

class LocationMaain extends StatefulWidget {
  const LocationMaain({super.key});

  @override
  State<LocationMaain> createState() => _LocationMaainState();
}

class _LocationMaainState extends State<LocationMaain> {
  Completer<GoogleMapController> mController = Completer<GoogleMapController>();

  Set<Marker> marker = {
    const Marker(
      markerId: MarkerId("Marker 1"),
      position: LatLng(26.2978, 73.0180),
      infoWindow: InfoWindow(
        title: "Mehrangarh Fort",
        snippet: "Jodhpur",
      ),
    ),
    const Marker(
      markerId: MarkerId("Marker 2"),
      position: LatLng(27.3978, 73.0180),
    ),
    const Marker(
      markerId: MarkerId("Marker 3"),
      position: LatLng(26.3978, 74.0180),
    ),
  };

  @override
  void initState() {
    super.initState();
    getCurrentLoc();
  }

  void getCurrentLoc() async {
    if (await checkIfGetCurrLoc()) {
      var currPos = await Geolocator.getCurrentPosition();
      var currPosition = CameraPosition(
        target: LatLng(currPos.latitude, currPos.longitude),
        zoom: 19,
      );
      var mapController = await mController.future;
      mapController.animateCamera(CameraUpdate.newCameraPosition(currPosition));
    } else {}
  }

  Future<bool> checkIfGetCurrLoc() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: (loadedController) {
        if (!mController.isCompleted) {
          mController.complete(loadedController);
        }
      },
      mapType: MapType.satellite,
      markers: marker,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      onTap: (loc) {
        setState(() {
          marker.add(Marker(
            markerId: MarkerId("New_${loc.latitude}_${loc.longitude}"),
            position: loc,
          ));
        });
      },
      initialCameraPosition: const CameraPosition(
        target: LatLng(26.2978, 73.0180),
        zoom: 19,
        tilt: 85,
        bearing: 135,
      ),
    );
  }
}
