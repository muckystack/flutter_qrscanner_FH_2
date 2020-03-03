import 'package:flutter/material.dart';
import 'package:qrreaderappfh/src/pages/direcciones_pages.dart';
import 'package:qrreaderappfh/src/pages/mapas_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0; // Se utiliza para saber que pagina mostrar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _callPage(currentIndex), // Metodo para cargar la página que se quiere
      bottomNavigationBar: _crearBottomNavigationBar(),
    );
  }

  Widget _callPage(int paginaActual) {

    // Si estoy en la 0 se regresa mapas y si esta en la 1 regresara direcciones
    switch (paginaActual) {
      case 0: return MapasPage();
      case 1: return DireccionesPage();
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