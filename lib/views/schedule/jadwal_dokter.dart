import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


// --- 1. CONTROLLER (Untuk Ambil Data) ---
class JadwalDokterController extends GetxController {
  final supabase = Supabase.instance.client;
  
  // List untuk menyimpan data dokter
  var doctorList = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSchedules();
  }

  Future<void> fetchSchedules() async {
    try {
      isLoading.value = true;
      // Ambil data dokter diurutkan berdasarkan nama
      final response = await supabase
          .from('doctors')
          .select()
          .order('name', ascending: true);
          
      doctorList.value = List<Map<String, dynamic>>.from(response);
    } catch (e) {
      Get.snackbar("Error", "Gagal memuat jadwal: $e");
    } finally {
      isLoading.value = false;
    }
  }
}

// --- 2. VIEW (Tampilan UI) ---
class JadwalDokterScreen extends StatelessWidget {
  const JadwalDokterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Inisialisasi Controller
    final controller = Get.put(JadwalDokterController());

    // Warna sesuai desain
    const Color primaryBlue = Color(0xFF3F51B5);
    const Color textDark = Color(0xFF1F2937);

    return Scaffold(
      backgroundColor: Colors.white,
      // AppBar
      appBar: AppBar(
        backgroundColor: primaryBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Jadwal dokter",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
      ),
      
      // Body List
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.doctorList.isEmpty) {
          return const Center(child: Text("Belum ada jadwal dokter tersedia."));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(24),
          itemCount: controller.doctorList.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final doctor = controller.doctorList[index];
            return _buildDoctorCard(doctor);
          },
        );
      }),
    );
  }

  // Widget Kartu Dokter (Sesuai Desain)
  Widget _buildDoctorCard(Map<String, dynamic> doctor) {
    const Color primaryBlue = Color(0xFF3F51B5);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        // Border Biru di sekeliling
        border: Border.all(color: primaryBlue.withOpacity(0.5), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Foto Dokter (Bulat / Rounded Rectangle)
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle, // Atau BoxShape.rectangle dengan borderRadius
              image: DecorationImage(
                image: NetworkImage(doctor['image_url'] ?? "https://i.pravatar.cc/150"),
                fit: BoxFit.cover,
                onError: (exception, stackTrace) {
                  // Fallback jika gambar error
                },
              ),
              border: Border.all(color: Colors.grey.shade200),
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Informasi Dokter
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Nama
                Text(
                  doctor['name'] ?? "Nama Dokter",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
                    fontFamily: 'Poppins',
                  ),
                ),
                const SizedBox(height: 4),
                
                // Spesialis
                Text(
                  doctor['specialist'] ?? "Spesialis Umum",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontFamily: 'Poppins',
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                
                // Jam Praktek (Bold Hitam)
                Text(
                  doctor['schedule'] ?? "Jadwal belum tersedia",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700, // Lebih tebal
                    color: Color(0xFF1F2937),
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}