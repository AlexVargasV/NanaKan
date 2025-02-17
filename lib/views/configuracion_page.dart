import 'package:flutter/material.dart';

class ConfiguracionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController nombreController = TextEditingController();
    final TextEditingController edadController = TextEditingController();
    final TextEditingController fechaVacunaController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Configuración de Cuenta"),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: nombreController,
              decoration: InputDecoration(labelText: "Nombre de la mascota"),
            ),
            TextField(
              controller: edadController,
              decoration: InputDecoration(labelText: "Edad de la mascota"),
            ),
            TextField(
              controller: fechaVacunaController,
              decoration: InputDecoration(labelText: "Fecha de última vacuna"),
            ),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Datos guardados con éxito.")),
                );
              },
              child: Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}
