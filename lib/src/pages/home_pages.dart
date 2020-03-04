import 'dart:io';

import 'package:flutter/material.dart';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:qrreaderappfh/src/bloc/scans_bloc.dart';
import 'package:qrreaderappfh/src/models/scan_model.dart';

import 'package:qrreaderappfh/src/pages/direcciones_pages.dart';
import 'package:qrreaderappfh/src/pages/mapas_page.dart';
import 'package:qrreaderappfh/src/utils/utils.dart' as utils;


class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scansBloc = new ScansBloc();
  int currentIndex = 0; // Se utiliza para saber que pagina mostrar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QRScanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: scansBloc.borrarScanTODOS,
          )
        ],
      ),
      body: _callPage(currentIndex), // Metodo para cargar la página que se quiere
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.filter_center_focus),
          onPressed: _scanQR,
          backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  _scanQR() async {

    // http://170.239.150.178:90/#/login
    // geo:21.0178536078798,-101.25684156855472

    String futureString = 'http://170.239.150.178:90/#/login';

    // try {
    //   futureString = await BarcodeScanner.scan();
    // } catch (e) {
    //   futureString = e.toString();
    // }

    // print('Future string: $futureString');

    if(futureString != null) {
      //  print('Tenemos información');
      final scan = ScanModel(valor: futureString);
      //  DBProvider.db.nuevoScan(scan);
      scansBloc.agregarScan(scan);
      
      final scan2 = ScanModel(valor: 'geo:21.0178536078798,-101.25684156855472');
      scansBloc.agregarScan(scan2);

      if(Platform.isIOS) {
        Future.delayed(Duration(milliseconds: 750), () {
          utils.abrirScan(scan);
        });
      }else {
        utils.abrirScan(scan);
      }
    }

  }

  Widget _callPage(int paginaActual) {

    // Si estoy en la 0 se regresa mapas y si esta en la 1 regresara direcciones
    switch (paginaActual) {
      case 0: return MapasPage();
      case 1: return DireccionesPage();
      default: return MapasPage();
    }

  }

  Widget _crearBottomNavigationBar() {

    return BottomNavigationBar(
      currentIndex: currentIndex, // que elemento es el que esta activo
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Mapas')),
        BottomNavigationBarItem(icon: Icon(Icons.brightness_5), title: Text('Direcciones'))
      ],
    );

  }
}