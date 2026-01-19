import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StatusAntrianController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;
  
  var activeQueue = <Map<String, dynamic>>[].obs;
  var historyQueue = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAntrian();
  }

  Future<void> fetchAntrian() async {
    try {
      isLoading.value = true;
      final user = supabase.auth.currentUser;

      // 1. Ambil data dari tabel 'queues'
      // Kita select semua (*) dan join ke doctors
      final response = await supabase
          .from('queues') 
          .select('*, doctors(*)') 
          .eq('user_id', user!.id) // Filter punya user sendiri
          .order('created_at', ascending: false);

      final List<dynamic> data = response as List<dynamic>;
      
      // DEBUG: Cek di Terminal/Debug Console
      print("TOTAL DATA ANTRIAN DITEMUKAN: ${data.length}");
      if(data.isNotEmpty) print("CONTOH DATA: ${data[0]}");

      activeQueue.clear();
      historyQueue.clear();

      for (var item in data) {
        // Normalisasi status biar tidak bingung huruf besar/kecil
        String status = (item['status'] ?? 'Menunggu').toString().toLowerCase();
        
        // Logika pisah Aktif vs Riwayat
        if (status == 'menunggu' || status == 'diproses' || status == 'confirmed') {
          activeQueue.add(item);
        } else {
          historyQueue.add(item);
        }
      }
    } catch (e) {
      print("ERROR FETCH ANTRIAN: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshData() async {
    await fetchAntrian();
  }
}