import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ebookapp/app/modules/register/controllers/register_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Import library intl untuk format tanggal

class RegisterPage extends StatelessWidget {
  final RegisterController controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Buat Akun', style: GoogleFonts.leagueSpartan(fontSize: 32)),
            Text(
              'Data yang di isi hanya dapat dilihat oleh kamu\ndan tim support kami.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            SizedBox(height: 20),
            // Form Fields
            TextField(
              controller: controller.nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: controller.emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: controller.phoneController,
              decoration: InputDecoration(
                labelText: 'Nomor Telepon',
                labelStyle: TextStyle(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: controller.dobController,
              decoration: InputDecoration(
                labelText: 'Kapan ulang tahun mu?',
                labelStyle: TextStyle(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy/MM/dd').format(pickedDate);
                  controller.dobController.text = formattedDate;
                }
              },
            ),
            SizedBox(height: 16),
            Obx(() {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: controller.domisiliController,
                    onChanged: (value) {
                      controller.selectedDomisili(value);
                    },
                    decoration: InputDecoration(
                      labelText: 'Cari Domisili (Kota/Kabupaten)',
                      labelStyle: TextStyle(color: Colors.black54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  if (controller.domisiliList.isNotEmpty)
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.domisiliList.length,
                        itemBuilder: (context, index) {
                          final city = controller.domisiliList[index];
                          return ListTile(
                            title: Text(city['name']),
                            onTap: () {
                              // Update selectedDomisili dengan ID yang benar
                              controller.selectedDomisili.value = city['id'];
                              controller.domisiliController.text = city['name'];
                              controller.domisiliList.clear();
                              FocusScope.of(context).unfocus();
                            },
                          );
                        },
                      ),
                    ),
                ],
              );
            }),

            SizedBox(height: 16),
            Obx(() {
              return DropdownButtonFormField<int>(
                decoration: InputDecoration(
                  labelText: 'Pekerjaan',
                  labelStyle: TextStyle(color: Colors.black54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                value: controller.selectedJobType.value == 0
                    ? null
                    : controller.selectedJobType.value,
                onChanged: (newValue) {
                  controller.selectedJobType.value = newValue!;
                },
                items: [
                  DropdownMenuItem(value: 1, child: Text('Pelajar')),
                  DropdownMenuItem(value: 2, child: Text('Mahasiswa')),
                  DropdownMenuItem(value: 3, child: Text('Pegawai Negeri')),
                  DropdownMenuItem(value: 4, child: Text('Pegawai Swasta')),
                  DropdownMenuItem(value: 5, child: Text('Profesional')),
                  DropdownMenuItem(value: 6, child: Text('Ibu Rumah Tangga')),
                  DropdownMenuItem(value: 7, child: Text('Pengusaha')),
                  DropdownMenuItem(value: 8, child: Text('Tidak Bekerja')),
                ],
              );
            }),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.isLoading.value
                  ? null
                  : () {
                      // Validasi Domisili
                      if (controller.domisiliController.text.isEmpty ||
                          controller.selectedDomisili.value == 0) {
                        Get.snackbar('Error', 'Domisili tidak boleh kosong');
                      } else if (controller.validateForm1()) {
                        controller.register();
                      } else {
                        Get.snackbar('Error', 'Harap lengkapi semua field');
                      }
                    },
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: controller.isLoading.value
                    ? CircularProgressIndicator()
                    : Text('Selanjutnya'),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(vertical: 15),
                textStyle: TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
            )
          ],
        ),
      ),
    );
  }
}
