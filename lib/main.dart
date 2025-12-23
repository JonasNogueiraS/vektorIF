import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/firebase_options.dart';
import 'package:vektor_if/screens/collaborators/collaborators_register.dart';
import 'package:vektor_if/screens/lists/list_details_colaborators.dart';
import 'package:vektor_if/screens/lists/list_details_sectors.dart';
import 'package:vektor_if/screens/loginscreen/login_screen.dart';
import 'package:vektor_if/screens/map/map_editor.dart';
import 'package:vektor_if/screens/map/map_register.dart';
import 'package:vektor_if/screens/map/upload_map.dart';
import 'package:vektor_if/screens/menagement/management.dart';
import 'package:vektor_if/screens/primary/enter_app.dart';
import 'package:vektor_if/screens/home/home_map.dart';
import 'package:vektor_if/screens/primary/institution_list.dart';
import 'package:vektor_if/screens/register/register_user.dart';
import 'package:vektor_if/screens/sectors/sector_register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        '/': (context) => const EnterApp(),

        //visitantes
        '/select-instituition': (context) => const SelectInstitutionScreen(),
        '/home-map': (context) => const HomeMap(),
        '/sectors-list': (context) => const ListDetailsSectors(),
        '/collaborators-list': (context) => const ListDetailsColaborators(),

        //autenticação
        '/register': (context) => const RegisterScreen(),
        '/login': (context) => const LoginScreen(),

        //gerenciamento
        '/management': (context) => const ManagementScreen(),
        '/sectors-register': (context) => const SectorRegisterScreen(),
        '/collaborators-register': (context) => const CollaboratorsRegister(),
        '/map-register': (context) => const MapRegister(),
        '/upload-map': (context) => const UploadMapScreen(),
        '/map-editor': (context) => const MapEditor(),
      },
    );
  }
}
