import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/screens/menagement/menagement.dart';
import 'package:vektor_if/screens/primary/enter_app.dart';
import 'package:vektor_if/screens/home/home_map.dart';
import 'package:vektor_if/screens/primary/institution_list.dart';

void main() {
  runApp(const VektorApp());
}

class VektorApp extends StatelessWidget {
  const VektorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VektorIF',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      
      initialRoute: '/',
      routes: {
        '/':(context) => const EnterApp(),
        '/select-instituition': (context) => const SelectInstitutionScreen(),
        '/home-map':(context) => const HomeMap(),
        '/menagement': (context) => const MenagementScreen(),
      },
    );
  }
}
