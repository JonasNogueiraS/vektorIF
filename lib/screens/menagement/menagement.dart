import 'package:flutter/material.dart';
import 'package:vektor_if/core/widgets/custom_back_button.dart';
import 'package:vektor_if/screens/menagement/widget/cards_option_menagement.dart';
import 'package:vektor_if/screens/menagement/widget/institution_cards.dart';
import '../../../../../core/themes/app_theme.dart';
import '../../../../../core/widgets/background_image.dart';

class MenagementScreen extends StatelessWidget {
  const MenagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const BackgroundImage(height: 240),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  
                  // --- Cabeçalho ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomBackButtom(),
                      Text(
                        "Gerenciamento",
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.menu, color: Color(0xff49454F)),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // --- Widget: Card da Instituição ---
                  const InstitutionCard(
                    name: "Instituto Federal do Maranhão - IFMA",
                    address: "Caxias - Ma",
                    // imagePath: "assets/images/logo.png", 
                  ),
                  const SizedBox(height: 30),

                  // --- Widget: Opções de Gestão ---
                  ManagementOptionCard(
                    title: "Gestão De Setores",
                    subtitle: "Consulte, adicione e remova setores",
                    icon: Icons.domain,
                    onTap: () {
                       // Ação aqui
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  ManagementOptionCard(
                    title: "Gestão De Pessoa",
                    subtitle: "Consulte, cadastre ou remova colaboradores",
                    icon: Icons.people_alt_outlined,
                    onTap: () {
                      // Ação aqui
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  ManagementOptionCard(
                    title: "Gestão De Mapa",
                    subtitle: "Upload e ajuste de planta baixa",
                    icon: Icons.map_outlined,
                    onTap: () {
                      // Ação aqui
                    },
                  ),

                  const SizedBox(height: 30),

                  // --- Formulário Final ---
                  Text(
                    "Informações da Instituição",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.colorBlackText,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildTextFieldLabel("Nome"),
                  _buildTextFieldInput(initialValue: "Instituto Federal..."),
                  
                  const SizedBox(height: 16),
                  
                  _buildTextFieldLabel("Endereço"),
                  _buildTextFieldInput(initialValue: "Av. Alguma Coisa"),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Mantive apenas os widgets de Input como métodos locais, 
  // pois eles são bem simples, mas você também pode extraí-los se desejar.
  Widget _buildTextFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4),
      child: Text(
        label,
        style: TextStyle(
          color: AppTheme.colorGrayText,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTextFieldInput({required String initialValue}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffF2F2F2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        initialValue: initialValue,
        style: const TextStyle(fontWeight: FontWeight.bold),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}