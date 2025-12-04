import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/themes/size_extensions.dart';
import 'package:vektor_if/core/widgets/background_image.dart';
import 'package:vektor_if/core/widgets/custom_back_button.dart';
import 'package:vektor_if/screens/map/widget/map_option_card.dart';

class MapRegister extends StatelessWidget {
  const MapRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
      body: Stack(
        children: [
          const BackgroundImage(),
          SafeArea(
            child: SingleChildScrollView(
              // evitar overflow em telas pequenas
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.percentWidth(0.05),
                  vertical: context.percentHeight(0.02),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    // --- HEADER ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomBackButtom(),
                        Text(
                          "Gestão de Mapas",
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff49454F),
                              ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.menu,
                            color: Color(0xff49454F),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: context.percentHeight(0.03)),

                    // --- BANNER DE IMAGEM (NOVO) ---
                    Center(
                      child: Container(
                        width: 200, 
                        height:200, 
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle, 
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/images/ilustration_map_route.png',
                            ),
                            fit: BoxFit.cover, 
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: context.percentHeight(0.04)),

                    const Text(
                      "O que você deseja fazer?",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff49454F),
                      ),
                    ),

                    SizedBox(height: context.percentHeight(0.02)),

                    // --- OPÇÃO 1: NOVO MAPA ---
                    MapOptionCard(
                      title: "Novo Mapa",
                      subtitle:
                          "Faça upload de uma nova planta baixa ou mapa do setor.",
                      icon: Icons.add_location_alt_outlined,
                      onTap: () {
                        Navigator.pushNamed(context, '/upload-map');
                      },
                    ),

                    // --- OPÇÃO 2: ATUALIZAR MAPA ---
                    MapOptionCard(
                      title: "Atualizar Mapa",
                      subtitle:
                          "Edite ou substitua um mapa já existente no sistema.",
                      icon: Icons.edit_location_alt_outlined,
                      onTap: () {
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
