import 'package:flutter/material.dart';

class PlaceCard extends StatelessWidget {
  final String _title;
  final String _subtitle;
  final String _id;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.place),
            title: Text(_title),
            subtitle: Text(_subtitle),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: const Text("I'm here"),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  PlaceCard(this._title, this._subtitle, this._id);
}
