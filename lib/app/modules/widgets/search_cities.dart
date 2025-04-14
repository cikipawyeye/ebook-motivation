import 'package:ebookapp/app/modules/settings/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async'; // Import untuk Timer

class CitySearchWidget extends StatefulWidget {
  final Function(String, String)
      onCitySelected; // Callback untuk menyimpan city_code dan nama kota
  final TextEditingController cityController;
  final bool isEditing; // Parameter untuk menentukan apakah widget aktif

  const CitySearchWidget({
    Key? key,
    required this.onCitySelected,
    required this.cityController,
    required this.isEditing, // Tambahkan parameter isEditing
  }) : super(key: key);

  @override
  _CitySearchWidgetState createState() => _CitySearchWidgetState();
}

class _CitySearchWidgetState extends State<CitySearchWidget> {
  final _userController = Get.put(UserController());
  var _cities = <Map<String, dynamic>>[].obs;
  var _isLoading = false.obs;
  bool _isDropdownVisible = false; // Untuk mengontrol visibilitas dropdown
  Timer? _debounce; // Timer untuk debouncing

  void _searchCities(String query) async {
    if (query.isEmpty) {
      _cities.clear(); // Kosongkan daftar jika query kosong
      setState(() {
        _isDropdownVisible = false; // Sembunyikan dropdown
      });
      return;
    }

    _isLoading.value = true;
    final cities = await _userController.searchCities(query);
    _cities.value = cities;
    _isLoading.value = false;

    // Debugging log
    print('Cities found: ${_cities.length}'); // Log jumlah kota yang ditemukan

    setState(() {
      _isDropdownVisible =
          _cities.isNotEmpty; // Tampilkan dropdown jika ada kota
    });
  }

  void _onQueryChanged(String query) {
    // Batalkan timer sebelumnya jika ada
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Set timer baru
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _searchCities(query); // Panggil pencarian setelah 300ms
    });
  }

  @override
  void dispose() {
    _debounce?.cancel(); // Hentikan timer saat widget dibuang
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: widget.isEditing
              ? () {
                  _searchCities(widget
                      .cityController.text); // Panggil pencarian saat diklik
                }
              : null, // Nonaktifkan jika tidak dalam mode edit
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), // Border radius 20
              border: Border.all(
                  color: Colors.grey.withOpacity(0.5)), // Border warna abu-abu
            ),
            child: TextField(
              controller: widget.cityController,
              onChanged: widget.isEditing
                  ? _onQueryChanged
                  : null, // Nonaktifkan jika tidak dalam mode edit
              readOnly:
                  !widget.isEditing, // Hanya bisa diedit jika dalam mode edit
              decoration: InputDecoration(
                labelText: 'Domisili',
                hintText: 'Cari kota...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ), // Hilangkan border default TextField
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10), // Jarak antara TextField dan dropdown
        Obx(() {
          if (_isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_isDropdownVisible && _cities.isNotEmpty) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), // Border radius 20
                border: Border.all(
                    color:
                        Colors.grey.withOpacity(0.5)), // Border warna abu-abu
              ),
              constraints:
                  BoxConstraints(maxHeight: 200), // Batasi tinggi dropdown
              child: ListView.builder(
                shrinkWrap: true,
                physics:
                    const AlwaysScrollableScrollPhysics(), // Memungkinkan scroll pada ListView
                itemCount: _cities.length,
                itemBuilder: (context, index) {
                  final city = _cities[index];
                  return ListTile(
                    title: Text(city['name']),
                    onTap: widget.isEditing
                        ? () {
                            widget.onCitySelected(city['code'],
                                city['name']); // Simpan city_code dan nama kota
                            widget.cityController.text = city[
                                'name']; // Tampilkan nama kota di TextField
                            _cities
                                .clear(); // Bersihkan daftar kota setelah dipilih
                            setState(() {
                              _isDropdownVisible =
                                  false; // Sembunyikan dropdown setelah memilih
                            });
                          }
                        : null, // Nonaktifkan jika tidak dalam mode edit
                  );
                },
              ),
            );
          }
          return const SizedBox
              .shrink(); // Tidak tampilkan apa-apa jika tidak ada kota
        }),
      ],
    );
  }
}
