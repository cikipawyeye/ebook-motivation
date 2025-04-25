import 'dart:convert';
import 'package:ebookapp/app/data/models/motivasi_model.dart';
import 'package:ebookapp/core/constants/constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MotivationDetailPageController extends GetxController {
  var motivasiList = <Motivasi>[].obs; // List untuk menyimpan data Motivasi
  var isLoading = true.obs;
  var errorMessage = ''.obs;
  var ids = <int>[].obs; // Menyimpan id yang diterima dari API
  var count = 0.obs; // Counter variable

  // Token yang akan digunakan dalam header
  var token = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadToken(); // Memuat token saat controller diinisialisasi
    fetchMotivasi(); // Mengambil data motivasi
  }

  // Fungsi untuk memuat token dari SharedPreferences
  _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    token.value = prefs.getString('token') ?? ''; // Mengambil token
  }

  // Fungsi untuk mengambil data motivasi
  void fetchMotivasi() async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token.value}'
    };

    try {
      isLoading.value = true;
      var url = Uri.parse('$baseUrl/api/v1/contents?subcategory_id=4');

      // Kirim request GET ke server dengan header dan token
      http.Response response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        // Parsing response menjadi model yang sesuai
        var motivasiResponse = MotivasiResponse.fromJson(json);
        motivasiList.value = motivasiResponse.data;

        // Ambil id yang ada dalam data motivasi dan masukkan ke dalam ids
        ids.value = List<int>.from(motivasiResponse.data.map((e) => e.id));

        // Menampilkan jumlah id
        print('Jumlah ID: ${ids.length}');
      } else {
        errorMessage.value = 'Failed to load data: ${response.statusCode}';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }
}

class MotivasiResponse {
  final List<Motivasi> data;

  MotivasiResponse({required this.data});

  factory MotivasiResponse.fromJson(Map<String, dynamic> json) {
    return MotivasiResponse(
      data: List<Motivasi>.from(json['data'].map((x) => Motivasi.fromJson(x))),
    );
  }
}
