import 'package:ebookapp/app/data/models/user_model.dart';
import 'package:ebookapp/app/modules/settings/controllers/setting_theme_controller.dart';
import 'package:ebookapp/app/modules/settings/controllers/settings_controller.dart';
import 'package:ebookapp/app/modules/settings/controllers/user_controller.dart';
import 'package:ebookapp/app/modules/widgets/search_cities.dart';
import 'package:ebookapp/core/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Untuk memformat tanggal

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
  var _cityCode = ''.obs; // Untuk menyimpan city_code
  var _gender = ''.obs; // Untuk menyimpan gender
  var _job = ''.obs; // Untuk menyimpan pekerjaan

  // Daftar pilihan pekerjaan
  final Map<String, String> JobType = {
    '0': 'Lainnya', // Lainnya
    '1': 'Pelajar', // Pelajar
    '2': 'Mahasiswa', // Mahasiswa
    '3': 'Pegawai Negeri (ASN)', // Pegawai Negeri (ASN)
    '4': 'Pegawai Swasta/Karyawan Swasta', // Pegawai Swasta/Karyawan Swasta
    '5': 'Profesional/Ahli', // Profesional/Ahli
    '6': 'Ibu Rumah Tangga', // Ibu Rumah Tangga
    '7': 'Wiraswasta/Pengusaha', // Wiraswasta/Pengusaha
    '8': 'Tidak Bekerja', // Tidak Bekerja
  };

  // Daftar pilihan gender
  final Map<String, String> GenderOptions = {
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
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/Watermark.png'),
              fit: BoxFit.cover, // Mengatur gambar agar menutupi seluruh area
            ),
          ),
          child: Obx(() {
            if (userController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            // Inisialisasi nilai controller jika belum diisi
            if (!isEditing.value) {
              _nameController.text =
                  userController.userResponse.value?.user?.name ??
                      'Tidak tersedia';
              _emailController.text =
                  userController.userResponse.value?.user?.email ??
                      'Tidak tersedia';
              _phoneController.text =
                  userController.userResponse.value?.user?.phoneNumber ??
                      'Tidak tersedia';
              _birthDateController.text =
                  userController.userResponse.value?.user?.birthDate ??
                      'Tidak tersedia';
              _cityController.text =
                  userController.userResponse.value?.user?.city?.name ??
                      'Tidak tersedia';
              _jobController.text =
                  userController.userResponse.value?.user?.job ??
                      'Tidak tersedia';
              _cityCode.value =
                  userController.userResponse.value?.user?.city?.code ?? '';
              _gender.value =
                  userController.userResponse.value?.user?.gender ?? '';
              _job.value = userController.userResponse.value?.user?.job ?? '';
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
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
                      value: _gender.value.isNotEmpty ? _gender.value : null,
                      decoration: InputDecoration(
                        labelText: 'Pilih Gender',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.7),
                      ),
                      items: GenderOptions.entries.map((entry) {
                        return DropdownMenuItem(
                          value: entry.key,
                          child: Text(entry.value),
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
                          ? () =>
                              _selectBirthDate(context) // Pilih tanggal lahir
                          : null, // Nonaktifkan jika tidak dalam mode edit
                      child: AbsorbPointer(
                        absorbing: !isEditing
                            .value, // Nonaktifkan interaksi jika tidak dalam mode edit
                        child: TextFormField(
                          controller: _birthDateController,
                          decoration: InputDecoration(
                            labelText: 'Tanggal Lahir',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.7),
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
                        _cityCode.value = cityCode; // Simpan city_code
                        _cityController.text = cityName; // Tampilkan nama kota
                      },
                      cityController: _cityController,
                      isEditing:
                          isEditing.value, // Kirim status isEditing ke widget
                    ),
                    const SizedBox(height: 20),
                    // Dropdown Pekerjaan
                    DropdownButtonFormField<String>(
                      value: _job.value.isNotEmpty ? _job.value : null,
                      decoration: InputDecoration(
                        labelText: 'Pekerjaan',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.7),
                      ),
                      items: JobType.entries.map((entry) {
                        return DropdownMenuItem(
                          value: entry.key,
                          child: Text(entry.value),
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
                    ),
                    const Spacer(), // Mengisi ruang kosong agar tombol berada di bawah
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
                                'city_code': _cityCode
                                    .value, // Pastikan key-nya "city_code"
                                'job_type':
                                    _job.value, // Pastikan key-nya "job_type"
                                'job': _jobController
                                    .text, // Pastikan key-nya "job"
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
                          minimumSize:
                              const Size(344, 50), // Lebar 344, tinggi 50
                          backgroundColor:
                              themeController.currentColor, // Warna tombol
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
                ),
              ),
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), // Border radius 20
        ),
        filled: true,
        fillColor: Colors.white
            .withOpacity(0.7), // Warna latar belakang dengan transparansi
      ),
      style: TextStyle(
        color: Colors.black.withOpacity(0.7), // Warna teks dengan transparansi
      ),
      validator: validator,
    );
  }
}
