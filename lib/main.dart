import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_routes.dart';
import 'routes/app_pages.dart';
import './services/supabase_service.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();

  try {
    await Get.putAsync(() => SupabaseService().init());
    print('✅ Supabase berhasil diinisialisasi');
  } catch (e) {
    print('❌ Supabase gagal diinisialisasi');
    print('Error: $e');
  }

  runApp(const OnlineConsultantApp());
  
}

class OnlineConsultantApp extends StatelessWidget {
  const OnlineConsultantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Online Consultant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 141, 37, 37),
        ),
        fontFamily: 'SF Pro Display',
      ),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}


// // main.dart - Online Consultant Mobile App (Flutter)

// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'views/auth/login.dart';

// void main() {
//   runApp(const OnlineConsultantApp());
// }

// class OnlineConsultantApp extends StatelessWidget {
//   const OnlineConsultantApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Online Consultant',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(
//           seedColor: const Color.fromARGB(
//             255,
//             141,
//             37,
//             37,
//           ), // ganti dengan HEX kamu
//         ),
//         fontFamily: 'SF Pro Display',
//       ),

//       home: const SplashScreen(),
//     );
//   }
// }

// // Splash Screen
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 1000),
//       vsync: this,
//     );

//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
//     _controller.forward();

//     // Navigate to Login after 2.5 seconds
//     Timer(const Duration(milliseconds: 2500), () {
//       Navigator.of(
//         context,
//       ).pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF4F46E5),
//       body: Center(
//         child: FadeTransition(
//           opacity: _fadeAnimation,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // Stethoscope Icon
//               Container(
//                 padding: const EdgeInsets.all(20),
//                 child: const Icon(
//                   Icons.monitor_heart_outlined,
//                   size: 80,
//                   color: Colors.white,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               const Text(
//                 'Hallo',
//                 style: TextStyle(
//                   fontSize: 36,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
