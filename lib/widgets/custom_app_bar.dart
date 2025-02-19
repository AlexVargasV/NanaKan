import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function(String) onSearch;

  CustomAppBar({Key? key, required this.onSearch})
      : preferredSize = const Size.fromHeight(100.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade400, Colors.purple.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 🔹 Menú desplegable (Usamos Builder para evitar problemas de contexto)
              Builder(
                builder: (context) => GestureDetector(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.menu, color: Colors.white, size: 28),
                  ),
                ),
              ),

              // 🔹 Campo de búsqueda o título
              isSearching
                  ? Expanded(
                      child: TextField(
                        controller: searchController,
                        autofocus: true,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: languageProvider.translate("search"),
                          hintStyle: TextStyle(color: Colors.white70),
                          border: InputBorder.none,
                        ),
                        onChanged: widget.onSearch,
                      ),
                    )
                  : Text(
                      "Nana Kan",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 6,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),

              // 🔹 Botón de búsqueda o cerrar búsqueda
              GestureDetector(
                onTap: () {
                  setState(() {
                    isSearching = !isSearching;
                    if (!isSearching) {
                      searchController.clear();
                      widget.onSearch(""); // Restablecer búsqueda
                    }
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isSearching ? Icons.close : Icons.search,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),

              // 🔹 Selector de idioma con menú desplegable
              PopupMenuButton<String>(
                onSelected: (String newLang) {
                  Provider.of<LanguageProvider>(context, listen: false)
                      .changeLanguage(newLang);
                },
                icon: Icon(Icons.language, color: Colors.white, size: 28),
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    value: 'es',
                    child: Row(
                      children: [
                        Icon(Icons.flag, color: Colors.red),
                        SizedBox(width: 8),
                        Text("Español"),
                        if (languageProvider.locale.languageCode == 'es')
                          Icon(Icons.check, color: Colors.green),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'en',
                    child: Row(
                      children: [
                        Icon(Icons.flag, color: Colors.blue),
                        SizedBox(width: 8),
                        Text("English"),
                        if (languageProvider.locale.languageCode == 'en')
                          Icon(Icons.check, color: Colors.green),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
