import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; 
import 'package:supabase_flutter/supabase_flutter.dart'; // Pastikan import ini ada
import '../../routes/app_routes.dart';

// --- 1. CONTROLLER (State Management) ---
class BookingController extends GetxController {
  // Client Supabase
  final supabase = Supabase.instance.client; 

  // Variables (Observables)
  // List Dokter sekarang menampung Map (Object data dokter lengkap dari DB)
  var doctors = <Map<String, dynamic>>[].obs;
  var isLoadingDoctors = true.obs;

  // Selected Doctor menyimpan object dokter yang dipilih
  var selectedDoctor = Rxn<Map<String, dynamic>>(); 
  
  var selectedDate = DateTime.now().obs;
  var selectedTime = Rxn<TimeOfDay>();
  
  // Controller untuk Text Input
  final TextEditingController complaintController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchDoctors(); // Ambil data dokter saat halaman dibuka
  }

  // --- FUNGSI AMBIL DATA DOKTER (SUPABASE) ---
  Future<void> fetchDoctors() async {
    try {
      isLoadingDoctors.value = true;
      // Select semua kolom dari tabel 'doctors'
      final response = await supabase.from('doctors').select();
      
      // Masukkan hasil ke list observable
      doctors.value = List<Map<String, dynamic>>.from(response);
    } catch (e) {
      Get.snackbar("Error", "Gagal memuat data dokter: $e");
    } finally {
      isLoadingDoctors.value = false;
    }
  }

  // Fungsi Pilih Tanggal Lewat Dialog
  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(), 
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }

  // Fungsi Pilih Tanggal Lewat Bubble (List Horizontal)
  void selectDate(DateTime date) {
    selectedDate.value = date;
  }

  // Fungsi Pilih Jam
  Future<void> pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      selectedTime.value = picked;
    }
  }

  // --- FUNGSI SUBMIT KE DATABASE ---
  Future<void> submitBooking() async {
    // 1. Validasi Input
    if (selectedDoctor.value == null || selectedTime.value == null) {
      Get.snackbar(
        "Data Belum Lengkap", 
        "Mohon pilih dokter dan waktu layanan",
        backgroundColor: Colors.redAccent, 
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(20),
      );
      return;
    }

    try {
      // 2. Tampilkan Loading (Opsional, bisa pakai Get.dialog loading)
      // Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);

      // 3. Persiapkan Data untuk Database
      // Format Tanggal (YYYY-MM-DD) dan Jam (HH:MM:SS) untuk PostgreSQL
      String dateStr = DateFormat('yyyy-MM-dd').format(selectedDate.value);
      String timeStr = "${selectedTime.value!.hour.toString().padLeft(2, '0')}:${selectedTime.value!.minute.toString().padLeft(2, '0')}:00";
      
      // Generate Nomor Antrian Dummy (Di real app bisa pakai logic sequence DB)
      String queueCode = "A-${DateTime.now().second}${DateTime.now().millisecond}"; 

      // 4. Insert ke Tabel 'queues'
      await supabase.from('queues').insert({
        'doctor_id': selectedDoctor.value!['id'], // Ambil ID dari object dokter yang dipilih
        'patient_name': 'Johan (User)', // Nanti diganti user login session
        'booking_date': dateStr,
        'booking_time': timeStr,
        'complaint': complaintController.text,
        'queue_number': queueCode,
      });

      // Tutup loading jika ada
      // if (Get.isDialogOpen == true) Get.back();

      // 5. Navigasi ke Halaman Sukses dengan Data
      Get.toNamed(
        AppRoutes.antrian, 
        arguments: {
          'doctorName': selectedDoctor.value!['name'],
          'poliName': selectedDoctor.value!['specialist'],
          'date': selectedDate.value,
          'time': selectedTime.value,
        }
      );

    } catch (e) {
      // if (Get.isDialogOpen == true) Get.back();
      Get.snackbar(
        "Gagal Booking", 
        "Terjadi kesalahan: $e",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
  
  @override
  void onClose() {
    complaintController.dispose();
    super.onClose();
  }
}

// --- 2. VIEW (UI Screen) ---
class QueueBookingScreen extends StatelessWidget {
  const QueueBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Inisialisasi Controller
    final controller = Get.put(BookingController());

    // Warna dari Desain
    const Color primaryBlue = Color(0xFF3F51B5);
    const Color inputBg = Color(0xFFE8EAF6);
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Daftar Antrian Baru",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontFamily: 'Poppins'),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- DROPDOWN DOKTER (DYNAMIC) ---
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFE0E3F3), 
                borderRadius: BorderRadius.circular(16),
              ),
              child: Obx(() {
                // Tampilkan Loading jika data belum siap
                if (controller.isLoadingDoctors.value) {
                  return const Center(child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ));
                }

                return DropdownButtonHideUnderline(
                  child: DropdownButton<Map<String, dynamic>>(
                    isExpanded: true,
                    hint: Row(
                      children: [
                        const CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.grey,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text("Pilih Dokter", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            Text("Spesialis...", style: TextStyle(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                    // Value harus cocok dengan salah satu item di list (object reference)
                    value: controller.selectedDoctor.value,
                    
                    // Map list dokter dari Supabase ke DropdownMenuItem
                    items: controller.doctors.map((doctor) {
                      return DropdownMenuItem<Map<String, dynamic>>(
                        value: doctor, // Menyimpan seluruh object dokter
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              // Ambil URL gambar dari DB, atau pakai placeholder jika null
                              backgroundImage: NetworkImage(doctor['image_url'] ?? "https://i.pravatar.cc/150?img=11"), 
                              backgroundColor: Colors.grey[300],
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  doctor['name'] ?? "Dokter", 
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)
                                ),
                                Text(
                                  doctor['specialist'] ?? "Umum", 
                                  style: const TextStyle(fontSize: 10, color: Colors.grey)
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      controller.selectedDoctor.value = val;
                    },
                  ),
                );
              }),
            ),
            
            const SizedBox(height: 24),

            // --- CUSTOM CALENDAR WIDGET ---
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFEBC115), // Warna Kuning
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  // 1. Header Kalender (INTERAKTIF)
                  InkWell(
                    onTap: () => controller.pickDate(context),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD6D7F6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() => Text(
                            DateFormat('dd MMMM yyyy').format(controller.selectedDate.value),
                            style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
                          )),
                          const Icon(Icons.calendar_month, size: 20, color: Colors.black87),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),

                  // 2. Bulan (Visualisasi Sederhana)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
                      ].map((month) {
                        return Obx(() {
                          bool isSelectedMonth = DateFormat('MMM').format(controller.selectedDate.value) == month;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              month,
                              style: TextStyle(
                                fontWeight: isSelectedMonth ? FontWeight.bold : FontWeight.w500,
                                decoration: isSelectedMonth ? TextDecoration.underline : TextDecoration.none,
                                decorationThickness: 2,
                                color: Colors.black87,
                              ),
                            ),
                          );
                        });
                      }).toList(),
                    ),
                  ),
                  
                  const Divider(color: Colors.black26),
                  const SizedBox(height: 10),

                  // 3. List Tanggal Horizontal (INTERAKTIF)
                  SizedBox(
                    height: 80,
                    child: Obx(() {
                      DateTime baseDate = controller.selectedDate.value;
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 14,
                        separatorBuilder: (ctx, i) => const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          final date = baseDate.add(Duration(days: index));
                          final isSelected = index == 0; 
                          
                          return InkWell(
                            onTap: () => controller.selectDate(date),
                            child: Container(
                              width: 55,
                              decoration: BoxDecoration(
                                color: isSelected ? Colors.black : Colors.white,
                                borderRadius: BorderRadius.circular(28),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    DateFormat('E').format(date),
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    DateFormat('d').format(date),
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // --- TIME PICKER ---
            const Text("Time*", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => controller.pickTime(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: inputBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => Text(
                      controller.selectedTime.value?.format(context) ?? "--:--",
                      style: TextStyle(
                        color: controller.selectedTime.value == null ? Colors.grey : Colors.black,
                      ),
                    )),
                    const Icon(Icons.access_time, color: Colors.black54),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // --- COMPLAINT INPUT ---
            const Text("What do you feel", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 8),
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: inputBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: controller.complaintController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: "Text Here",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),
            
            const Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Text("0/100", style: TextStyle(color: Colors.grey, fontSize: 12)),
              ),
            ),

            const SizedBox(height: 30),

            // --- SUBMIT BUTTON ---
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => controller.submitBooking(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF254EDB),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}