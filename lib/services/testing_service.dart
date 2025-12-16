import 'package:supabase_flutter/supabase_flutter.dart';

class TestingService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Get semua data dari tabel testing
  Future<List<Map<String, dynamic>>> getAllTesting() async {
    try {
      final response = await _supabase.from('testing').select();

      print('✅ Data testing berhasil diambil');
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('❌ Gagal mengambil data testing');
      print('Error: $e');
      rethrow;
    }
  }
}