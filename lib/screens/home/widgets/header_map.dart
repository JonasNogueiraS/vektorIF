import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vektor_if/core/themes/size_extensions.dart';
import 'package:vektor_if/core/widgets/background_image.dart';
import 'package:vektor_if/core/widgets/menu_buttons.dart';
import '../../../../../core/themes/app_theme.dart';

class HomeHeader extends StatelessWidget {
  // NOVOS PARÂMETROS
  final String institutionName;
  final ValueChanged<String>? onSearchChanged;

  const HomeHeader({
    super.key,
    this.institutionName =
        "Nome da sua instituição", // Valor padrão
    this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final isManager = user != null;

    final List<MenuOption> menuOptions = isManager
        ? _buildManagerOptions(context)
        : _buildVisitorOptions(context);

    return SizedBox(
      height: context.percentHeight(0.25), 
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const BackgroundImage(),
          Padding(
            padding: EdgeInsets.fromLTRB(
              24,
              context.percentHeight(0.06),
              24,
              0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_none),
                      color: AppTheme.colorBlackText,
                    ),
                    SettingsMenuButton(options: menuOptions),
                  ],
                ),

                SizedBox(
                  width: context.percentWidth(0.65),
                  child: Text(
                    institutionName,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.colorBlackText,
                    ),
                    maxLines: 2, //não quebre layout
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          // Barra de Busca
          Positioned(
            bottom: -10, 
            left: 24,
            right: 24,
            child: Container(
              height: 45, 
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
                onChanged: onSearchChanged,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "Procure por pessoa, setor...",
                  hintStyle: const TextStyle(
                    color: Color(0xff49454F),
                    fontSize: 14,
                  ),
                  prefixIcon: const SizedBox(width: 10),
                  suffixIcon: const Icon(
                    Icons.search,
                    color: AppTheme.colorGrayText,
                    size: 20,
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

  List<MenuOption> _buildManagerOptions(BuildContext context) {
    return [
      MenuOption(
        label: "Trocar Instituição",
        icon: Icons.swap_horiz,
        onTap: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/select-instituition',
            (route) => false,
          );
        },
      ),
      MenuOption(
        label: "Gerenciamento",
        icon: Icons.admin_panel_settings_outlined,
        onTap: () {
          Navigator.pushNamed(context, '/management');
        },
      ),
      MenuOption(
        label: "Sair",
        icon: Icons.logout,
        color: Colors.redAccent,
        onTap: () async {
          await FirebaseAuth.instance.signOut();
          if (context.mounted) {
            Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          }
        },
      ),
    ];
  }

  List<MenuOption> _buildVisitorOptions(BuildContext context) {
    return [
      MenuOption(
        label: "Trocar Instituição",
        icon: Icons.swap_horiz,
        onTap: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/select-instituition',
            (route) => false,
          );
        },
      ),
      MenuOption(
        label: "Sair do App",
        icon: Icons.exit_to_app,
        color: Colors.redAccent,
        onTap: () {
          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
        },
      ),
    ];
  }
}
