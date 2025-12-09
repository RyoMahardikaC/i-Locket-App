import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; 
import '../../routes/app_routes.dart';

// --- 1. CONTROLLER (State Management) ---
class BookingController extends GetxController {
  // Data Dokter Dummy
  final List<String> doctors = [
    "Dr. Stone",
    "Dr. Chopper",
    "Dr. Strange",
    "Dr. House"
  ];

  // Variables (Observables)
  var selectedDoctor = Rxn<String>(); 
  var selectedDate = DateTime.now().obs;
  var selectedTime = Rxn<TimeOfDay>();
  
  // Controller untuk Text Input
  final TextEditingController complaintController = TextEditingController();

  // Fungsi Pilih Tanggal Lewat Bubble/List Horizontal
  void selectDate(DateTime date) {
    selectedDate.value = date;
  }

  // Fungsi Pilih Tanggal Lewat Dialog (Seperti Time Picker)
  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(), // Tidak boleh pilih tanggal lampau
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
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

  // --- FUNGSI SUBMIT (UPDATED) ---
  void submitBooking() {
    // 1. Validasi: Pastikan data sudah terisi
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

    // 2. KIRIM DATA (Passing Arguments)
    // Ini adalah simulasi pengiriman data tanpa database
    Get.toNamed(
      AppRoutes.antrian, 
      arguments: {
        'doctorName': selectedDoctor.value, // Mengirim nama dokter yang dipilih
        'poliName': 'Spesialis Telinga, Hidung, Tenggorokan', // Static atau bisa dibuat dinamis
        'date': selectedDate.value, // Mengirim tanggal yang dipilih
        'time': selectedTime.value, // Mengirim jam yang dipilih
      }
    );
  }
  
  @override
  void onClose() {
    complaintController.dispose();
    super.onClose();
  }
}

// --- 2. VIEW (UI Screen) ---
class QueueBookingScreen extends StatelessWidget {
  final String poliName;
  final String poliDescription;

  const QueueBookingScreen({
    super.key,
    this.poliName = '',
    this.poliDescription = '',
  });

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
            // --- DROPDOWN DOKTER ---
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFE0E3F3), 
                borderRadius: BorderRadius.circular(16),
              ),
              child: Obx(() => DropdownButtonHideUnderline(
                child: DropdownButton<String>(
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
                  value: controller.selectedDoctor.value,
                  items: controller.doctors.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundImage: const NetworkImage("https://i.pravatar.cc/150?img=11"), 
                            backgroundColor: Colors.grey[300],
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                              const Text("Spesialis THT", style: TextStyle(fontSize: 10, color: Colors.grey)),
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
              )),
            ),
            
            const SizedBox(height: 24),

            // --- CUSTOM CALENDAR WIDGET ---
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFEBC115), // Warna Kuning sesuai gambar
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  // 1. Header Kalender (INTERAKTIF: Klik untuk buka DatePicker)
                  InkWell(
                    onTap: () => controller.pickDate(context), // Memanggil Dialog Kalender
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD6D7F6), // Ungu pudar
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

                  // 2. Bulan (Dinamis sesuai selectedDate)
                  // Kita menampilkan daftar bulan statis, tapi menyorot bulan yang dipilih
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
                      ].map((month) {
                        return Obx(() {
                          // Cek apakah bulan ini sama dengan bulan di selectedDate
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
                  // List ini akan menampilkan tanggal mulai dari 'selectedDate' ke depan
                  SizedBox(
                    height: 80,
                    child: Obx(() {
                      // Base date untuk list view adalah tanggal yang dipilih user
                      DateTime baseDate = controller.selectedDate.value;
                      
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 14, // Menampilkan 2 minggu ke depan dari tanggal terpilih
                        separatorBuilder: (ctx, i) => const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          // Logic: List dimulai dari tanggal terpilih (index 0)
                          final date = baseDate.add(Duration(days: index));
                          
                          // Cek apakah tanggal ini adalah tanggal yang dipilih (Pasti index 0 true, tapi ini untuk visual saat digeser logic lain)
                          final isSelected = index == 0; 
                          
                          return InkWell(
                            onTap: () {
                              // Saat diklik, update tanggal terpilih di controller
                              // Ini akan membuat list me-render ulang dimulai dari tanggal yang baru diklik
                              controller.selectDate(date);
                            },
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
                                    DateFormat('E').format(date), // Nama Hari (Tue, Wed)
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : Colors.black,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    DateFormat('d').format(date), // Tanggal (12, 13)
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