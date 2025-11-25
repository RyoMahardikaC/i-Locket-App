// File: lib/views/auth/register.dart

import 'package:flutter/material.dart';
import 'package:i_locket/views/auth/login.dart';
import 'package:i_locket/views/home/home_screen.dart'; // pastikan path HomeScreen benar

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureRepeatPassword = true;
  String _selectedCountryCode = '+62';

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // ==============================
  //  HANDLE REGISTER
  // ==============================
  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      print('Full Name: ${_fullNameController.text}');
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
      print('Phone: $_selectedCountryCode${_phoneController.text}');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration successful!'),
          backgroundColor: Color(0xFF4F46E5),
        ),
      );

      // Navigasi setelah delay
      Future.delayed(const Duration(milliseconds: 1500), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      });
    }
  }

  // ==============================
  //  BACK TO LOGIN
  // ==============================
  void _navigateToLogin() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4F46E5),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 60),

            // Registration Form Card
            Expanded(
              child: Container(
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

                        // Title
                        const Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Subtitle
                        const Text(
                          'Please Register Before Login',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF9CA3AF),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // ==============================
                        // FULL NAME
                        // ==============================
                        const Text(
                          'Full Name*',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _fullNameController,
                          decoration: InputDecoration(
                            hintText: 'Fullname',
                            filled: true,
                            fillColor: const Color(0xFFF3F4F6),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) =>
                              (value == null || value.isEmpty)
                                  ? 'Please enter your full name'
                                  : null,
                        ),
                        const SizedBox(height: 20),

                        // ==============================
                        // EMAIL
                        // ==============================
                        const Text(
                          'Email*',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: Color(0xFF4F46E5),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF3F4F6),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // ==============================
                        // PASSWORD
                        // ==============================
                        const Text(
                          'Password*',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: Color(0xFF4F46E5),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF3F4F6),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // ==============================
                        // REPEAT PASSWORD
                        // ==============================
                        const Text(
                          'Repeat Password*',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _repeatPasswordController,
                          obscureText: _obscureRepeatPassword,
                          decoration: InputDecoration(
                            hintText: 'Repeat Password',
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: Color(0xFF4F46E5),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureRepeatPassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureRepeatPassword =
                                      !_obscureRepeatPassword;
                                });
                              },
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF3F4F6),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please repeat your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // ==============================
                        // PHONE
                        // ==============================
                        const Text(
                          'Phone Input*',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: 'Input Phone Number',
                            prefixIcon: Container(
                              padding: const EdgeInsets.only(left: 16, right: 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 24,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _selectedCountryCode,
                                    style: const TextStyle(
                                      color: Color(0xFF111827),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            ),
                            filled: true,
                            fillColor: const Color(0xFFF3F4F6),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (value) =>
                              (value == null || value.isEmpty)
                                  ? 'Please enter your phone number'
                                  : null,
                        ),
                        const SizedBox(height: 32),

                        // ==============================
                        // BUTTON REGISTER
                        // ==============================
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _handleRegister,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4F46E5),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // ==============================
                        // LOGIN LINK
                        // ==============================
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Have an account? ',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF111827),
                              ),
                            ),
                            TextButton(
                              onPressed: _navigateToLogin,
                              child: const Text(
                                'Login Here',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF4F46E5),
                                ),
                              ),
                            ),
                          ],
                        ),
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
}