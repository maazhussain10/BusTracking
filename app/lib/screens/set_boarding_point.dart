import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
import 'package:location/location.dart';


class SetBoardingPoint extends StatefulWidget {
  const SetBoardingPoint({Key? key}) : super(key: key);

  @override
  _SetBoardingPointState createState() => _SetBoardingPointState();
}

class _SetBoardingPointState extends State<SetBoardingPoint> {

  final MapController _mapController = MapController();



  // OnInit
  @override
   void initState()  {
    super.initState();
    _setCenter();
  }

  Future<void> _setCenter() async {
    await _getUserLocation();

  }

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late List<Marker> _markers = <Marker>[];

  LocationData? _userLocation;

  Future<void> _getUserLocation() async {
    Location location = Location();

    // Check if location service is enable
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // Check if permission is granted
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final _locationData = await location.getLocation();
    print("LocationData: $_locationData");
    _mapController.move(latLng.LatLng(_locationData.latitude!, _locationData.longitude!), 13);
    setState(() {
      _markers = <Marker>[
        Marker(
          width: 80.0,
          height: 80.0,
          point: latLng.LatLng(_locationData.latitude!, _locationData.longitude!),
          builder: (ctx) => const Icon(Icons.location_on, color: Colors.red),
        ),
      ];
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: latLng.LatLng(_userLocation?.longitude ?? 0, _userLocation?.latitude ?? 0),
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://api.mapbox.com/styles/v1/nitinmano/cl2ilvv72000s14mkp9vw4jbh/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoibml0aW5tYW5vIiwiYSI6ImNsMmlsZ2h1ODAxdmMzZnBnNWJ0cmY4M2sifQ.HdV3Kl38EH1IxMmm2ojs9g",
            additionalOptions: {
              'accessToken': 'pk.eyJ1IjoiZHdhYnp5IiwiYSI6ImNsMW5nMmQ2cjBwM24zYnFyaXJ4ZGVmaHQifQ.idwpgkuiKGkfbaMrjNRNCA',
              'id': 'mapbox.mapbox-streets-v8',
            },
            attributionBuilder: (_) {
              return const Text("© NMPro");
            },
          ),
          MarkerLayerOptions(
            markers: _markers,
          ),
        ],
      ),
    );
  }
}
