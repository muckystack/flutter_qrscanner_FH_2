import 'package:flutter/material.dart';
import 'package:qrreaderappfh/src/bloc/scans_bloc.dart';
import 'package:qrreaderappfh/src/providers/db_provider.dart';
import 'package:qrreaderappfh/src/utils/utils.dart' as utils;


class MapasPage extends StatelessWidget {
  final scansBloc = new ScansBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: scansBloc.scansStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        
        if(!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final scans = snapshot.data;

        if(scans.length == 0) {
          return Center(child: Text('No hay datos'));
        }

        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (context, i) => Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.red,
            ),
            onDismissed: (direction) => scansBloc.borrarScan(scans[i].id),
            child: ListTile(
              leading: Icon(Icons.cloud_queue, color: Theme.of(context).primaryColor),
              title: Text(scans[i].valor),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
              subtitle: Text('ID: ${ scans[i].id }'),
              onTap: () => utils.abrirScan(context, scans[i]),
            ),
          ),
        );
      
      },
    );
  }
}