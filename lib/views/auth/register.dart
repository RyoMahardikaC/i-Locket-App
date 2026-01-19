import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_routes.dart';
// Import AuthController
import '../../controllers/auth_controller.dart'; 

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  // Panggil Controller (Gunakan Get.find jika sudah di-put di login, atau Get.put jika belum)
  final authC = Get.put(AuthController());

  // State Variables
  bool _obscurePassword = true;
  bool _obscureRepeatPassword = true;
  final String _selectedCountryCode = '+62';

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // --- LOGIKA REGISTER (UPDATED) ---
  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      // Gabungkan kode negara dan nomor telepon
      String fullPhoneNumber = '$_selectedCountryCode${_phoneController.text}';

      // Panggil fungsi register dari AuthController
      // Data Nama dan HP akan dikirim sebagai metadata ke Supabase
      authC.register(
        _emailController.text,
        _passwordController.text,
        _fullNameController.text,
        fullPhoneNumber,
      );
    }
  }

  void _navigateToLogin() {
    Get.back(); // Kembali ke halaman Login
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF3F51B5);
    const Color textDark = Color(0xFF1F2937);
    const Color textGrey = Color(0xFF6B7280);

    return Scaffold(
      backgroundColor: primaryBlue,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const SizedBox(height: 40),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Register',
                          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: textDark, fontFamily: 'Poppins'),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Please Register Before Login',
                          style: TextStyle(fontSize: 14, color: textGrey, fontFamily: 'Poppins'),
                        ),
                        const SizedBox(height: 30),

                        // FULL NAME
                        const Text('Full Name*', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _fullNameController,
                          decoration: _buildInputDecoration("Fullname", null),
                          validator: (val) => (val == null || val.isEmpty) ? 'Wajib diisi' : null,
                        ),
                        const SizedBox(height: 20),

                        // EMAIL
                        const Text('Email*', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: _buildInputDecoration("Placeholder", Icons.email_outlined, iconColor: primaryBlue),
                          validator: (val) {
                            if (val == null || val.isEmpty) return 'Wajib diisi';
                            if (!val.contains('@')) return 'Email tidak valid';
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // PASSWORD
                        const Text('Password*', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: _buildInputDecoration(
                            "Password", Icons.lock_outline, 
                            iconColor: primaryBlue,
                            suffixIcon: IconButton(
                              icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
                              onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                            ),
                          ),
                          validator: (val) => (val != null && val.length < 6) ? 'Minimal 6 karakter' : null,
                        ),
                        const SizedBox(height: 20),

                        // REPEAT PASSWORD
                        const Text('Repeat Password*', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _repeatPasswordController,
                          obscureText: _obscureRepeatPassword,
                          decoration: _buildInputDecoration(
                            "Repeat Password", Icons.lock_outline, 
                            iconColor: primaryBlue,
                            suffixIcon: IconButton(
                              icon: Icon(_obscureRepeatPassword ? Icons.visibility_off : Icons.visibility, color: Colors.grey),
                              onPressed: () => setState(() => _obscureRepeatPassword = !_obscureRepeatPassword),
                            ),
                          ),
                          validator: (val) {
                            if (val != _passwordController.text) return 'Password tidak sama';
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // PHONE INPUT
                        const Text('Phone Input*', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: 'Input Phone Number',
                            hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'Poppins'),
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Container(
                              width: 100,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                children: [
                                  Container(
                                    width: 24, height: 16,
                                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(2), border: Border.all(color: Colors.grey.shade300)),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(_selectedCountryCode, style: const TextStyle(fontWeight: FontWeight.bold, color: textDark)),
                                  const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey),
                                ],
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: primaryBlue, width: 2)),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                            contentPadding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          validator: (val) => (val == null || val.isEmpty) ? 'Wajib diisi' : null,
                        ),
                        const SizedBox(height: 32),

                        // REGISTER BUTTON (UPDATED WITH OBX & LOADING)
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: Obx(() => ElevatedButton(
                            onPressed: authC.isLoading.value ? null : _handleRegister,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryBlue,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: authC.isLoading.value
                                ? const SizedBox(
                                    height: 24, width: 24,
                                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                                  )
                                : const Text(
                                    'Register',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Poppins'),
                                  ),
                          )),
                        ),
                        const SizedBox(height: 24),

                        // LOGIN LINK
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Have an account? ", style: TextStyle(fontSize: 14, color: textDark, fontFamily: 'Poppins')),
                            GestureDetector(
                              onTap: _navigateToLogin,
                              child: const Text('Login Here', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: primaryBlue, fontFamily: 'Poppins')),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hint, IconData? icon, {Color? iconColor, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey, fontFamily: 'Poppins'),
      prefixIcon: icon != null ? Icon(icon, color: iconColor ?? Colors.grey) : null,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade300)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF3F51B5), width: 2)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}