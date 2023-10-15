import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  late LatLng currentLocation;
  final MapController mapController = MapController();

  @override
  void initState() {
    super.initState();
    currentLocation = LatLng(-38.7307, -72.60022);
  }

  void getCurrentPosition() async {
    Position position = await determinePosition();
    updateLocation(LatLng(position.latitude, position.longitude));
  }

  void updateLocation(LatLng newLocation) {
    setState(() {
      currentLocation = newLocation;
    });
    mapController.move(newLocation, 15.0);
  }

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error('Error');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: currentLocation,
              initialZoom: 6,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
            ],
          ),
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: ElevatedButton(
              onPressed: () {
                getCurrentPosition();
              },
              child: Text("Obtener ubicación"),
            ),
          ),
        ],
      ),
    );
  }
}