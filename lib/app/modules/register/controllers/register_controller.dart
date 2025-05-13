import 'dart:async';

import 'package:ebookapp/app/modules/register/models/register_response.dart';
import 'package:ebookapp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '/../../../core/constants/constant.dart';

class RegisterController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController cityCodeController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController domisiliController = TextEditingController();
  final TextEditingController customJobController = TextEditingController();

  final List<String> genderOptions = ['Laki-laki', 'Perempuan'];
  final selectedGender = ''.obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final cities = <Map<String, dynamic>>[].obs;
  final domisiliList = <Map<String, dynamic>>[].obs;
  final selectedJobType = 8.obs;
  final isAgreed = false.obs;
  final isNameError = false.obs;
  final emailError = RxnString();
  final isPasswordError = false.obs;
  final isConfirmPasswordError = false.obs;
  final isDobError = false.obs;
  final isCityCodeError = false.obs;
  final isPhoneError = false.obs;
  final isGenderError = false.obs;
  final isDomisiliError = false.obs;
  final isJobError = false.obs;
  final isCustomJobError = false.obs;
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  var firstName = ''.obs;

  final canPop = true.obs;

  @override
  void onInit() {
    super.onInit();
    customJobController.addListener(_validateCustomJob);
    SystemChannels.platform.setMethodCallHandler((call) async {
      if (call.method == 'SystemNavigator.pop') {
        handleBackButton();
        return true;
      }
      return null;
    });

    fetchCities();
  }

  Future<bool> handleBackButton() async {
    if (canPop.value) {
      Get.back();
      return false;
    }
    return true;
  }

  void _validateCustomJob() {
    if (selectedJobType.value == 0) {
      final customJob = customJobController.text.trim();
      isCustomJobError.value = customJob.isEmpty;
    }
  }

  bool validateName() {
    final name = nameController.text.trim();
    final isAlphabetic = RegExp(r'^[a-zA-Z ]+$').hasMatch(name);
    final isValid = isAlphabetic && name.length >= 2;
    List<String> existingNames = ['Alice', 'Bob', 'Charlie'];
    final isUnique = !existingNames.contains(name);
    isNameError.value = !isValid || !isUnique;
    return isValid && isUnique;
  }

  Timer? _emailInputDebounce;
  final isValidatingEmail = RxBool(false);

  Future<bool> validateEmail() async {
    final email = emailController.text.trim();
    final emailRegex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
        caseSensitive: false);
    final isValid =
        email.isNotEmpty && emailRegex.hasMatch(email) && email.length <= 254;
    emailError.value = isValid ? null : 'Email tidak valid';

    if (!isValid) {
      return false;
    }

    if (_emailInputDebounce?.isActive ?? false) {
      _emailInputDebounce?.cancel();
    }

    final completer = Completer<bool>();

    _emailInputDebounce = Timer(const Duration(milliseconds: 250), () async {
      isLoading.value = true;

      try {
        final response = await http.post(
          Uri.parse('$baseUrl/api/v1/register/check-email'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          body: jsonEncode({"email": emailController.text.trim()}),
        );

        debugPrint('Request Body: ${jsonEncode({
              "email": emailController.text.trim()
            })}');
        debugPrint('Response Body: ${response.body}');

        final jsonResponse = json.decode(response.body);

        if (response.statusCode == 200) {
          final isEmailTaken = jsonResponse['data']['exists'];
          if (isEmailTaken) {
            emailError.value = 'Email sudah terdaftar';
          } else {
            emailError.value = null;
          }
        } else {
          emailError.value = jsonResponse['message'] ?? 'Gagal memeriksa email';
        }

        completer.complete(emailError.value == null);
      } catch (e) {
        emailError.value = 'Terjadi kesalahan';
        completer.complete(false);
      } finally {
        isLoading.value = false;
      }
    });

    // Tunggu sampai Timer selesai dan completer dipanggil
    return completer.future;
  }

  bool validatePassword(String value) {
    final hasMinLength = value.length >= 8;
    final hasUppercase = value.contains(RegExp(r'[A-Z]'));
    final hasNumber = value.contains(RegExp(r'[0-9]'));
    final isValid = hasMinLength && hasUppercase && hasNumber;
    isPasswordError.value = !isValid;
    return isValid;
  }

  bool validateConfirmPassword(String value) {
    final isValid = value == passwordController.text;
    isConfirmPasswordError.value = !isValid;
    return isValid;
  }

  bool validatePhoneNumber() {
    final phone = phoneNumberController.text.trim();
    final isValid =
        phone.startsWith('08') && phone.length >= 10 && phone.length <= 13;
    isPhoneError.value = !isValid;
    return isValid;
  }

  bool validateDob() {
    final isValid = dobController.text.isNotEmpty;
    isDobError.value = !isValid;
    return isValid;
  }

  bool validateGender() {
    final isValid = selectedGender.value.isNotEmpty;
    isGenderError.value = !isValid;
    return isValid;
  }

  bool validateDomisili() {
    final isValid = domisiliController.text.isNotEmpty &&
        cityCodeController.text.isNotEmpty;
    isDomisiliError.value = !isValid;
    return isValid;
  }

  bool validateJob() {
    if (selectedJobType.value == 0) {
      final isValid = customJobController.text.trim().isNotEmpty;
      isCustomJobError.value = !isValid;
      isJobError.value = !isValid;
      return isValid;
    } else {
      final isValid = selectedJobType.value != 0;
      isJobError.value = !isValid;
      return isValid;
    }
  }

  Future<bool> isEmailValid() async {
    return await validateEmail();
  }

  bool isPhoneNumberValid() {
    return validatePhoneNumber();
  }

  bool isDobValid() {
    return validateDob();
  }

  bool isPasswordValid() {
    return validatePassword(passwordController.text);
  }

  void setGender(String gender) {
    selectedGender.value = gender;
    isGenderError.value = false;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  bool canProceedToNextPage(String currentPage) {
    switch (currentPage) {
      case 'personal_info':
        return validateName() &&
            validatePassword(passwordController.text) &&
            validateConfirmPassword(confirmPasswordController.text);
      case 'contact_info':
        return validatePhoneNumber() &&
            validateDob() &&
            validateGender() &&
            validateDomisili();
      case 'job_info':
        return validateJob();
      case 'agreement':
        return isAgreed.value;
      default:
        return false;
    }
  }

  void showValidationErrors(String currentPage) {
    switch (currentPage) {
      case 'personal_info':
        validateName();
        validateEmail();
        validatePassword(passwordController.text);
        validateConfirmPassword(confirmPasswordController.text);
        break;
      case 'contact_info':
        validatePhoneNumber();
        validateDob();
        validateGender();
        validateDomisili();
        break;
      case 'job_info':
        validateJob();
        break;
      case 'agreement':
        if (!isAgreed.value) {
          Get.snackbar(
            'Persetujuan Diperlukan',
            'Anda harus menyetujui syarat dan ketentuan untuk melanjutkan',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
        break;
    }
  }

  void navigateToNextPage(String currentPage, String nextRoute) {
    if (canProceedToNextPage(currentPage)) {
      Get.toNamed(nextRoute);
    } else {
      showValidationErrors(currentPage);
    }
  }

  bool validateAllFields() {
    return validateName() &&
        validatePassword(passwordController.text) &&
        validateConfirmPassword(confirmPasswordController.text) &&
        validatePhoneNumber() &&
        validateDob() &&
        validateJob() &&
        validateGender() &&
        validateDomisili() &&
        isAgreed.value;
  }

  Future<void> register() async {
    if (!validateAllFields()) {
      Get.snackbar(
        'Validasi Gagal',
        'Pastikan semua data yang dimasukkan sudah benar',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;

    final requestBody = {
      "name": nameController.text.trim(),
      "email": emailController.text.trim().toLowerCase(),
      "password": passwordController.text,
      "password_confirmation": confirmPasswordController.text,
      "birth_date": dobController.text,
      "city_code": cityCodeController.text,
      "job_type": selectedJobType.value,
      "job": _getJobDescription(),
      "phone_number": _formatPhoneNumber(),
      "gender": selectedGender.value,
    };

    try {
      final response = await _performRegistration(requestBody);

      if (response.statusCode == 200) {
        await _handleSuccessfulRegistration(response);
      } else {
        _handleRegistrationError(response);
      }
    } catch (e) {
      debugPrint('Kesalahan: $e');
      _handleUnexpectedError(e);
    } finally {
      isLoading.value = false;
    }
  }

  String _getJobDescription() {
    const jobDescriptions = {
      0: "Lainnya",
      1: "Pelajar",
      2: "Mahasiswa",
      3: "Pegawai Negeri",
      4: "Pegawai Swasta",
      5: "Profesional",
      6: "Ibu Rumah Tangga",
      7: "Pengusaha",
      8: "Tidak Bekerja",
    };

    return selectedJobType.value == 0
        ? customJobController.text.trim()
        : jobDescriptions[selectedJobType.value] ?? "Lainnya";
  }

  String _formatPhoneNumber() {
    String phone = phoneNumberController.text.trim();
    return phone.startsWith('08') ? phone.replaceFirst('08', '+62') : phone;
  }

  Future<http.Response> _performRegistration(
      Map<String, dynamic> requestBody) async {
    debugPrint('Melakukan Pendaftaran: $requestBody');
    final response = await http.post(
      Uri.parse('$baseUrl/api/v1/register'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    debugPrint('Status Code: ${response.statusCode}');
    debugPrint('Response Body: ${response.body}');

    return response;
  }

  Future<void> _handleSuccessfulRegistration(http.Response response) async {
    try {
      debugPrint('Response Status Code: ${response.statusCode}');

      final responseBody = jsonDecode(response.body);
      final registerResponse = RegisterResponse.fromJson(responseBody);

      if (registerResponse.data.token.isNotEmpty) {
        await _saveUserToken(registerResponse.data.token);
        resetForm();
        Get.offAllNamed(Routes.successRegis);
      } else {
        errorMessage.value = 'Gagal mendapatkan token autentikasi';
        _handleRegistrationError(response);
      }

      debugPrint('Job: ${registerResponse.data.user.job}');
      debugPrint('Job Type: ${registerResponse.data.user.jobType}');
    } catch (e) {
      errorMessage.value = 'Kesalahan dalam memproses respon pendaftaran';
      _handleUnexpectedError(e);
    }
  }

  Future<void> _saveUserToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasAccount', true);
    // Must login again
    // await prefs.setString('user_token', token);
    // debugPrint('Token pengguna disimpan: $token');
  }

  void _handleRegistrationError(http.Response response) {
    try {
      final errorResponse = jsonDecode(response.body);
      errorMessage.value = errorResponse['message'] ?? 'Registrasi gagal';
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan tidak terduga';
    }

    Get.snackbar(
      'Registrasi Gagal',
      errorMessage.value,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  void _handleUnexpectedError(dynamic error) {
    errorMessage.value = 'Terjadi kesalahan: $error';
    Get.snackbar(
      'Kesalahan',
      errorMessage.value,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }

  Future<void> fetchCities() async {
    try {
      debugPrint('Getting cities...');
      final response = await http.get(
        Uri.parse('$baseUrl/api/v1/register/cities'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        cities.value = List<Map<String, dynamic>>.from(
          jsonResponse['data'].map((city) => {
                'name': city['name'],
                'code': city['code'],
              }),
        );
      } else {
        Get.snackbar('Kesalahan', 'Gagal mendapatkan data kota');
      }
    } catch (e) {
      Get.snackbar('Kesalahan', 'Terjadi kesalahan saat mendapatkan data kota');
      debugPrint('Kesalahan saat mendapatkan data kota: $e');
    }
  }

  Timer? _debounce;
  final isSearching = RxBool(false);

  Future<void> searchCities(String query) async {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isEmpty) {
        domisiliList.clear();
        return;
      }

      isSearching.value = true;

      domisiliList.value = cities.where((city) {
        return city['name']!.toLowerCase().contains(query.toLowerCase());
      }).toList();

      isSearching.value = false;
    });
  }

  void onCitySelected(Map<String, dynamic> city) {
    cityCodeController.text = city['code'];
    domisiliController.text = city['name'];
    domisiliList.clear();
    isDomisiliError.value = false;
  }

  void resetForm() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    dobController.clear();
    cityCodeController.clear();
    phoneNumberController.clear();
    domisiliController.clear();
    customJobController.clear();

    domisiliList.clear();
    selectedJobType.value = 8;
    selectedGender.value = '';
    isAgreed.value = false;

    isNameError.value = false;
    emailError.value = null;
    isPasswordError.value = false;
    isConfirmPasswordError.value = false;
    isDobError.value = false;
    isCityCodeError.value = false;
    isPhoneError.value = false;
    isGenderError.value = false;
    isDomisiliError.value = false;
    isJobError.value = false;
    isCustomJobError.value = false;
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    dobController.dispose();
    cityCodeController.dispose();
    phoneNumberController.dispose();
    domisiliController.dispose();
    customJobController.dispose();
    customJobController.removeListener(_validateCustomJob);

    super.onClose();
  }
}

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
