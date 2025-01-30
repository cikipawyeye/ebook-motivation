import 'package:ebookapp/app/modules/register/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SetPasswordView extends GetView<RegisterController> {
  const SetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atur Kata Sandi'),
        backgroundColor: const Color(0xFF32497B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Atur kata sandi',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // Kata Sandi
              TextFormField(
                controller: controller
                    .passwordController, // Menggunakan controller dari RegisterController
                decoration: const InputDecoration(
                  labelText: 'Kata Sandi',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),

              // Konfirmasi Kata Sandi
              TextFormField(
                controller: controller
                    .confirmPasswordController, // Menggunakan controller dari RegisterController
                decoration: const InputDecoration(
                  labelText: 'Konfirmasi Kata Sandi',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),

              // Checkbox untuk setuju dengan kebijakan
              Row(
                children: [
                  Checkbox(
                    value:
                        true, // Ini statis, bisa dikontrol lebih lanjut jika diperlukan
                    onChanged: (value) {},
                  ),
                  const Text('Menerima ketentuan dan kebijakan privasi'),
                ],
              ),
              const SizedBox(height: 24),

              // Tombol Buat Akun
              ElevatedButton(
                onPressed: () {
                  if (controller.validateForm2()) {
                    // Aksi setelah validasi berhasil
                    controller.register(); // Melakukan registrasi

                    // Tampilkan pesan sukses
                    Get.snackbar('Berhasil', 'Akun berhasil dibuat!');

                    // Navigasi ke halaman utama (misalnya HomePage)
                    Get.offAllNamed(
                        '/home'); // Ganti dengan nama route yang sesuai
                  } else {
                    // Jika kata sandi tidak cocok
                    Get.snackbar('Error', 'Kata sandi tidak cocok');
                  }
                },
                child: const Text('Buat akun'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
