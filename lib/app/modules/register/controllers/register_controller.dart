import 'package:ebookapp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ebookapp/app/data/models/user_model.dart';
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
  final domisiliList = <Map<String, dynamic>>[].obs;
  final selectedJobType = 8.obs;
  final isAgreed = false.obs;
  final isNameError = false.obs;
  final isEmailError = false.obs;
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

  bool validateName() {
    final name = nameController.text.trim();
    final isAlphabetic = RegExp(r'^[a-zA-Z ]+$').hasMatch(name);
    final isValid = isAlphabetic && name.length >= 2;
    List<String> existingNames = ['Alice', 'Bob', 'Charlie'];
    final isUnique = !existingNames.contains(name);
    isNameError.value = !isValid || !isUnique;
    return isValid && isUnique;
  }

  bool validateEmail() {
    final email = emailController.text.trim();
    final emailRegex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
        caseSensitive: false);
    final isValid =
        email.isNotEmpty && emailRegex.hasMatch(email) && email.length <= 254;
    isEmailError.value = !isValid;
    return isValid;
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

  bool validateJob() {
    final isValid = selectedJobType.value != 0 ||
        customJobController.text.trim().isNotEmpty;
    isJobError.value = !isValid;
    return isValid;
  }

  bool isEmailValid() {
    return validateEmail();
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

  bool validateAllFields() {
    return validateName() &&
        validateEmail() &&
        validatePassword(passwordController.text) &&
        validateConfirmPassword(confirmPasswordController.text) &&
        validatePhoneNumber() &&
        validateDob() &&
        validateJob() &&
        validateGender() &&
        isAgreed.value;
  }

  Future<void> register() async {
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
        Get.offAllNamed(Routes.successRegis);
      } else {
        Get.offAllNamed(Routes.successRegis);
      }
    } catch (e) {
      print('Kesalahan: $e');
      Get.offAllNamed(Routes.successRegis);
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
    print('Melakukan Pendaftaran: $requestBody');
    final response = await http.post(
      Uri.parse('${baseUrl}/api/v1/register'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    return response;
  }

  Future<void> _handleSuccessfulRegistration(http.Response response) async {
    try {
      print('Response Status Code: ${response.statusCode}');

      final responseBody = jsonDecode(response.body);
      final userResponse = UserResponse.fromJson(responseBody);

      if (userResponse.token != null) {
        await _saveUserData(userResponse);
        resetForm();
        Get.offAllNamed(Routes.successRegis);
      } else {
        errorMessage.value = 'Gagal mendapatkan token autentikasi';
        _handleRegistrationError(response);
      }

      print('Job: ${userResponse.user.job}');
      print('Job Type: ${userResponse.user.jobType}');
    } catch (e) {
      errorMessage.value = 'Kesalahan dalam memproses respon pendaftaran';
      _handleUnexpectedError(e);
    }
  }

  Future<void> _saveUserData(UserResponse userResponse) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_token', userResponse.token ?? '');
    print('Token pengguna disimpan: ${userResponse.token}');
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

  Future<void> fetchCities(String query) async {
    if (query.isEmpty) {
      domisiliList.clear();
      return;
    }

    try {
      print('Mencari kota untuk query: $query');
      final response = await http.get(
        Uri.parse(
            '${baseUrl}/api/v1/register/cities?search=$query'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        domisiliList.value = List<Map<String, dynamic>>.from(
          jsonResponse['data'].map((city) => {
                'name': city['name'],
                'code': city['code'],
              }),
        );
        print('Kota ditemukan: ${domisiliList.length}');
      } else {
        Get.snackbar('Kesalahan', 'Gagal mencari kota');
      }
    } catch (e) {
      Get.snackbar('Kesalahan', 'Terjadi kesalahan saat mencari kota');
      print('Kesalahan saat mencari kota: $e');
    }
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
    isEmailError.value = false;
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

    super.onClose();
  }
}

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
