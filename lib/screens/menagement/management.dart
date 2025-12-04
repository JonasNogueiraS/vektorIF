import 'package:flutter/material.dart';
import 'package:vektor_if/core/widgets/custom_back_button.dart';
import 'package:vektor_if/screens/menagement/widget/institution_cards.dart';
import 'package:vektor_if/screens/menagement/widget/list_managements.dart';
import '../../../../../core/themes/app_theme.dart';
import '../../../../../core/widgets/background_image.dart';

class ManagementScreen extends StatelessWidget {
  const ManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
      body: Stack(
        children: [
          BackgroundImage(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [   
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomBackButtom(),
                      Text(
                        "Gerenciamento",
                        style: Theme.of(
                          context,
                        ).textTheme.headlineSmall?.copyWith(),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.menu, color: Color(0xff49454F)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  
                  const InstitutionCard(
                    name: "Instituto Federal do Maranhão", 
                    address: "Caxias-MA"
                    ),
                  const SizedBox(height: 30),

                  ManagementOptionsList(
                    onSectorsTap: () {
                       Navigator.pushNamed(context, '/sectors-register');
                    },
                    onPeopleTap: () {
                       Navigator.pushNamed(context, '/collaborators-register');
                    },
                    onMapTap: () {
                      // Navigator.pushNamed(context, '/map');
                    },
                  ),

                  const SizedBox(height: 30),

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
