import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';

class HomeMap extends StatefulWidget {
  const HomeMap({super.key});

  @override
  State<HomeMap> createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  String selectedFilter = "TODOS";
  final List<String> filters = [
    "TODOS",
    "LABORATÓRIO",
    "ADMINISTRATIVO",
    "TÉCNICO",
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final double headerHeight = size.height * 0.32;
    final double curveWidth = size.width * 0.5;

    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: headerHeight,
              child: Stack(
                children: [
                  Positioned(
                    top: headerHeight * 0.2,
                    right: 0,
                    width: curveWidth * 0.4,
                    height: headerHeight * 0.8,
                    child: Image.asset(
                      "assets/images/bg_curve_direita.png",
                      fit: BoxFit.fill,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(24, size.height * 0.05, 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () => {},
                              icon: const Icon(Icons.notifications_none),
                              color: AppTheme.colorGrayText,
                            ),
                            IconButton(
                              onPressed: () => {},
                              icon: const Icon(Icons.settings_outlined),
                              color: AppTheme.colorGrayText,
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.02),

                        SizedBox(
                          width: size.width * 0.70,
                          child: Text(
                            "Instituto Federal do Maranhão - IFMA",
                            style: Theme.of(context).textTheme.displayMedium
                                ?.copyWith(
                                  fontSize: size.width < 360 ? 18 : 24,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 24,
                    right: 24,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xffF2F2F2),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(

                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: "Procure por pessoa, setor...",
                          hintStyle: const TextStyle(color: Color(0xff49454F)),
                          prefixIcon: const SizedBox(width: 10),
                          suffixIcon: const Icon(
                            Icons.search,
                            color: AppTheme.colorGrayText,
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: filters.map((filter) {
                    final isSelected = selectedFilter == filter;
                    return Padding(
                      padding: const EdgeInsets.only(right: 6),
                      child: ChoiceChip(
                        label: Text(filter),
                        selected: isSelected,
                        onSelected: (bool selected) {
                          setState(() {
                            selectedFilter = filter;
                          });
                        },

                        visualDensity: VisualDensity.compact,

                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

                        selectedColor: AppTheme.primaryBlue,
                        backgroundColor: Color(0xffD8E7FF),
                        
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Color(0xff006FFD),
                          fontWeight: FontWeight.bold,
                          fontSize: size.width < 360 ? 10 : 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(
                            color: isSelected
                                ? Colors.transparent
                                : AppTheme.primaryBlue,
                          ),
                        ),
                        showCheckmark: false,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                height: size.height * 0.45 < 300 ? 300: size.height * 0.45,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: InteractiveViewer(
                    minScale: 0.1,
                    maxScale: 5.0,  
                    child: Image.asset(
                      "assets/images/map_image.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _ZoomButton extends StatelessWidget {
  final IconData icon;
  const _ZoomButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(icon, color: const Color(0xFF4F378A), size: 30),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }
}

// Widget auxiliar para o Marcador do Mapa
class _MapMarker extends StatelessWidget {
  final String label;
  const _MapMarker({required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppTheme.primaryBlue,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.amber, width: 2), // Borda dourada
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        const Icon(Icons.location_on, color: Color(0xFF4F378A), size: 30),
      ],
    );
  }
}
