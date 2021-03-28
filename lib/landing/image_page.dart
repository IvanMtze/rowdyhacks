import 'package:flutter/material.dart';

class ImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("Image viewer"),
      ),
      body: Center(
        child: Image(image: NetworkImage(args.url)),
      ),
    );
  }
}

class ScreenArguments {
  final String url;
  ScreenArguments(this.url);
}
