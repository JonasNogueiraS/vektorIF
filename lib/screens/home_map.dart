import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/widgets/filter_list.dart';
import 'package:vektor_if/core/widgets/header_background.dart';
import 'package:vektor_if/core/widgets/interactive_map.dart';

class HomeMap extends StatefulWidget {
  const HomeMap({super.key});

  @override
  State<HomeMap> createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  String selectedFilter = "TODOS";
  final List<String> filters = ["TODOS", "LABORATÓRIO", "ADMINISTRATIVO", "TÉCNICO"];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final paddingTop = MediaQuery.of(context).padding.top;
    
    final double headerHeight = size.height * 0.32;
    final double curveWidth = size.width * 0.5;

    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HomeHeader(
              height: headerHeight,
              curveWidth: curveWidth,
              topPadding: paddingTop,
            ),

            // Outros widgets (Filtros e Mapa)
            FilterList(
              filters: filters,
              selectedFilter: selectedFilter,
              onFilterSelected: (val) => setState(() => selectedFilter = val),
            ),

            InteractiveMap(
              height: size.height * 0.45 < 300 ? 300 : size.height * 0.45,
            ),
            
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}