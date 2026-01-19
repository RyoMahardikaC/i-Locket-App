import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../controllers/scan_qr_controller.dart'; 

class ScanQrScreen extends StatelessWidget {
  const ScanQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScanQrController controller = Get.put(ScanQrController());

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Scan QR Code", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
         ValueListenableBuilder(
            valueListenable: controller.cameraController, 
            builder: (context, state, child) {
              final isTorchOn = state.torchState == TorchState.on;
              
              return IconButton(
                icon: Icon(isTorchOn ? Icons.flash_on : Icons.flash_off),
                onPressed: () => controller.cameraController.toggleTorch(),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.image),
            onPressed: () => controller.pickImageFromGallery(), // <--- PANGGIL FUNGSI INI
          ),
        ],
      ),
      body: Stack(
        children: [
          // 1. LAYAR KAMERA
          MobileScanner(
            controller: controller.cameraController,
            onDetect: controller.onDetect,
          ),

          // 2. OVERLAY KOTAK SCAN (Agar terlihat profesional)
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent, width: 4),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          
          // 3. TEXT PETUNJUK
          const Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Text(
              "Arahkan kamera ke QR Code\natau pilih dari galeri",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          
          // 4. LOADING INDICATOR (Jika sedang memproses gambar)
          Obx(() {
            if (controller.isProcessing.value) {
              return Container(
                color: Colors.black54,
                child: const Center(child: CircularProgressIndicator()),
              );
            }
            return const SizedBox.shrink();
          })
        ],
      ),
    );
  }
}