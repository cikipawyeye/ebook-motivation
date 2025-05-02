import 'package:ebookapp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ebookapp/app/modules/register/controllers/register_controller.dart';
import 'package:ebookapp/core/constants/constant.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RegisterPage extends GetView<RegisterController> {
  final PageController _pageController = PageController();
  final _currentPage = RxInt(0);

  void nextPage() {
    _pageController
        .nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    )
        .then((_) {
      _currentPage.value = _pageController.page?.round() ?? 0;
    });
  }

  void prevPage() {
    _pageController
        .previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    )
        .then((_) {
      _currentPage.value = _pageController.page?.round() ?? 0;
    });
  }

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            return;
          }

          int currentPage = _pageController.page?.round() ?? 0;

          if (currentPage > 0) {
            prevPage();
          } else {
            Get.back(closeOverlays: true);
          }
        },
        child: Obx(() => Scaffold(
              resizeToAvoidBottomInset: _currentPage.value == 6,
              extendBodyBehindAppBar: true,
              appBar: _buildAppBar(),
              body: Stack(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/Template.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SafeArea(
                      child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Expanded(
                          child: PageView(
                            controller: _pageController,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              _buildNameStep(),
                              _buildEmailStep(),
                              _buildPhoneStep(),
                              _buildGenderStep(),
                              _buildDobStep(),
                              _buildDomisiliStep(),
                              _buildJobStep(context),
                              _buildPasswordStep(),
                            ],
                          ),
                        ),
                        _buildNavigationButton(context),
                      ],
                    ),
                  )),
                ],
              ),
            )));
  }

  // App Bar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      // Must be reactive
      // leading: _pageController.page!.round() > 0
      //     ? IconButton(
      //         icon: Icon(Icons.arrow_back, color: Colors.white),
      //         onPressed: () {
      //           if (_pageController.page!.round() > 0) {
      //             _pageController.previousPage(
      //               duration: Duration(milliseconds: 300),
      //               curve: Curves.easeInOut,
      //             );
      //           }
      //         },
      //       )
      //     : null,
      centerTitle: true,
      title: SmoothPageIndicator(
        controller: _pageController,
        count: 8,
        effect: WormEffect(
          activeDotColor: colorBackground,
          dotColor: Colors.grey,
          dotHeight: 8,
          dotWidth: 8,
        ),
      ),
    );
  }

  // Step Name
  Widget _buildNameStep() {
    return _buildScrollableColumn(child: [
      Text(
        'Assalamualaikum,\nKenalan dulu yuk!',
        style: GoogleFonts.leagueSpartan(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      SizedBox(height: 50),
      Text(
        'Silahkan tulis nama lengkap…',
        style: GoogleFonts.leagueSpartan(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
      ),
      SizedBox(height: 5),
      Obx(() => TextField(
            controller: controller.nameController,
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 18),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: 'Nama Lengkap',
              labelStyle: TextStyle(
                fontSize: 12,
                color: Colors.white.withValues(alpha: 0.5),
              ),
              errorText: controller.isNameError.value
                  ? 'Nama harus minimal 2 karakter'
                  : null,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                    color: Colors.white.withValues(alpha: 0.5), width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                    color: Colors.white.withValues(alpha: 0.5), width: 1.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onChanged: (value) {
              controller.validateName(); // Called on every change
              // Ambil nama depan dari nama lengkap
              if (value.isNotEmpty) {
                List<String> names = value.split(' ');
                controller.firstName.value = names.first; // Ambil nama depan
              } else {
                controller.firstName.value = ''; // Reset jika kosong
              }
            },
          )),
      SizedBox(height: 40),
      GestureDetector(
        onTap: () {
          Get.toNamed(Routes.login);
        },
        child: Align(
          alignment: Alignment.center,
          child: RichText(
            text: TextSpan(
              text: 'Sudah punya akun? ',
              style: GoogleFonts.leagueSpartan(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.white.withValues(alpha: 0.8),
              ),
              children: [
                TextSpan(
                  text: 'Login',
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 10),
    ]);
  }

  // Step Email
  Widget _buildEmailStep() {
    return _buildScrollableColumn(
      child: [
        Obx(
          () => Text(
            'Terima kasih, ${controller.firstName.value}...',
            style: GoogleFonts.leagueSpartan(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 40),
        Text(
          'Tolong tuliskan alamat emailnya yaa…',
          style: GoogleFonts.leagueSpartan(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 5),
        Obx(() => TextField(
              controller: controller.emailController,
              style: TextStyle(
                color: Colors.white,
              ),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 18),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                labelText: 'Email',
                labelStyle: TextStyle(
                    fontSize: 12, color: Colors.white.withValues(alpha: 0.5)),
                errorText:
                    controller.isEmailError.value ? 'Email tidak valid' : null,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: Colors.white.withValues(alpha: 0.5), width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: Colors.white.withValues(alpha: 0.5), width: 1.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onChanged: (_) => controller.validateEmail(),
            )),
      ],
    );
  }

  // Step Phone
  Widget _buildPhoneStep() {
    return _buildScrollableColumn(child: [
      Text(
        'Silahkan tulis juga\nnomor teleponnya…',
        style: GoogleFonts.leagueSpartan(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          height: 0.95,
          color: Colors.white,
        ),
      ),
      SizedBox(height: 40),
      Obx(() => TextField(
            controller: controller.phoneNumberController,
            style: TextStyle(
              color: Colors.white,
            ),
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 18),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: 'Nomor Telepon',
              labelStyle: TextStyle(
                  fontSize: 12, color: Colors.white.withValues(alpha: 0.5)),
              errorText: controller.isPhoneError.value
                  ? 'Nomor telepon tidak valid'
                  : null,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                    color: Colors.white.withValues(alpha: 0.5), width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(
                    color: Colors.white.withValues(alpha: 0.5), width: 1.0),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onChanged: (_) => controller.validatePhoneNumber(),
          )),
    ]);
  }

  // Step Gender
  Widget _buildGenderStep() {
    return _buildScrollableColumn(child: [
      Text(
        'Tolong isikan gendernya donk…!',
        style: GoogleFonts.leagueSpartan(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            height: 0.95,
            color: Colors.white),
      ),
      SizedBox(height: 40),
      Obx(() => Column(
            children: [
              GestureDetector(
                onTap: () {
                  controller.setGender('M'); // Laki-laki
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: controller.selectedGender.value == 'M'
                        ? colorBackground
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: controller.selectedGender.value == 'M'
                          ? colorBackground
                          : Colors.grey,
                    ),
                  ),
                  child: Text(
                    'Laki-laki',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  controller.setGender('F'); // Perempuan
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: controller.selectedGender.value == 'F'
                        ? colorBackground
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: controller.selectedGender.value == 'F'
                          ? colorBackground
                          : Colors.grey,
                    ),
                  ),
                  child: Text(
                    'Perempuan',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )),
    ]);
  }

  // Step Date of Birth
  Widget _buildDobStep() {
    return _buildScrollableColumn(child: [
      Text(
        'Tanggal lahirnya kapan…?',
        style: GoogleFonts.leagueSpartan(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      SizedBox(height: 40),
      TextField(
        controller: controller.dobController,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 18),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: 'Pilih Tanggal Lahir',
          labelStyle: TextStyle(
              fontSize: 12, color: Colors.white.withValues(alpha: 0.5)),
          errorText:
              controller.isPhoneError.value ? 'Pilih tanggal yang valid' : null,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.5), width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.5), width: 1.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: Get.context!,
            initialDate:
                DateTime.now().subtract(const Duration(days: 365 * 18)),
            firstDate: DateTime(1940),
            lastDate: DateTime.now(),
          );
          if (pickedDate != null) {
            controller.dobController.text =
                DateFormat('yyyy-MM-dd').format(pickedDate);
            controller.validateDob();
          }
        },
        readOnly: true,
      ),
    ]);
  }

  // Step City/Domicile
  Widget _buildDomisiliStep() {
    return _buildScrollableColumn(child: [
      Text(
        'Sekarang tinggal dimana…?',
        style: GoogleFonts.leagueSpartan(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            height: 0.95,
            color: Colors.white),
      ),
      SizedBox(height: 40),
      Text(
        'Domisili (Kota/Kabupaten)',
        style: GoogleFonts.leagueSpartan(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
      ),
      SizedBox(height: 5),
      TextField(
        controller: controller.domisiliController,
        style: TextStyle(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 18),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: 'Ketik nama Kota/Kabupaten',
          labelStyle: TextStyle(
              fontSize: 12, color: Colors.white.withValues(alpha: 0.5)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.5), width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
                color: Colors.white.withValues(alpha: 0.5), width: 1.0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onChanged: (value) => controller.searchCities(value),
      ),
      Obx(() => controller.isSearching.value
          ? Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: Text(
                  'Searching...',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 14,
                  ),
                ),
              ))
          : Column(
              children: controller.domisiliList
                  .map((city) => ListTile(
                        title: Text(
                          city['name'],
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onTap: () => controller.onCitySelected(city),
                      ))
                  .toList(),
            )),
    ]);
  }

  // Step Job
  Widget _buildJobStep(BuildContext context) {
    final Map<String, String> jobType = {
      '1': 'Pelajar',
      '2': 'Mahasiswa',
      '3': 'Pegawai Negeri (ASN)',
      '4': 'Pegawai Swasta/Karyawan Swasta',
      '5': 'Profesional/Ahli',
      '6': 'Ibu Rumah Tangga',
      '7': 'Wiraswasta/Pengusaha',
      '8': 'Tidak Bekerja',
    };

    return _buildScrollableColumn(
      child: [
        Text(
          'Saat ini pekerjaannya apa…?',
          style: GoogleFonts.leagueSpartan(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        SizedBox(height: 20),
        Obx(() => Column(
              children: jobType.entries.map((entry) {
                final key = entry.key;
                final title = entry.value;
                return GestureDetector(
                  onTap: () {
                    controller.selectedJobType.value = int.parse(key);
                    controller.customJobController.clear();

                    FocusScope.of(context).unfocus();
                  },
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      color: controller.selectedJobType.value == int.parse(key)
                          ? colorBackground
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color:
                            controller.selectedJobType.value == int.parse(key)
                                ? colorBackground
                                : Colors.white.withValues(alpha: 0.5),
                        width: 1,
                      ),
                    ),
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              }).toList(),
            )),
        Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: GestureDetector(
            onTap: () {
              controller.selectedJobType.value = 0; // Lain-lain
            },
            child: TextField(
              style: TextStyle(
                color: Colors.white,
              ),
              onTap: () => controller.selectedJobType.value = 0,
              onChanged: (value) =>
                  {if (value.isNotEmpty) controller.selectedJobType.value = 0},
              controller: controller.customJobController,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                labelText: 'Lain-lain (isi sendiri)',
                labelStyle: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5), fontSize: 14),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: Colors.white.withValues(alpha: 0.5), width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: Colors.white.withValues(alpha: 0.5), width: 1.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  // Step Password
  Widget _buildPasswordStep() {
    return _buildScrollableColumn(
      child: [
        Text(
          'Silahkan atur kata sandi…',
          style: GoogleFonts.leagueSpartan(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 0.95),
        ),
        SizedBox(height: 40),
        Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kata Sandi',
                style: GoogleFonts.leagueSpartan(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5),
              TextField(
                controller: controller.passwordController,
                obscureText: !controller.isPasswordVisible.value,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 18),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: 'Kata Sandi',
                  labelStyle: TextStyle(
                      fontSize: 12, color: Colors.white.withValues(alpha: 0.5)),
                  errorText: controller.isPasswordError.value
                      ? 'Password minimal 8 karakter, huruf kapital dan angka'
                      : null,
                  suffixIcon: IconButton(
                    icon: Icon(controller.isPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: controller.togglePasswordVisibility,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                        color: Colors.white.withValues(alpha: 0.5), width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                        color: Colors.white.withValues(alpha: 0.5), width: 1.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onChanged: (value) => controller.validatePassword(value),
              ),
              SizedBox(height: 16),
              Text(
                'Masukkan kembali kata Sandi',
                style: GoogleFonts.leagueSpartan(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5),
              TextField(
                controller: controller.confirmPasswordController,
                obscureText: !controller.isConfirmPasswordVisible.value,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 18),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: 'Konfirmasi Kata Sandi',
                  labelStyle: TextStyle(
                      fontSize: 12, color: Colors.white.withValues(alpha: 0.5)),
                  errorText: controller.isConfirmPasswordError.value
                      ? 'Konfirmasi password tidak cocok'
                      : null,
                  suffixIcon: IconButton(
                    icon: Icon(controller.isConfirmPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: controller.toggleConfirmPasswordVisibility,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                        color: Colors.white.withValues(alpha: 0.5), width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                        color: Colors.white.withValues(alpha: 0.5), width: 1.0),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onChanged: (value) => controller.validateConfirmPassword(value),
              ),
              SizedBox(height: 16),

              // CheckBox for terms and conditions
              Obx(
                () => Row(
                  children: [
                    Checkbox(
                      value: controller.isAgreed.value,
                      activeColor: colorBackground,
                      onChanged: (value) {
                        if (value != null) {
                          controller.isAgreed.value = value;
                          if (value) {
                            _showTermsAndConditions(Get.context!);
                          }
                        }
                      },
                    ),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: 'Saya telah menyetujui ',
                          style: GoogleFonts.leagueSpartan(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                          children: [
                            TextSpan(
                              text: 'term of service',
                              style: GoogleFonts.leagueSpartan(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: ' dan ',
                              style: GoogleFonts.leagueSpartan(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: GoogleFonts.leagueSpartan(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: ' yang berlaku.',
                              style: GoogleFonts.leagueSpartan(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Navigation Button
  Widget _buildNavigationButton(BuildContext context) {
    return Obx(() => ElevatedButton(
          onPressed: controller.isLoading.value
              ? null
              : () => _navigateOrRegister(context),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(180, 40),
            backgroundColor: Colors.white.withValues(alpha: 0.3),
          ),
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 26),
              child: Text(
                controller.isLoading.value ? 'Loading...' : 'Lanjutkan',
                style: GoogleFonts.leagueSpartan(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ));
  }

  // Logic Navigation
  void _navigateOrRegister(BuildContext context) {
    int currentPage = _pageController.page?.round() ?? 0;

    // Validasi untuk memastikan bahwa setiap halaman diisi sebelum melanjutkan
    switch (currentPage) {
      case 0:
        if (!controller.validateName()) return;
        break;
      case 1:
        if (!controller.isEmailValid()) return;
        break;
      case 2:
        if (!controller.isPhoneNumberValid()) return;
        break;
      case 3:
        // Gender selection doesn't need validation for this demo
        break;
      case 4:
        if (!controller.isDobValid()) return;
        break;
      case 5:
        if (controller.domisiliController.text.isEmpty) return;
        break;
      case 6:
        if (!controller.validateJob()) return;
        break;
      case 7:
        if (!controller.isPasswordValid()) return;
        break;
    }

    FocusScope.of(context).unfocus();

    // Navigasi hanya jika halaman ada
    if (currentPage == 7) {
      controller.register();
    } else {
      // Melanjutkan ke halaman berikutnya
      nextPage();
    }
  }

  void _showTermsAndConditions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                    child: Text(
                  'KEBIJAKAN PRIVASI',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: Text(
                  'Aplikasi Mobile Motivasi Penyejuk Hati dari Al-Qur’an',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(),
                )),
                Center(
                    child: Text(
                  'Versi Terakhir: 6 Desember 2024',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(),
                )),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.grey, // warna garis
                  thickness: 1, // ketebalan garis
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Selamat datang di aplikasi mobile e-book Motivasi Penyejuk Hati dari Al-Qur’an. '
                  'Syarat dan Ketentuan ini mengatur akses dan penggunaan Aplikasi oleh pengguna ("Anda") '
                  'yang disediakan oleh [Eli Nur Nirmala Sari] ("Kami"). Dengan mengunduh, menginstal, '
                  'dan menggunakan Aplikasi ini, Anda menyetujui seluruh syarat dan ketentuan yang berlaku.\n'
                  'Jika Anda tidak setuju dengan salah satu bagian dari Ketentuan ini, harap segera berhenti menggunakan Aplikasi.\n\n'
                  '1. Pendahuluan\n'
                  '1.1 Deskripsi Layanan\n'
                  'Aplikasi ini menyediakan akses ke e-book Motivasi Penyejuk Hati dari Al-Qur’an, '
                  'termasuk artikel, konten premium, dan fitur lainnya yang dirancang untuk mendukung pengalaman membaca Anda.\n'
                  '1.2 Penerimaan Ketentuan\n'
                  'Dengan menggunakan Aplikasi ini, Anda menyetujui Ketentuan ini, kebijakan privasi, '
                  'dan semua peraturan lainnya yang kami tetapkan terkait penggunaan layanan.\n\n'
                  '2. Ketentuan Penggunaan\n'
                  '2.1 Registrasi Akun\n'
                  'Anda wajib membuat akun untuk menggunakan beberapa fitur Aplikasi. '
                  'Data yang diperlukan meliputi nama lengkap, alamat email, dan password.\n'
                  'Anda bertanggung jawab menjaga kerahasiaan akun Anda dan tidak boleh membagikannya kepada pihak ketiga.\n'
                  '2.2 Batasan Usia\n'
                  'Aplikasi ini hanya boleh digunakan oleh individu yang berusia minimal 13 tahun.\n'
                  'Jika Anda berusia di bawah 18 tahun, Anda harus mendapatkan izin dari orang tua atau wali Anda.\n'
                  '2.3 Penggunaan yang Dilarang\n'
                  'You dilarang menggunakan Aplikasi untuk:\n'
                  'Konten yang melanggar hukum, diskriminatif, atau berisi ujaran kebencian.\n'
                  'Mendistribusikan ulang konten dari Aplikasi tanpa persetujuan tertulis dari Kami.\n\n'
                  '3. Fitur Pembayaran\n'
                  '3.1 Konten Premium dan Transaksi\n'
                  'Beberapa e-book atau fitur dalam Aplikasi hanya dapat diakses dengan pembelian tertentu '
                  'menggunakan layanan pembayaran yang terintegrasi (Xendit).\n'
                  'Semall transaksi bersifat final dan tidak dapat dikembalikan, kecuali terdapat kesalahan teknis pada sistem Kami.\n'
                  '3.2 Keamanan Pembayaran\n'
                  'Kami bekerja sama dengan penyedia layanan pembayaran terpercaya untuk memproses transaksi Anda.\n'
                  'You wajib memastikan informasi pembayaran yang diberikan adalah benar dan akurat.\n\n'
                  '4. Hak Kekayaan Intelektual\n'
                  '4.1 Hak Cipta dan Konten\n'
                  'Semua konten di Aplikasi, termasuk e-book, artikel, desain, logo, dan fitur lainnya, '
                  'adalam milik Kami atau pemberi lisensi Kami, dan dilindungi oleh undang-undang hak cipta.\n'
                  'You tidak diperbolehkan menyalin, mendistribusikan, atau memodifikasi konten Aplikasi tanpa izin tertulis dari Kami.\n\n'
                  '5. Kebijakan Keamanan\n'
                  '5.1 Data Pengguna\n'
                  'Kami berkomitmen untuk menjaga keamanan data pribadi Anda. Kebijakan penggunaan data sepenuhnya diatur dalam Kebijakan Privasi Kami.\n'
                  '5.2 Tanggung Jawab Anda\n'
                  'You bertanggung jawab atas keamanan perangkat Anda dalam menggunakan Aplikasi, '
                  'termasuk memastikan perangkat bebas dari virus atau perangkat lunak berbahaya lainnya.\n'
                  '5.3 Penyalahgunaan Akun\n'
                  'Kami tidak bertanggung jawab atas akses yang tidak sah ke akun Anda yang disebabkan oleh kelalaian Anda dalam menjaga kerahasiaan data akun Anda.\n\n'
                  '6. Batasan Tanggung Jawab\n'
                  '6.1 Kegagalan Sistem atau Layanan\n'
                  'Kami tidak bertanggung jawab atas kehilangan data, keterlambatan akses, atau kerusakan perangkat '
                  'yang diakibatkan oleh kegagalan sistem, perangkat lunak, atau koneksi internet Anda.\n'
                  '6.2 Konten Pihak Ketiga\n'
                  'Aplikasi ini mungkin menyertakan tautan ke konten pihak ketiga atau layanan eksternal (misalnya, API pembayaran). '
                  'Kami tidak bertanggung jawab atas kualitas atau keamanan layanan yang disediakan oleh pihak ketiga tersebut.\n'
                  '6.3 Keakuratan Konten\n'
                  'Kami berusaha menyediakan konten Islami yang akurat, tetapi Kami tidak memberikan jaminan atau pernyataan '
                  'bahwa semua konten sepenuhnya bebas dari kesalahan atau sesuai dengan interpretasi individu Anda.\n\n'
                  '7. Penghentian Layanan\n'
                  '7.1 Hak Kami\n'
                  'Kami berhak menangguhkan atau menghentikan akses Anda ke Aplikasi jika Anda melanggar Ketentuan ini, tanpa pemberitahuan sebelumnya.\n'
                  '7.2 Keputusan Final\n'
                  'Semall keputusan terkait penghentian akses bersifat final dan tidak dapat diganggu gugat.\n\n'
                  '8. Perubahan Ketentuan\n'
                  'Kami dapat memperbarui Ketentuan ini sewaktu-waktu. Jika ada perubahan signifikan, Kami akan memberi tahu Anda '
                  'melalui Aplikasi atau email terdaftar Anda. Dengan terus menggunakan Aplikasi setelah perubahan diberlakukan, '
                  'You menyetujui Ketentuan yang diperbarui.\n\n'
                  '9. Kontak Kami\n'
                  'Jika Anda memiliki pertanyaan, saran, atau keluhan terkait Aplikasi atau Ketentuan ini, silakan hubungi Kami melalui:\n'
                  'Email: 3linnsari@gmail.com\n\n'
                  'KEBIJAKAN PRIVASI\n'
                  'Aplikasi Mobile Motivasi Penyejuk Hati dari Al-Qur’an\n'
                  'Versi Terakhir: 6 Desember 2024\n'
                  'Kami, [Eli Nur Nirmala Sari] ("Kami"), menghargai privasi Anda dan berkomitmen untuk melindungi data pribadi yang Anda berikan saat menggunakan aplikasi mobile Motivasi Penyejuk Hati dari Al-Qur’an'
                  'an ("Aplikasi"). Kebijakan Privasi ini menjelaskan bagaimana Kami mengumpulkan, menggunakan, menyimpan, dan melindungi informasi pribadi Anda.\n'
                  'Dengan menggunakan Aplikasi, Anda menyetujui pengumpulan dan penggunaan informasi sebagaimana diatur dalam Kebijakan Privasi ini. Jika Anda tidak setuju, mohon untuk tidak menggunakan Aplikasi ini.\n\n'
                  '1. Informasi yang Kami Kumpulkan\n'
                  'Kami mengumpulkan informasi berikut dari pengguna:\n'
                  '1.1 Informasi Pribadi\n'
                  'Nama lengkap.\n'
                  'Alamat email.\n'
                  'Nomor telepon\n'
                  'Domisili\n'
                  'Usia.\n'
                  'Informasi pembayaran (hanya digunakan saat Anda melakukan pembelian).\n'
                  '1.2 Informasi Teknis\n'
                  'Alamat IP.\n'
                  'Jenis perangkat dan sistem operasi.\n'
                  'Log aktivitas di Aplikasi (misalnya, halaman yang diakses, waktu penggunaan).\n'
                  '1.3 Informasi Pihak Ketiga\n'
                  'Jika Anda mendaftar atau login menggunakan akun media sosial (jika tersedia), Kami dapat mengakses informasi dasar dari akun tersebut, seperti nama dan alamat email.\n\n'
                  '2. Cara Kami Menggunakan Informasi Anda\n'
                  'Kami menggunakan data yang dikumpulkan untuk:\n'
                  '2.1 Memberikan Layanan\n'
                  'Memproses registrasi akun dan login.\n'
                  'Mengelola transaksi pembelian konten premium melalui integrasi dengan API Xendit.\n'
                  'Menyediakan akses ke e-book Islami dan artikel yang relevan.\n'
                  '2.2 Meningkatkan Pengalaman Pengguna\n'
                  'Meningkatkan performa Aplikasi berdasarkan data teknis.\n'
                  'Menyediakan rekomendasi e-book yang sesuai dengan preferensi Anda.\n'
                  '2.3 Keamanan\n'
                  'Mendeteksi dan mencegah aktivitas mencurigakan, seperti akses tidak sah atau penyalahgunaan fitur.\n'
                  'Memastikan perlindungan konten dengan watermark otomatis.\n'
                  '2.4 Komunikasi\n'
                  'Mengirimkan pemberitahuan terkait akun, pembaruan Aplikasi, dan penawaran khusus melalui email atau push notification (jika Anda mengizinkan).\n\n'
                  '3. Bagaimana Kami Melindungi Data Anda\n'
                  'Kami menerapkan langkah-langkah berikut untuk menjaga keamanan data Anda:\n'
                  '3.1 Enkripsi\n'
                  'Semall data pribadi dan informasi pembayaran dienkripsi menggunakan protokol keamanan (seperti HTTPS dan SSL) untuk mencegah akses tidak sah selama transmisi.\n'
                  '3.2 Pembatasan Akses\n'
                  'Hanya karyawan yang berwenang yang dapat mengakses data pribadi Anda.\n'
                  '3.3 Audit Keamanan\n'
                  'Kami secara rutin memeriksa sistem Kami untuk memastikan tidak ada kerentanan atau ancaman keamanan.\n\n'
                  '4. Pembagian Informasi\n'
                  'Kami tidak akan menjual, menyewakan, atau membagikan data pribadi Anda kepada pihak ketiga, kecuali dalam situasi berikut:\n'
                  '4.1 Layanan Pihak Ketiga\n'
                  'Penyedia Layanan Pembayaran: Data terkait transaksi akan dibagikan dengan Xendit untuk memproses pembayaran.\n'
                  'Penyedia Hosting: Data Anda disimpan di server yang disediakan oleh penyedia hosting terpercaya.\n'
                  '4.2 Persyaratan Hukum\n'
                  'Kami dapat membagikan data Anda jika diwajibkan oleh hukum atau untuk memenuhi permintaan yang sah dari pihak berwenang (misalnya, polisi atau pengadilan).\n'
                  '4.3 Perlindungan Hak\n'
                  'Jika diperlukan untuk melindungi hak, properti, atau keselamatan Kami, pengguna lain, atau masyarakat umum.\n\n'
                  '5. Cookie dan Teknologi Serupa\n'
                  'Kami menggunakan cookie dan teknologi serupa untuk meningkatkan pengalaman Anda saat menggunakan Aplikasi. Cookie digunakan untuk:\n'
                  'Menyimpan preferensi pengguna.\n'
                  'Menganalisis penggunaan Aplikasi untuk meningkatkan layanan.\n'
                  'Anda dapat menonaktifkan cookie melalui pengaturan perangkat Anda, tetapi ini mungkin memengaruhi fungsi tertentu dalam Aplikasi.\n\n'
                  '6. Hak Anda\n'
                  'You memiliki hak berikut terkait data pribadi Anda:\n'
                  '6.1 Akses Data\n'
                  'Anda dapat meminta salinan informasi pribadi yang telah Kami kumpulkan.\n'
                  '6.2 Perbaikan Data\n'
                  'Anda dapat meminta Kami untuk memperbarui atau memperbaiki informasi pribadi yang tidak akurat.\n'
                  '6.3 Penghapusan Data\n'
                  'Anda dapat meminta penghapusan akun dan data pribadi Anda, kecuali jika data tersebut diperlukan untuk memenuhi kewajiban hukum Kami.\n'
                  '6.4 Menolak Komunikasi\n'
                  'Anda dapat memilih untuk berhenti menerima email promosi atau push notification kapan saja melalui pengaturan akun Anda.\n\n'
                  '7. Penyimpanan Data\n'
                  'Kami hanya menyimpan data pribadi Anda selama diperlukan untuk tujuan yang telah dijelaskan dalam Kebijakan Privasi ini, atau untuk memenuhi kewajiban hukum Kami.\n'
                  'Jika Anda menghapus akun, data Anda akan dihapus dari server Kami dalam waktu 30 hari, kecuali data tertentu yang harus disimpan untuk keperluan hukum atau akuntansi.\n\n'
                  '8. Perubahan Kebijakan Privasi\n'
                  'Kami dapat memperbarui Kebijakan Privasi ini dari waktu ke waktu. Jika ada perubahan material, Kami akan memberi tahu Anda melalui Aplikasi atau email terdaftar Anda sebelum perubahan diberlakukan.\n'
                  'Tanggal revisi terakhir akan ditampilkan di bagian atas dokumen ini.\n\n'
                  '9. Anak-Anak\n'
                  'Aplikasi ini tidak ditujukan untuk anak-anak di bawah usia 13 tahun. Kami tidak secara sengaja mengumpulkan informasi pribadi dari anak-anak tanpa persetujuan orang tua atau wali mereka. Jika Anda mengetahui bahwa seorang anak telah memberikan data pribadinya tanpa persetujuan, silakan hubungi Kami untuk penghapusan.\n\n'
                  '10. Kontak Kami\n'
                  'Jika Anda memiliki pertanyaan, saran, atau keluhan terkait Kebijakan Privasi ini, silakan hubungi Kami melalui:\n'
                  'Email: 3linnsari@gmail.com',
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup modal
              },
              child: Text(
                'Tutup',
                style: GoogleFonts.poppins(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                // Setujui syarat dan ketentuan
                controller.isAgreed.value = true;
                Navigator.of(context).pop();
              },
              child: Text(
                'Setuju',
                style: GoogleFonts.poppins(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Function to build scrollable column
  Widget _buildScrollableColumn({required List<Widget> child}) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: child,
      ),
    );
  }
}
