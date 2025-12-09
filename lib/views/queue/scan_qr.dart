import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart'; // Import package scanner
import '../../routes/app_routes.dart';

class ScanQrScreen extends StatefulWidget {
  const ScanQrScreen({super.key});

  @override
  State<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen> {
  // Controller untuk menangani fitur kamera (Flash, Switch Camera)
  MobileScannerController cameraController = MobileScannerController();
  bool isFlashOn = false;

  @override
  Widget build(BuildContext context) {
    // Definisi Warna
    const Color primaryBlue = Color(0xFF3F51B5);

    return Scaffold(
      // AppBar Transparan agar menyatu/sesuai desain
      appBar: AppBar(
        backgroundColor: primaryBlue,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Scan QR",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
        actions: [
          // Icon Flash di AppBar (Opsional, sesuai desain ada icon petir di kanan atas)
          IconButton(
            icon: Icon(
              isFlashOn ? Icons.flash_on : Icons.flash_off,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                isFlashOn = !isFlashOn;
              });
              cameraController.toggleTorch();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // 1. KAMERA SCANNER
          MobileScanner(
            controller: cameraController,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                // LOGIKA KETIKA QR TERDETEKSI
                final String? code = barcode.rawValue;
                if (code != null) {
                  debugPrint('QR Found! $code');

                  /*if (code != null) {
                  // VALIDASI SEDERHANA
                  // Hanya sukses jika QR Code berisi kata "RS-LOCKET"
                  if (code.contains("RS-LOCKET")) {
                      cameraController.stop(); 
                      Get.snackbar("Sukses", "Check-in Berhasil!", backgroundColor: Colors.green);
                      
                      Future.delayed(const Duration(seconds: 2), () {
                          Get.offAllNamed(AppRoutes.home_screen);
                      });
                  } else {
                      // Jika QR Code salah (misal scan QR botol minum)
                      Get.snackbar("Gagal", "QR Code tidak dikenali!", backgroundColor: Colors.red);
                  }
                }*/
                  Get.offNamed(
                    AppRoutes.status_antrian_checkin, 
                    arguments: Get.arguments,
                  );
                  // Stop kamera agar tidak scan berulang kali
                  cameraController.stop();

                  // Tampilkan hasil atau navigasi
                  Get.snackbar(
                    "Berhasil Check-in!",
                    "Kode Antrian: $code",
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                  );

                  // Navigasi balik ke home atau halaman sukses check-in
                  Future.delayed(const Duration(seconds: 2), () {
                    Get.offAllNamed(AppRoutes.home_screen);
                  });
                }
              }
            },
          ),

          // 2. OVERLAY GELAP & KOTAK FOKUS
          // Kita menggunakan ColorFiltered untuk membuat efek "Bolong" di tengah
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.5), // Gelap transparan di sekeliling
              BlendMode.srcOut,
            ),
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    backgroundBlendMode: BlendMode.dstOut,
                  ),
                ),
                Center(
                  child: Container(
                    height: 280,
                    width: 280,
                    decoration: BoxDecoration(
                      color: Colors
                          .black, // Warna ini akan di-"cut" jadi transparan
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 3. GARIS POJOK (CORNER BORDERS) - Visual Saja
          Center(
            child: Container(
              height: 280,
              width: 280,
              decoration: BoxDecoration(
                // Border transparan, kita hanya butuh sudutnya jika mau custom painter
                // Untuk simpelnya, kita pakai border biasa dulu
                border: Border.all(color: Colors.blueAccent, width: 3),
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),

          // 4. TEKS INFORMASI
          Positioned(
            bottom: 150,
            left: 0,
            right: 0,
            child: Column(
              children: const [
                Text(
                  "Arahkan kamera ke QR Code",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),

          // 5. TOMBOL FLASH DI BAWAH (Floating)
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: InkWell(
                onTap: () {
                  setState(() {
                    isFlashOn = !isFlashOn;
                  });
                  cameraController.toggleTorch();
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: primaryBlue.withOpacity(0.8),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isFlashOn ? Icons.flashlight_off : Icons.flashlight_on,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
