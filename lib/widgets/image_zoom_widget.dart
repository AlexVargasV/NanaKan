import 'package:flutter/material.dart';

class ImageZoomWidget extends StatelessWidget {
  final String imagePath;

  const ImageZoomWidget({required this.imagePath, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vista de Imagen"),
      ),
      body: Center(
        child: InteractiveViewer(
          boundaryMargin: const EdgeInsets.all(20),
          minScale: 0.5, // Escala mínima
          maxScale: 5.0, // Escala máxima
          child: Hero(
            tag: imagePath,
            child: Image.asset(imagePath),
          ),
        ),
      ),
    );
  }
}
