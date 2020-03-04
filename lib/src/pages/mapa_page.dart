import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:qrreaderappfh/src/models/scan_model.dart';

class MapaPage extends StatelessWidget {
  final MapController map = new MapController();

  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              map.move(scan.getLatLng(), 15);
            },
          )
        ],
      ),
      body: _crearFlutterMap(scan),
    );
  }

  Widget _crearFlutterMap(ScanModel scan) {
    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center: scan.getLatLng(),
        zoom: 15
      ),
      layers: [
        _crearMapa(),
        _crearMarcadores(scan)
      ],
    );
  }


  _crearMapa() {

    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken': 'pk.eyJ1IjoibXVja3lzdGFjayIsImEiOiJjazU0eGhidHcwMHZ3M2xzN2w0eXdsdmJkIn0.MvGNRnHmgDF5syHT5Wra7w',
        'id': 'mapbox.dark'
        // streets, dark, light, outdoors, satellite
      }
    );

  }

  _crearMarcadores(ScanModel scan) {

    return MarkerLayerOptions(
      markers: <Marker> [
        Marker(
          width: 100.0,
          height: 100.0,
          point: scan.getLatLng(),
          builder: (context) => Container(
            // color: Colors.red,
            child: Icon(
              Icons.location_on,
              size: 70.0,
              color: Theme.of(context).primaryColor
            ),
          )
        )
      ]
    );

  }
}