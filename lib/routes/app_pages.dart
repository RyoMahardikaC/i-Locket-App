import 'package:get/get.dart';
import 'package:i_locket/views/queue/daftar_antrian.dart';
import 'package:i_locket/views/queue/booking.dart' as booking;
import '../views/splash_screen/splash_screen.dart';
import '../views/auth/login.dart';
import '../views/auth/register.dart';
import '../views/home/home_screen.dart';
import '../views/queue/antrian.dart';
import '../views/queue/status_antrian.dart';
import '../views/queue/scan_qr.dart';
import '../views/queue/status_antrian_checkin.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
    ),
     GetPage(
      name: AppRoutes.register,
      page: () => const RegisterScreen(),
     ),
     GetPage(
      name: AppRoutes.home_screen,
      page: () => const HomeScreen(),
     ),
      GetPage(
      name: AppRoutes.daftar_antrian,
      page: () => const DaftarAntrian(),
     ),
     GetPage(
      name: AppRoutes.booking,
      page: () => const booking.QueueBookingScreen(),
     ),
     GetPage(
     name: AppRoutes.antrian, 
     page: () => const RegistrationSuccessScreen()
     ),
     GetPage(
      name: AppRoutes.status_antrian,
      page: () => const StatusAntrianScreen(),
    ),
    GetPage(
    name: AppRoutes.scan_qr,
    page: () => const ScanQrScreen(),
    ),
    GetPage(
    name: AppRoutes.status_antrian_checkin,
    page: () => const StatusAntrianCheckInScreen(),
    ),
  ];
}
