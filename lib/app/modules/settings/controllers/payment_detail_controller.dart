import 'dart:async';
import 'dart:convert';
import 'package:ebookapp/app/modules/settings/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ebookapp/app/data/models/payment_mode.dart';
import '/../../../core/constants/constant.dart';

class PaymentController extends GetxController {
  final selectedPaymentType = Rxn<String>();
  final selectedChannelCode = Rxn<String>();

  final isExpanded = false.obs;
  // State variables
  var isLoading = false.obs;
  var virtualAccountNumber = Rxn<String>();
  var expiresAt = Rxn<String>();
  var channelCode = Rxn<String>();
  var paymentStatus = Rxn<String>();
  var paymentId = Rxn<int>();
  final userId = Rxn<int>();
  var customerName = Rxn<String>();

  Timer? _statusCheckTimer;

  final UserController userController = Get.put(UserController());

  // Getter untuk isPremium
  bool get isPremium => userController.isPremium.value;

  @override
  void onInit() {
    super.onInit();
    loadSavedData(); // Muat data saat controller diinisialisasi
    startStatusCheckTimer(); // Mulai pengecekan status berkala
  }

  @override
  void onClose() {
    isLoading.value = false;
    virtualAccountNumber.value = null;
    expiresAt.value = null;
    channelCode.value = null;
    paymentStatus.value = null;
    paymentId.value = null;
    _statusCheckTimer?.cancel(); // Hentikan timer saat controller di-close
    super.onClose();
  }

  // Helper method to get token from SharedPreferences
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Helper method to save data to SharedPreferences
  Future<void> _saveToPrefs(String key, String? value) async {
    if (value != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, value);
      debugPrint('✅ Saved to SharedPreferences: $key = $value');
    } else {
      debugPrint('⚠️ Nilai null, tidak menyimpan ke SharedPreferences: $key');
    }
  }

  // Helper method to save userId to SharedPreferences
  Future<void> saveUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId);
    debugPrint('✅ Saved userId to SharedPreferences: $userId');
  }

  // Helper method to handle API errors
  void _handleApiError(String message, dynamic error) {
    Get.snackbar('Kesalahan', message); // Mengubah "Error" menjadi "Kesalahan"
    debugPrint("Kesalahan: $error"); // Mengubah "Error" menjadi "Kesalahan"
  }

  // Upgrade account
  Future<void> upgradeAccount({
    required String paymentType,
    required String channelCode,
    String? phoneNumber,
  }) async {
    debugPrint(
        '🔄 Meng-upgrade akun dengan tipe: $paymentType dan channel: $channelCode');

    if (isLoading.value) return;
    isLoading.value = true;

    try {
      // Cek apakah user sudah premium
      if (isPremium) {
        Get.snackbar('Info', 'Anda sudah premium, tidak perlu upgrade lagi.');
        return;
      }

      // Reset paymentStatus sebelum memulai proses pembayaran baru
      paymentStatus.value = null;

      final token = await _getToken();
      if (token == null) {
        _handleApiError('Pengguna tidak terautentikasi!', null);
        return;
      }

      debugPrint('🔄 Meng-upgrade akun');
      final response = await http.post(
        Uri.parse('${baseUrl}/api/v1/upgrade'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          'payment_type': paymentType,
          'channel_code': channelCode,
          'phone_number': phoneNumber,
        }),
      );

      if (response.statusCode != 200) {
        _handleApiError('Gagal untuk meng-upgrade akun', response.body);
        return;
      }

      final jsonResponse = json.decode(response.body);
      if (jsonResponse['data'] == null) {
        _handleApiError(
            'Gagal untuk meng-upgrade akun: ${jsonResponse['message']}', null);
        return;
      }

      paymentId.value = jsonResponse['data']['payment_id'];
      await fetchPaymentInfo(paymentId.value!);

      // Simpan userId yang sedang login
      await saveUserId(userController.userId.value!);

      Get.snackbar('Sukses', 'Akun berhasil di-upgrade');
      debugPrint('✅ Akun berhasil di-upgrade: ${jsonResponse['data']}');
    } catch (e) {
      _handleApiError('Terjadi kesalahan saat meng-upgrade akun.', e);
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch payment info
  Future<void> fetchPaymentInfo(int paymentId) async {
    if (isLoading.value) return;
    isLoading.value = true;

    try {
      final token = await _getToken();
      if (token == null) {
        _handleApiError('Pengguna tidak terautentikasi!', null);
        return;
      }

      debugPrint('🔄 Mengambil informasi pembayaran untuk ID: $paymentId');
      final response = await http.get(
        Uri.parse('${baseUrl}/api/v1/payments/$paymentId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        _handleApiError('Gagal mengambil informasi pembayaran', response.body);
        return;
      }

      final jsonResponse = json.decode(response.body);
      debugPrint('Respon API: $jsonResponse');

      // Parse respons API menggunakan model PaymentResponse
      final paymentResponse = PaymentResponse.fromJson(jsonResponse);

      // Ambil data virtual account dan expires at
      final virtualAccount = paymentResponse.data.paymentMethod.virtualAccount;
      if (virtualAccount != null) {
        virtualAccountNumber.value =
            virtualAccount.channelProperties.virtualAccountNumber;
        expiresAt.value = virtualAccount.channelProperties.expiresAt;
        channelCode.value = virtualAccount.channelCode;
        paymentStatus.value = paymentResponse.data.status;
        customerName.value = virtualAccount.channelProperties.customerName;

        // Simpan data ke SharedPreferences
        await _saveToPrefs('virtualAccountNumber', virtualAccountNumber.value);
        await _saveToPrefs('expiresAt', expiresAt.value);
        await _saveToPrefs('channelCode', channelCode.value);
        await _saveToPrefs('paymentStatus', paymentStatus.value);
        await _saveToPrefs('customerName', customerName.value);
      } else {
        debugPrint('⚠️ Data virtual account adalah null');
      }

      debugPrint('Payment ID: $paymentId');
      debugPrint('Nomor Virtual Account: ${virtualAccountNumber.value}');
      debugPrint('Tenggat Waktu: ${expiresAt.value}');
      debugPrint('Channel Code: ${channelCode.value}');
      debugPrint('Status: ${paymentStatus.value}');
      debugPrint('Nama Pelanggan: ${customerName.value}');
    } catch (e) {
      _handleApiError(
          'Terjadi kesalahan saat mengambil informasi pembayaran.', e);
    } finally {
      isLoading.value = false;
    }
  }

  // Load saved data from SharedPreferences
  Future<void> loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUserId = prefs.getInt('userId');

    // Jika userId sesuai, muat data
    if (savedUserId == userController.userId.value) {
      virtualAccountNumber.value = prefs.getString('virtualAccountNumber');
      expiresAt.value = prefs.getString('expiresAt');
      channelCode.value = prefs.getString('channelCode');
      paymentStatus.value = prefs.getString('paymentStatus');
      customerName.value = prefs.getString('customerName');
      paymentId.value = prefs.getInt('paymentId');

      debugPrint('✅ Memuat paymentStatus: ${paymentStatus.value}');
      debugPrint(
          'Memuat Nomor Virtual Account: $virtualAccountNumber'); // Diterjemahkan ke Bahasa Indonesia
      debugPrint('Memuat Tenggat Waktu: $expiresAt');
      debugPrint('Memuat Channel Code: $channelCode');
      debugPrint('Memuat Nama Pelanggan: $customerName');
    } else {
      debugPrint('⚠️ UserId tidak sesuai, data tidak dimuat.');
    }
  }

  // Start payment process
  Future<void> startPaymentProcess() async {
    await loadSavedData(); // Load data hanya saat diperlukan
    if (paymentStatus.value == 'PENDING') {
      await fetchPaymentInfo(paymentId.value!);
    }
  }

  // Method untuk memulai timer pengecekan status
  void startStatusCheckTimer() {
    _statusCheckTimer = Timer.periodic(Duration(minutes: 5), (timer) async {
      if (paymentStatus.value == 'PENDING') {
        // Lakukan pengecekan status pembayaran ke server
        final newStatus = await checkPaymentStatusFromServer();
        if (newStatus != 'PENDING') {
          await _saveToPrefs('paymentStatus', newStatus);
          paymentStatus.value = newStatus;
          timer.cancel(); // Hentikan timer jika status sudah tidak PENDING
        }
      } else {
        timer.cancel(); // Hentikan timer jika status bukan PENDING
      }
    });
  }

  // Method untuk mengecek status pembayaran dari server (contoh)
  Future<String> checkPaymentStatusFromServer() async {
    try {
      final token = await _getToken();
      if (token == null) {
        _handleApiError('Pengguna tidak terautentikasi!', null);
        return 'GAGAL';
      }

      final response = await http.get(
        Uri.parse('${baseUrl}/api/v1/payments/$paymentId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        _handleApiError('Gagal mengambil status pembayaran', response.body);
        return 'GAGAL';
      }

      final jsonResponse = json.decode(response.body);
      final paymentResponse = PaymentResponse.fromJson(jsonResponse);
      return paymentResponse.data.status;
    } catch (e) {
      _handleApiError('Terjadi kesalahan saat memeriksa status pembayaran.', e);
      return 'GAGAL';
    }
  }
}
