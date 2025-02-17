import 'package:flutter/material.dart';
import '../views/carcinoma_info_page.dart';
import '../views/calculos_info_renales.dart';
import '../views/dentales_info_page.dart';
import '../views/detail_page.dart';

class AnimatedCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageAsset;

  const AnimatedCard({
    required this.title,
    required this.description,
    required this.imageAsset,
    Key? key,
  }) : super(key: key);

  void _navigateToDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) {
          if (title.trim().toLowerCase() == "cáncer en gatos") {
            return CarcinomaInfoPage();
          } else if (title.trim().toLowerCase() == "cálculos renales") {
            return CalculosInfoPage();
          } else if (title.trim().toLowerCase() == "enfermedades dentales") {
            return DentalesInfoPage();
          } else {
            return DetailPage();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetail(context),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: ClipRect(
                child: Align(
                  alignment: Alignment.topCenter,
                  heightFactor: 0.85, // 🔹 Recorta un 15% de la parte superior
                  child: Image.asset(
                    imageAsset,
                    height: 200, // 🔹 Mantiene altura fija
                    width: double.infinity,
                    fit: BoxFit.cover, // 🔹 Llena el espacio sin distorsionar
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
