// import 'package:get/get.dart';

// import '../models/motivasi_model.dart';

// class MotivasiProvider extends GetConnect {
//   @override
//   void onInit() {
//     httpClient.defaultDecoder = (map) {
//       if (map is Map<String, dynamic>) return Motivasi.fromJson(map);
//       if (map is List)
//         return map.map((item) => Motivasi.fromJson(item)).toList();
//     };
//     httpClient.baseUrl = 'YOUR-API-URL';
//   }

//   Future<Motivasi?> getMotivasi(int id) async {
//     final response = await get('motivasi/$id');
//     return response.body;
//   }

//   Future<Response<Motivasi>> postMotivasi(Motivasi motivasi) async =>
//       await post('motivasi', motivasi);
//   Future<Response> deleteMotivasi(int id) async => await delete('motivasi/$id');
// }
