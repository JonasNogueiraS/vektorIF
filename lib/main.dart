import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/screens/collaborators/collaborators_register.dart';
import 'package:vektor_if/screens/map/map_register.dart';
import 'package:vektor_if/screens/map/upload_map.dart';
import 'package:vektor_if/screens/menagement/management.dart';
import 'package:vektor_if/screens/primary/enter_app.dart';
import 'package:vektor_if/screens/home/home_map.dart';
import 'package:vektor_if/screens/primary/institution_list.dart';
import 'package:vektor_if/screens/sectors/sector_register.dart';

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
        '/management': (context) => const ManagementScreen(),
        '/sectors-register': (context) => const SectorRegisterScreen(),
        '/collaborators-register': (context) => const CollaboratorsRegister(),
        '/map-register': (context) => const MapRegister(),
        '/upload-map': (context) => const UploadMapScreen(),
      },
    );
  }
}
