import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/size_extensions.dart';
import 'package:vektor_if/core/widgets/background_image.dart';
import '../../../../../core/themes/app_theme.dart';

class HomeHeader extends StatelessWidget {


  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.percentHeight(0.30),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          BackgroundImage(),
          // Textos
          Padding(
            padding: EdgeInsets.fromLTRB(24, context.percentHeight(0.05), 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ícones
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_none),
                      color: AppTheme.colorBlackText,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/management');
                      },
                      icon: const Icon(Icons.settings_outlined),
                      color: AppTheme.colorBlackText,
                    ),
                  ],
                ),

                // Título
                SizedBox(
                  width: context.percentWidth(0.65),
                  child: Text(
                    "Instituto Federal do Maranhão - IFMA",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.colorBlackText,
                    ),
                  ),
                ),
              ],
            ),
          ),

          //Barra de Busca
          Positioned(
            bottom: 0,
            left: 24,
            right: 24,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xffF2F2F2),
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
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
