import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../routes/app_routes.dart';

class ScanQrController extends GetxController {
  // 1. Controller Kamera Bawaan Library
  final MobileScannerController cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    returnImage: true,
  );

  final ImagePicker _picker = ImagePicker();
  var isProcessing = false.obs; // Mencegah scan ganda

  // --- LOGIKA 1: HASIL SCAN DARI KAMERA ---
  void onDetect(BarcodeCapture capture) {
    if (isProcessing.value) return;
    
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final String? code = barcodes.first.rawValue;
      if (code != null) {
        _processQrCode(code);
      }
    }
  }

  // --- LOGIKA 2: HASIL SCAN DARI GALERI (YANG ANDA CARI) ---
  Future<void> pickImageFromGallery() async {
    try {
      // A. Buka Galeri
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return; // User batal pilih

      isProcessing.value = true;

      // B. SURUH LIBRARY BACA GAMBARNYA (Analyze)
      final BarcodeCapture? capture = await cameraController.analyzeImage(image.path);

      if (capture != null && capture.barcodes.isNotEmpty) {
        final String? code = capture.barcodes.first.rawValue;
        if (code != null) {
          _processQrCode(code); // Sukses baca!
        } else {
          Get.snackbar("Gagal", "QR Code tidak terbaca/rusak", backgroundColor: Colors.red, colorText: Colors.white);
        }
      } else {
        Get.snackbar("Gagal", "Tidak ditemukan QR Code di gambar ini", backgroundColor: Colors.orange, colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Gagal memproses gambar: $e");
    } finally {
      isProcessing.value = false;
    }
  }

  // --- LOGIKA 3: PROSES CHECK-IN KE DATABASE ---
  Future<void> _processQrCode(String qrData) async {
    isProcessing.value = true;
    
    // CONTOH LOGIKA: Anggap QR Code berisi "LOKET-CLINIC-XYZ" atau ID Unik
    // Disini Anda bisa validasi apakah QR Code valid milik RS
    
    try {
      // 1. Ambil data args dari halaman sebelumnya (ID Booking)
      final args = Get.arguments as Map<String, dynamic>? ?? {};
      final String bookingId = args['id']?.toString() ?? ""; 

      if(bookingId.isEmpty) {
         // Jika scan langsung tanpa booking (opsional)
      }

      // 2. Update Database: Set is_check_in = true
      final supabase = Supabase.instance.client;
      
      // Update tabel queues berdasarkan ID user saat ini (atau logic lain)
      // Contoh sederhana: Kita anggap scan sukses update semua booking 'Menunggu' user ini
      final user = supabase.auth.currentUser;
      if (user != null) {
          await supabase
            .from('queues')
            .update({'is_check_in': true, 'status': 'Diproses'}) // Update status
            .eq('user_id', user.id)
            .eq('status', 'Menunggu'); // Hanya yg status menunggu
      }

      // 3. Sukses -> Pindah ke Halaman Status Antrian
      Get.snackbar("Berhasil", "Check-in Berhasil!", backgroundColor: Colors.green, colorText: Colors.white);
      
      // Matikan kamera sebelum pindah halaman agar memori aman
      cameraController.stop(); 
      
      // Pindah dan bawa data args kembali
      Get.offNamed(AppRoutes.status_antrian_checkin, arguments: args);

    } catch (e) {
      Get.snackbar("Error", "Gagal Check-in: $e");
    } finally {
      isProcessing.value = false;
    }
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }
}