import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';


class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  // Coordenadas iniciales (Universidad)
  late LatLng currentLocation;

  @override
  void initState() {
    super.initState();
    currentLocation = LatLng(-33.471386, -71.2207616);
  }

  // Obtiene las coordenadas actuales
   void getCurrentPosition() async {
    Position position = await determinePosition();
    updateLocation(LatLng(position.latitude, position.longitude));
  }

  // Actualiza las coordenadas en el mapa
  void updateLocation(LatLng newLocation) {
    setState(() {
      currentLocation = newLocation;
      print(currentLocation);
    });
  }

  // Función que verifica si están los permisos para obtener la ubicación
  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();

    // Si no tiene permiso, lo pide
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      // Si lo deniega, devuelve error
      if (permission == LocationPermission.denied) {
        return Future.error('Error');
      }
    }
    return await Geolocator.getCurrentPosition();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        options: MapOptions(
          initialCenter: currentLocation,
          initialZoom: 6,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          ElevatedButton(onPressed: () {
            getCurrentPosition();
          },
          child: Text("Obtener ubicación"))
        ],
      ),
    );
  }
}