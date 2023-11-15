import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:proxi_pyme/utils/get_user.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  late LatLng currentLocation;
  final MapController mapController = MapController();
  List<Marker> allMarkers = []; // Agregar esta lista de marcadores

  @override
  void initState() {
    super.initState();
    currentLocation = LatLng(-38.7370, -72.5788);
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

  Future<List<dynamic>> getUsers() async {
    List<dynamic> direccionesPymes = [];

    await UserService.fetchUsers().then((jsonData) {
      if (jsonData != null) {
        for (var user in jsonData) {
          var direccionPyme = user['direccionPyme'];
          if (direccionPyme != null) {
            direccionesPymes.add(direccionPyme);
          }
        }
      }
    });

    return direccionesPymes;
  }

  void marcarPyme() async {
    List<dynamic> direccionesPymes = await getUsers();

    for (var coords in direccionesPymes) {
      List<String> latlong = coords.split(",");
      double lat = double.parse(latlong[0]);
      double long = double.parse(latlong[1]);
      print("latitud: $lat, longitud: $long");

      Marker newMarker = Marker(
        point: LatLng(lat, long),
        width: 80,
        height: 80,
        child: Icon(
          Icons.location_on,
          size: 50,
          color: Colors.blue,
        ),
      );
      // Agregar el nuevo marcador a la lista de marcadores
      setState(() {
        allMarkers.add(newMarker);
      });
    }
  }

  void cleanMarkers() {
    setState(() {
      allMarkers = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            // Agrega un espacio para el buscador
            height: 100.0,
            color: Colors.white,
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 20.0,
                height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Buscador de pymes',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                    suffixIcon: IconButton(
                      onPressed: () {
                        // Lógica para el botón de búsqueda
                      },
                      icon: Icon(Icons.search),
                      iconSize: 30.0,
                    ),
                  ),
                  onChanged: (value) {
                    // Lógica para la búsqueda mientras escribes
                    // searchUsers(value);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    initialCenter: currentLocation,
                    initialZoom: 6,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      // ...
                    ),
                    ElevatedButton(
                      onPressed: () {
                        cleanMarkers();
                      },
                      child: Icon(Icons.cleaning_services),
                    ),
                    MarkerLayer(
                      markers: [
                        ...allMarkers, // Usar spread operator (...) para añadir todos los marcadores
                        Marker(
                          point: currentLocation,
                          width: 80,
                          height: 80,
                          child: Icon(
                            Icons.location_on,
                            size: 50,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                  bottom: 10.0,
                  right: 10.0,
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          getCurrentPosition();
                        },
                        child: Icon(Icons.location_on),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          //getUsers();
                          marcarPyme();
                        },
                        child: Icon(Icons.store),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
