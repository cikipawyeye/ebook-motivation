// import 'package:ebookapp/app/modules/register/controllers/register_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter/services.dart';

// class RegisterPage extends StatelessWidget {
//   final RegisterController controller = Get.put(RegisterController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,  // Menyebabkan konten bergerak saat keyboard muncul
//       appBar: AppBar(
//         title: Text('Buat Akun'),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () => Get.back(),
//         ),
//       ),
//       body: SingleChildScrollView(
//         // Membuat form bisa di scroll
//         padding: EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Nama
//             TextField(
//               controller: controller.nameController,
//               decoration: InputDecoration(
//                 labelText: 'Nama',
//                 labelStyle: TextStyle(color: Colors.black54),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.blueAccent),
//                 ),
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 16),
//             // Email
//             TextField(
//               controller: controller.emailController,
//               decoration: InputDecoration(
//                 labelText: 'Email',
//                 labelStyle: TextStyle(color: Colors.black54),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.blueAccent),
//                 ),
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 16),
//             // Nomor Telepon
//             TextField(
//               controller: controller.phoneController,
//               decoration: InputDecoration(
//                 labelText: 'Nomor Telepon',
//                 labelStyle: TextStyle(color: Colors.black54),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.blueAccent),
//                 ),
//                 border: OutlineInputBorder(),
//               ),
//               keyboardType: TextInputType.phone,
//             ),
//             SizedBox(height: 16),
//             // Tanggal Lahir
//             TextField(
//               controller: controller.dobController,
//               decoration: InputDecoration(
//                 labelText: 'Kapan ulang tahun mu?',
//                 labelStyle: TextStyle(color: Colors.black54),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.blueAccent),
//                 ),
//                 border: OutlineInputBorder(),
//               ),
//               keyboardType: TextInputType.datetime,
//             ),
//             SizedBox(height: 16),
//             // Dropdown untuk memilih Domisili
//             Obx(() => DropdownButtonFormField<String>(
//                   decoration: InputDecoration(
//                     labelText: 'Domisili (Kota/Kabupaten)',
//                     labelStyle: TextStyle(color: Colors.black54),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.blueAccent),
//                     ),
//                     border: OutlineInputBorder(),
//                   ),
//                   value: controller.selectedDomisili.value.isEmpty
//                       ? null
//                       : controller.selectedDomisili.value,
//                   onChanged: (value) {
//                     controller.selectedDomisili.value = value!;
//                   },
//                   items: controller.domisiliList.map((city) {
//                     return DropdownMenuItem<String>(
//                       value: city['id'],
//                       child: Text(city['name']),
//                     );
//                   }).toList(),
//                   onTap: () {
//                     controller.fetchCities('');
//                   },
//                 )),
//             SizedBox(height: 16),
//             // Dropdown untuk memilih Pekerjaan
//             Obx(() => DropdownButtonFormField<int>(
//                   decoration: InputDecoration(
//                     labelText: 'Pekerjaan',
//                     labelStyle: TextStyle(color: Colors.black54),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.blueAccent),
//                     ),
//                     border: OutlineInputBorder(),
//                   ),
//                   value: controller.selectedJobType.value == 0
//                       ? null
//                       : controller.selectedJobType.value,
//                   onChanged: (newValue) {
//                     controller.selectedJobType.value = newValue!;
//                   },
//                   items: [
//                     DropdownMenuItem(value: 1, child: Text('Pelajar')),
//                     DropdownMenuItem(value: 2, child: Text('Mahasiswa')),
//                     DropdownMenuItem(value: 3, child: Text('Pegawai Negeri')),
//                     DropdownMenuItem(value: 4, child: Text('Pegawai Swasta')),
//                     DropdownMenuItem(value: 5, child: Text('Profesional')),
//                     DropdownMenuItem(value: 6, child: Text('Ibu Rumah Tangga')),
//                     DropdownMenuItem(value: 7, child: Text('Pengusaha')),
//                     DropdownMenuItem(value: 8, child: Text('Tidak Bekerja')),
//                   ],
//                 )),
//             SizedBox(height: 20),
//             // Tombol untuk melanjutkan ke form berikutnya
//             ElevatedButton(
//               onPressed: () {
//                 if (controller.validateForm1()) {
//                   controller.register();
//                 } else {
//                   Get.snackbar('Error', 'Harap lengkapi semua field');
//                 }
//               },
//               child: Text('Selanjutnya'),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.blueAccent,
//                 padding: EdgeInsets.symmetric(vertical: 15),
//                 textStyle: TextStyle(fontSize: 16),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
