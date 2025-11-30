import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/screens/enter_app.dart';
import 'package:vektor_if/screens/institution_list.dart';

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
      },
    );
  }
}
