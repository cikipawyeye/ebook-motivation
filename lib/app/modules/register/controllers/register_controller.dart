import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class RegisterController extends GetxController {
  // TextEditingControllers untuk form
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController domisiliController = TextEditingController();

  // Variabel reaktif
  RxString selectedDomisili = ''.obs;
  RxList<Map<String, dynamic>> domisiliList = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs; // Menandakan status loading
  RxInt selectedJobType = 0.obs;

  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    domisiliController.addListener(_onDomisiliTextChanged);
  }

  @override
  void onClose() {
    _debounce?.cancel();
    domisiliController.removeListener(_onDomisiliTextChanged);
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    jobController.dispose();
    dobController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    domisiliController.dispose();
    super.onClose();
  }

  void _onDomisiliTextChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (domisiliController.text.isNotEmpty) {
        fetchCities(domisiliController.text);
      } else {
        domisiliList.clear();
      }
    });
  }

  Future<void> fetchCities(String searchQuery) async {
    if (searchQuery.isEmpty) {
      domisiliList.clear();
      return;
    }

    isLoading.value = true;
    var url = Uri.parse(
        'https://ebook.dev.whatthefun.id/api/v1/register/cities?search=$searchQuery');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> cities = jsonDecode(response.body)['data'] ?? [];
        domisiliList.value = cities.map((city) {
          return {
            'id': city['id']?.toString() ?? '',
            'name': city['name']?.toString() ?? 'Unknown',
          };
        }).toList();
      } else {
        Get.snackbar('Error', 'Gagal memuat daftar kota');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan saat mengambil data kota');
    } finally {
      isLoading.value = false;
    }
  }

  bool validateForm1() {
    // Memastikan bahwa semua field sudah diisi dan valid
    if (nameController.text.isEmpty) {
      Get.snackbar('Error', 'Nama tidak boleh kosong');
      return false;
    }

    if (emailController.text.isEmpty ||
        !GetUtils.isEmail(emailController.text)) {
      Get.snackbar('Error', 'Email tidak valid');
      return false;
    }

    if (phoneController.text.isEmpty || phoneController.text.length < 10) {
      Get.snackbar('Error', 'Nomor telepon tidak valid');
      return false;
    }

    if (dobController.text.isEmpty) {
      Get.snackbar('Error', 'Tanggal lahir tidak boleh kosong');
      return false;
    }

    // Debugging untuk melihat status Domisili
    debugPrint('Domisili Controller Text: ${domisiliController.text}');
    debugPrint('Selected Domisili: ${selectedDomisili.value}');

    // Cek apakah domisiliController atau selectedDomisili tidak kosong
    if (domisiliController.text.isEmpty || selectedDomisili.value.isEmpty) {
      Get.snackbar('Error', 'Domisili tidak boleh kosong');
      print(
          'Domisili: ${domisiliController.text}, Selected Domisili: ${selectedDomisili.value}');
      return false;
    }

    if (selectedJobType.value == 0) {
      Get.snackbar('Error', 'Pilih jenis pekerjaan');
      return false;
    }

    return true; // Semua field valid
  }

  bool validateForm2() {
    return passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        passwordController.text == confirmPasswordController.text;
  }

  Future<void> register() async {
    if (isLoading.value) return; // Menghindari submit ganda
    isLoading.value = true; // Menandakan proses registrasi sedang berlangsung

    if (!validateForm1() || !validateForm2()) {
      isLoading.value = false; // Reset status loading jika validasi gagal
      return;
    }

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    var url = Uri.parse('https://ebook.dev.whatthefun.id/api/v1/register');

    String jobTypeName = _getJobTypeName(selectedJobType.value);

    var body = {
      'name': nameController.text,
      'email': emailController.text,
      'phone_number': phoneController.text,
      'job': jobTypeName,
      'birth_date': dobController.text,
      'gender': 'M',
      'city_code': selectedDomisili.value,
      'password': passwordController.text,
      'password_confirmation': confirmPasswordController.text,
    };

    try {
      http.Response response = await http.post(
        url,
        body: jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        await saveUserData(jsonResponse);
        Get.snackbar('Success', 'Registrasi berhasil!');
        Get.offAllNamed('/home');
      } else {
        final jsonResponse = jsonDecode(response.body);
        String errorMessage =
            jsonResponse['message'] ?? 'Gagal melakukan registrasi';
        Get.snackbar('Error', errorMessage);
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan. Silakan coba lagi.');
    } finally {
      isLoading.value = false; // Selalu reset status loading setelah request
    }
  }

  Future<void> saveUserData(Map<String, dynamic> jsonResponse) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = jsonResponse['data']?['token']?.toString() ?? '';
    await prefs.setString('token', token);
  }

  String _getJobTypeName(int jobType) {
    switch (jobType) {
      case 1:
        return 'Pelajar';
      case 2:
        return 'Mahasiswa';
      case 3:
        return 'Pegawai Negeri';
      case 4:
        return 'Pegawai Swasta';
      case 5:
        return 'Profesional';
      case 6:
        return 'Ibu Rumah Tangga';
      case 7:
        return 'Pengusaha';
      case 8:
        return 'Tidak Bekerja';
      default:
        return 'Lainnya';
    }
  }

  // Fungsi untuk memilih kota dari daftar
  void onCitySelected(Map<String, dynamic> selectedCity) {
    selectedDomisili.value = selectedCity['id']; // Update ID kota
    domisiliController.text = selectedCity['name']; // Update nama kota ke input
    print('Selected Domisili ID: ${selectedDomisili.value}');
  }
}
