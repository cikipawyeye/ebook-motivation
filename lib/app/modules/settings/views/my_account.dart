import 'package:ebookapp/app/modules/settings/controllers/setting_theme_controller.dart';
import 'package:ebookapp/app/modules/settings/controllers/settings_controller.dart';
import 'package:ebookapp/app/modules/settings/controllers/user_controller.dart';
import 'package:ebookapp/app/modules/widgets/search_cities.dart';
import 'package:ebookapp/core/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Untuk memformat tanggal

// ignore: must_be_immutable
class AccountSettings extends GetView<SettingsController> {
  AccountSettings({super.key}) {
    userController.fetchUserProfile(); // Fetch data saat widget dibuat
  }

  final userController = Get.put(UserController());
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _cityController = TextEditingController();
  final _jobController = TextEditingController();
  var isEditing = false.obs;
  final _cityCode = ''.obs; // Untuk menyimpan city_code
  final _gender = ''.obs; // Untuk menyimpan gender
  final _job = ''.obs; // Untuk menyimpan pekerjaan

  // Daftar pilihan gender
  final Map<String, String> genderOptions = {
    'M': 'Pria',
    'F': 'Wanita',
  };

  // Fungsi untuk memilih tanggal lahir
  Future<void> _selectBirthDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly, // Tampilkan kalender
      initialDatePickerMode:
          DatePickerMode.year, // Mulai dengan pemilihan tahun
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF32497B), // Warna utama
              onPrimary: Colors.white, // Warna teks pada warna utama
              onSurface: Colors.black, // Warna teks pada kalender
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF32497B), // Warna teks tombol
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      _birthDateController.text = DateFormat('yyyy-MM-dd')
          .format(picked); // Format tanggal ke yyyy-MM-dd
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Akun Saya',
            style: GoogleFonts.leagueSpartan(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 25,
            ),
          ),
          centerTitle: true,
          backgroundColor: themeController.currentColor,
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          leading: IconButton(
            icon: Image.asset(
              'assets/icons/arrow_left.png',
              fit: BoxFit.contain,
              width: 24,
              height: 24,
            ),
            onPressed: () => Get.back(),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Template.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Obx(() {
            if (userController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            // Inisialisasi nilai controller jika belum diisi
            if (!isEditing.value) {
              _nameController.text =
                  userController.userResponse.value?.user.name ??
                      'Tidak tersedia';
              _emailController.text =
                  userController.userResponse.value?.user.email ??
                      'Tidak tersedia';
              _phoneController.text =
                  userController.userResponse.value?.user.phoneNumber ??
                      'Tidak tersedia';
              _birthDateController.text =
                  userController.userResponse.value?.user.birthDate ??
                      'Tidak tersedia';
              _cityController.text =
                  userController.userResponse.value?.user.city.name ??
                      'Tidak tersedia';
              _jobController.text =
                  userController.userResponse.value?.user.job ??
                      'Tidak tersedia';
              _cityCode.value =
                  userController.userResponse.value?.user.city.code ?? '';
              _gender.value =
                  userController.userResponse.value?.user.gender ?? '';
              _job.value =
                  userController.userResponse.value?.user.jobType.toString() ??
                      '';
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: SingleChildScrollView(
                        padding: EdgeInsets.all(12),
                        child: Form(
                            key: _formKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  _buildTextField(
                                    label: 'Nama',
                                    controller: _nameController,
                                    isEditing: isEditing.value,
                                  ),
                                  const SizedBox(height: 20),
                                  _buildTextField(
                                    label: 'Email',
                                    controller: _emailController,
                                    isEditing: isEditing.value,
                                  ),
                                  const SizedBox(height: 20),
                                  // Field Gender (Dropdown)
                                  DropdownButtonFormField<String>(
                                    value: _gender.value.isNotEmpty
                                        ? _gender.value
                                        : null,
                                    decoration: InputDecoration(
                                      labelText: 'Pilih Gender',
                                      labelStyle: TextStyle(
                                        color:
                                            Colors.white.withValues(alpha: 0.7),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    items: genderOptions.entries.map((entry) {
                                      return DropdownMenuItem(
                                        value: entry.key,
                                        child: Text(entry.value,
                                            style:
                                                TextStyle(color: Colors.white)),
                                      );
                                    }).toList(),
                                    onChanged: isEditing.value
                                        ? (value) {
                                            _gender.value = value!;
                                          }
                                        : null, // Nonaktifkan jika tidak dalam mode edit
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Gender wajib diisi.';
                                      }
                                      return null;
                                    },
                                    dropdownColor:
                                        Colors.black.withValues(alpha: 0.7),
                                  ),
                                  const SizedBox(height: 20),
                                  // Field Nomor Telepon
                                  _buildTextField(
                                    label: 'Nomor Telepon',
                                    controller: _phoneController,
                                    isEditing: isEditing.value,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Nomor Telepon wajib diisi.';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  // Field Tanggal Lahir
                                  GestureDetector(
                                    onTap: isEditing.value
                                        ? () => _selectBirthDate(
                                            context) // Pilih tanggal lahir
                                        : null, // Nonaktifkan jika tidak dalam mode edit
                                    child: AbsorbPointer(
                                      absorbing: !isEditing
                                          .value, // Nonaktifkan interaksi jika tidak dalam mode edit
                                      child: TextFormField(
                                        controller: _birthDateController,
                                        decoration: InputDecoration(
                                          labelText: 'Tanggal Lahir',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          labelStyle: TextStyle(
                                            color: Colors.white
                                                .withValues(alpha: 0.7),
                                          ),
                                        ),
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Tanggal Lahir wajib diisi.';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  // Widget Pencarian Kota
                                  CitySearchWidget(
                                    onCitySelected: (cityCode, cityName) {
                                      _cityCode.value =
                                          cityCode; // Simpan city_code
                                      _cityController.text =
                                          cityName; // Tampilkan nama kota
                                    },
                                    cityController: _cityController,
                                    isEditing: isEditing
                                        .value, // Kirim status isEditing ke widget
                                  ),
                                  const SizedBox(height: 20),
                                  // Dropdown Pekerjaan
                                  DropdownButtonFormField<String>(
                                    value: _job.value.isNotEmpty
                                        ? _job.value
                                        : null,
                                    decoration: InputDecoration(
                                      labelText: 'Pekerjaan',
                                      labelStyle: TextStyle(
                                        color:
                                            Colors.white.withValues(alpha: 0.7),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    items: userJob.entries.map((entry) {
                                      return DropdownMenuItem(
                                        value: entry.key,
                                        child: Text(entry.value,
                                            style:
                                                TextStyle(color: Colors.white)),
                                      );
                                    }).toList(),
                                    onChanged: isEditing.value
                                        ? (value) {
                                            _job.value = value!;
                                          }
                                        : null, // Nonaktifkan jika tidak dalam mode edit
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Tipe Pekerjaan wajib diisi.';
                                      }
                                      return null;
                                    },
                                    dropdownColor:
                                        Colors.black.withValues(alpha: 0.7),
                                  ),
                                ])))),
                SizedBox(height: 8),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (isEditing.value) {
                        // Jika sedang dalam mode edit, simpan data
                        if (_formKey.currentState!.validate()) {
                          // Kirim data ke server
                          userController.updateUserProfile({
                            'name': _nameController.text,
                            'email': _emailController.text,
                            'phone_number': _phoneController
                                .text, // Pastikan key-nya "phone_number"
                            'birth_date': _birthDateController
                                .text, // Pastikan key-nya "birth_date"
                            'city_code':
                                _cityCode.value, // Pastikan key-nya "city_code"
                            'job_type':
                                _job.value, // Pastikan key-nya "job_type"
                            'job':
                                _jobController.text, // Pastikan key-nya "job"
                            'gender':
                                _gender.value, // Pastikan key-nya "gender"
                          });
                          isEditing.value = false; // Keluar dari mode edit
                        }
                      } else {
                        // Jika tidak dalam mode edit, aktifkan mode edit
                        isEditing.value = true;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(180, 40),
                      backgroundColor: Colors.white.withValues(alpha: 0.3),
                    ),
                    child: Text(
                      isEditing.value ? 'Simpan' : 'Ubah Data',
                      style: GoogleFonts.leagueSpartan(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Jarak di bawah tombol
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required bool isEditing,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: !isEditing, // Hanya bisa diubah jika dalam mode edit
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.white.withValues(alpha: 0.7), // Warna label
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), // Border radius 20
        ), // Warna latar belakang dengan transparansi
      ),
      style: TextStyle(
        color: Colors.white, // Warna teks dengan transparansi
      ),
      validator: validator,
    );
  }
}
