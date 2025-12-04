import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/themes/size_extensions.dart';
import 'package:vektor_if/screens/primary/widgets/filter_list.dart';
import 'package:vektor_if/screens/home/widgets/header_map.dart';
import 'package:vektor_if/screens/home/widgets/interactive_map.dart';

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

    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HomeHeader(),
            FilterList(
              filters: filters,
              selectedFilter: selectedFilter,
              onFilterSelected: (val) => setState(() => selectedFilter = val),
            ),

            InteractiveMap(
              height: context.percentHeight(0.45) * 0.45 < 300 ? 300 : context.percentHeight(0.45),
            ),
            
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}