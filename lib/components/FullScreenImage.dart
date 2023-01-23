import 'package:flutter/material.dart';

class FullScreenImage extends StatefulWidget {
  String image;
  String title;
  
  FullScreenImage({Key? key, required this.image, required this.title});

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                widget.image,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
