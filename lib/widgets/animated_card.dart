import 'package:flutter/material.dart';
import '../views/carcinoma_info_page.dart';
import '../views/calculos_info_renales.dart';
import '../views/dentales_info_page.dart';
import '../views/detail_page.dart';
import 'package:diacritic/diacritic.dart';

class AnimatedCard extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final String imageAsset;

  const AnimatedCard({
    required this.id,
    required this.title,
    required this.description,
    required this.imageAsset,
    Key? key,
  }) : super(key: key);

  void _navigateToDetail(BuildContext context) {
    // 🔹 Normalizamos el título quitando caracteres especiales y espacios extra
    String normalizedTitle = removeDiacritics(title.toLowerCase().trim());

    print("🔍 Navegando a: $normalizedTitle"); // 🔹 Depuración

    Widget nextPage;
    switch (id) {
      case "cancer":
        nextPage = CarcinomaInfoPage();
        break;
      case "calculos":
        nextPage = CalculosInfoPage();
        break;
      case "dentales":
        nextPage = DentalesInfoPage();
        break;
      default:
        nextPage = DetailPage();
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => nextPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.grey[900] : Colors.white;
    final titleColor = isDarkMode ? Colors.white : Colors.black87;
    final descriptionColor = isDarkMode ? Colors.grey[300] : Colors.grey[600];

    return GestureDetector(
      onTap: () => _navigateToDetail(context),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
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
              child: Image.asset(
                imageAsset,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
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
                      color: titleColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: descriptionColor,
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
