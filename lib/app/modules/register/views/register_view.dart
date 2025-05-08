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
        'Silahkan tulis nama lengkap…',
        style: GoogleFonts.leagueSpartan(
          fontSize: 24,
          color: Colors.white,
        ),
      ),
      SizedBox(height: 80),
      Text(
        'Nama lengkap',
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
            'Terima kasih, ${controller.firstName.value}.\nTolong tuliskan alamat emailnya',
            style: GoogleFonts.leagueSpartan(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 80),
        Text(
          'Alamat email',
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
          fontSize: 24,
          color: Colors.white,
        ),
      ),
      SizedBox(height: 80),
      Text(
        'Nomor telepon',
        style: GoogleFonts.leagueSpartan(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
      ),
      SizedBox(height: 5),
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
            fontSize: 24, height: 0.95, color: Colors.white),
      ),
      SizedBox(height: 80),
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
        'Tanggal lahirnya kapan…?\nTolong kasih tahu yaa…',
        style: GoogleFonts.leagueSpartan(fontSize: 24, color: Colors.white),
      ),
      SizedBox(height: 80),
      Text(
        'Tanggal lahir',
        style: GoogleFonts.leagueSpartan(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
      ),
      SizedBox(height: 5),
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
        style: GoogleFonts.leagueSpartan(fontSize: 24, color: Colors.white),
      ),
      SizedBox(height: 80),
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
          style: GoogleFonts.leagueSpartan(fontSize: 24, color: Colors.white),
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
          style: GoogleFonts.leagueSpartan(fontSize: 24, color: Colors.white),
        ),
        SizedBox(height: 80),
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
                    icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white.withValues(alpha: 0.5)),
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
                    icon: Icon(
                        controller.isConfirmPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white.withValues(alpha: 0.5)),
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      side: BorderSide(
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
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
                  privacyPolicy,
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
