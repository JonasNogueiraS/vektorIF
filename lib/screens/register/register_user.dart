import 'package:flutter/material.dart';
import 'package:vektor_if/core/themes/app_theme.dart';
import 'package:vektor_if/core/themes/size_extensions.dart';
import 'package:vektor_if/core/widgets/background_image.dart';
import 'package:vektor_if/core/widgets/buttom_generic.dart';
import 'package:vektor_if/core/widgets/custom_back_button.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Controllers
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _institutionNameController = TextEditingController();
  final _addressController = TextEditingController();

// Estados
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _institutionNameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  // --- LÓGICA DO POPUP ---
  Future<void> _handleRegister() async {
    // Inicia o Loading 
    setState(() => _isLoading = true);
    
    // Aplicar lógica de salvar no banco
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Para o Loading
    setState(() => _isLoading = false);

    // 2. Abre o Popup de Sucesso
    showDialog(
      context: context,
      barrierDismissible: false, // Impede que feche clicando fora
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Ícone de Sucesso
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.green, size: 40),
                ),
                const SizedBox(height: 16),
                
                // Texto de Título
                Text(
                  "Cadastro Realizado!",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.colorBlackText,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                
                // Texto de Redirecionamento
                Text(
                  "Você será redirecionado para o gerenciamento...",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.colorGrayText,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );

    // 3. Aguarda 2 segundos
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    // O primeiro pop fecha o Dialog, o pushNamedAndRemoveUntil troca a tela
    Navigator.of(context).pop(); 
    Navigator.pushNamedAndRemoveUntil(context, '/management', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colorBackground,
      
      body: Stack(
        children: [
          BackgroundImage(),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Botão Voltar e Título
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomBackButtom(),
                      const SizedBox(height: 20),
                      Text(
                        "Faça seu cadastro",
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Crie uma conta gratuitamente",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.colorGrayText,
                            ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                //Container com o Formulário
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, -5),
                        )
                      ],
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // --- DADOS DO USUÁRIO ---
                          _buildLabel("Nome completo"),
                          _buildInput(_nameController, "ex: Joao da Silva"),
                          
                          _buildLabel("Informe o e-mail"),
                          _buildInput(_emailController, "emaildousuario@gmail.com", keyboardType: TextInputType.emailAddress),

                          _buildLabel("Informe a senha"),
                          _buildPasswordInput(_passwordController, "********", _obscurePassword, () {
                            setState(() => _obscurePassword = !_obscurePassword);
                          }),

                          _buildLabel("Confirme a senha"),
                          _buildPasswordInput(_confirmPasswordController, "********", _obscureConfirmPassword, () {
                            setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
                          }),

                          const SizedBox(height: 30),

                          // --- DADOS DA INSTITUIÇÃO ---
                          Center(child: _buildImagePicker()),
                          
                          const SizedBox(height: 20),

                          _buildLabel("Nome da Instituição"),
                          _buildInput(_institutionNameController, "ex: Instituto Federal do Maranhão"),

                          _buildLabel("Endereço"),
                          _buildInput(_addressController, "ex: Av. Santos do Santos"),

                          const SizedBox(height: 30),

                          // --- BOTÃO SALVAR ---
                          ButtomGeneric(
                            label: "Salvar",
                            onPressed: _handleRegister,
                            isLoading: _isLoading,
                          ),
                          
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Widgets Auxiliares ---

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 16),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: AppTheme.colorBlackText,
        ),
      ),
    );
  }

  Widget _buildInput(TextEditingController controller, String hint, {TextInputType? keyboardType}) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.colorWhiteText,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildPasswordInput(TextEditingController controller, String hint, bool isObscure, VoidCallback onToggle) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.colorWhiteText,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        controller: controller,
        obscureText: isObscure,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          suffixIcon: IconButton(
            icon: Icon(
              isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              color: Colors.grey,
            ),
            onPressed: onToggle,
          ),
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Abrir galeria...")));
      },
      child: Row(
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD), // Azul clarinho
              shape: BoxShape.rectangle,
              border: Border.all(color: AppTheme.primaryBlue, width: 1),
            ),
            child: const Icon(Icons.camera_alt, color: Colors.black87, size: 30),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              "Adicione uma foto da instituição",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                height: 1.2
              ),
            ),
          ),
        ],
      ),
    );
  }
}