import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:qrreaderappfh/src/models/scan_model.dart';

abrirScan(ScanModel scan) async {
  // const url = 'https://flutter.dev';

  if(scan.tipo == 'http'){

    if (await canLaunch(scan.valor)) {
      await launch(scan.valor);
    } else {
      throw 'Could not launch ${scan.valor}';
    }

  }else {
    print('GEO...');
  }
}