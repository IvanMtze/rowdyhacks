import 'package:flutter/material.dart';

class PlaceCard extends StatelessWidget {


  final String _title;
  final String _subtitle;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.album),
            title: Text(_title),
            subtitle: Text(_subtitle),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: const Text('Delete from my history'),
                onPressed: () {/* ... */},
              ),
            ],
          ),
        ],
      ),
    );
  }
  PlaceCard(this._title, this._subtitle);
}
