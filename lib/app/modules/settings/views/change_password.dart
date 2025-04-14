import 'package:ebookapp/app/modules/settings/controllers/change_password_controller.dart';
import 'package:ebookapp/app/modules/settings/controllers/setting_theme_controller.dart';
import 'package:ebookapp/core/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({super.key}) {
    // Inisialisasi controller di dalam konstruktor
    Get.put(ChangePasswordController());
  }

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // Ambil data dari controller
      String currentPassword = _currentPasswordController.text;
      String newPassword = _newPasswordController.text;
      String confirmPassword = _confirmPasswordController.text;

      // Panggil fungsi untuk mengubah kata sandi
      Get.find<ChangePasswordController>().changePassword(
        currentPassword,
        newPassword,
        confirmPassword, // Kirim konfirmasi kata sandi baru
      );

      // Reset field setelah pengiriman
      _currentPasswordController.clear();
      _newPasswordController.clear();
      _confirmPasswordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Ganti Kata Sandi',
          style: GoogleFonts.leagueSpartan(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        backgroundColor: themeController.currentColor, // Warna biru gelap
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Watermark.png'),
            fit: BoxFit.cover, // Mengatur gambar agar menutupi seluruh area
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: 12),
                      Text(
                        'Atur ulang kata sandi',
                        style: GoogleFonts.leagueSpartan(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Anda hanya dapat mengubah kata sandi \nsebanyak 2 kali dalam 30 hari',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                _buildTextField(
                  label: 'Kata sandi saat ini',
                  controller: _currentPasswordController,
                  obscureText: _obscureCurrentPassword,
                  toggleObscureText: () {
                    setState(() {
                      _obscureCurrentPassword = !_obscureCurrentPassword;
                    });
                  },
                ),
                SizedBox(height: 20),
                _buildTextField(
                  label: 'Kata sandi baru',
                  controller: _newPasswordController,
                  obscureText: _obscureNewPassword,
                  toggleObscureText: () {
                    setState(() {
                      _obscureNewPassword = !_obscureNewPassword;
                    });
                  },
                ),
                SizedBox(height: 20),
                _buildTextField(
                  label: 'Masukkan kembali kata sandi baru',
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  toggleObscureText: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
                Spacer(), // Mengisi ruang kosong agar tombol berada di bawah
                Center(
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(344, 50),
                      backgroundColor: themeController.currentColor,
                    ),
                    child: Text(
                      'Simpan',
                      style: GoogleFonts.leagueSpartan(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback toggleObscureText,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.7),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: toggleObscureText,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Field ini wajib diisi.';
        }
        if (label == 'Masukkan kembali kata sandi baru' &&
            value != _newPasswordController.text) {
          return 'Kata sandi tidak cocok.';
        }
        return null;
      },
    );
  }
}
