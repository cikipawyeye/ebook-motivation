import 'package:ebookapp/app/data/models/motivasi_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/motivasi_controller.dart';

// class MotivasiView extends GetView<MotivasiController> {
//   const MotivasiView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(
//           'Motivasi',
//           style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: const Color(0xFF32497B),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//       ),
//       body: Column(
//         children: [
//           // Gambar di bagian atas (ini bisa diubah dinamis)
//           Container(
//             height: 200,
//             width: double.infinity,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage("assets/images/Motivasi1.png"),
//                 fit: BoxFit.cover,
//               ),
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(20),
//                 bottomRight: Radius.circular(20),
//               ),
//             ),
//           ),

//           Obx(() {
//             if (controller.isLoading.value) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (controller.motivasiDetail.value == null) {
//               return const Center(child: Text("No data available"));
//             } else {
//               final motivasi = controller.motivasiDetail.value!;
//               return Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Column(
//                   children: [
//                     Text(
//                       motivasi.title,
//                       style: const TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Obx(() {
//                       if (controller.imageBytesList.isEmpty) {
//                         return const CircularProgressIndicator();
//                       } else {
//                         return Image.memory(
//                           controller.imageBytesList.first.value!,
//                           fit: BoxFit.cover,
//                         );
//                       }
//                     }),
//                   ],
//                 ),
//               );
//             }
//           }),
//         ],
//       ),
//     );
//   }
// }

class MotivasiView extends GetView<MotivasiController> {
  const MotivasiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Motivasi',
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF32497B),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          // Gambar di bagian atas (ini bisa diubah dinamis)
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/Motivasi1.png"),
                fit: BoxFit.cover,
              ),
              // borderRadius: BorderRadius.only(
              //   bottomLeft: Radius.circular(0),
              //   bottomRight: Radius.circular(20),
              // ),
            ),
          ),

          Obx(() {
            if (controller.subcategories.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.subcategories.length,
                      itemBuilder: (context, index) {
                        final subcategory = controller.subcategories[index];

                        int contentCount = subcategory.contentsCount;

                        return GestureDetector(
                          onTap: () {
                            Get.toNamed('/motivation/contents',
                                arguments: subcategory);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            margin: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 3,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${index + 1}. ${subcategory.name}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.chevron_right,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    "Page: $contentCount",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Divider(
                                  color: Colors.black26,
                                  height: 1,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}
