import 'package:flutter/material.dart';
import 'dart:async';
import 'package:i_locket/views/auth/register.dart';

// Login Screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement login logic
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
      print('Remember Me: $_rememberMe');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login functionality - Connect to your backend API'),
          backgroundColor: Color(0xFF4F46E5),
        ),
      );
    }
  }

  void _handleRegister() {
    // TODO: Navigate to Register screen
     Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const RegisterScreen()),
  );
   /* ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Navigate to Register Screen'),
        backgroundColor: Color(0xFF4F46E5),
      ),
    );*/
  }

  void _handleForgotPassword() {
    // TODO: Navigate to Forgot Password screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Navigate to Forgot Password Screen'),
        backgroundColor: Color(0xFF4F46E5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4F46E5),
      body: SafeArea(
        child: Column(
          children: [
            // Header with Stethoscope Icon
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: const Icon(
                Icons.monitor_heart_outlined,
                size: 70,
                color: Colors.white,
              ),
            ),

            // Login Form Card
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
                          'Login',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Subtitle
                        const Text(
                          'Please Login to Online Consultant',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF9CA3AF),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Email Input
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
                            hintText: 'Placeholder',
                            hintStyle: const TextStyle(
                              color: Color(0xFF9CA3AF),
                            ),
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: Color(0xFF4F46E5),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(0xFFE5E7EB),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(0xFFE5E7EB),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(0xFF4F46E5),
                                width: 2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
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

                        // Password Input
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
                            hintStyle: const TextStyle(
                              color: Color(0xFF9CA3AF),
                            ),
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: Color(0xFF4F46E5),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: const Color(0xFF9CA3AF),
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(0xFFE5E7EB),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(0xFFE5E7EB),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: Color(0xFF4F46E5),
                                width: 2,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
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
                        const SizedBox(height: 16),

                        // Remember Me & Forgot Password
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Remember Me Checkbox
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Checkbox(
                                    value: _rememberMe,
                                    onChanged: (value) {
                                      setState(() {
                                        _rememberMe = value ?? false;
                                      });
                                    },
                                    activeColor: const Color(0xFF4F46E5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Remember Me',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF4F46E5),
                                  ),
                                ),
                              ],
                            ),

                            // Forgot Password
                            TextButton(
                              onPressed: _handleForgotPassword,
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF4F46E5),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),

                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4F46E5),
                              foregroundColor: Colors.white,
                              elevation: 8,
                              shadowColor: const Color(
                                0xFF4F46E5,
                              ).withOpacity(0.3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Register Link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't Have an account? ",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF111827),
                              ),
                            ),
                            TextButton(
                              onPressed: _handleRegister,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(0, 0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                'Register Here',
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
