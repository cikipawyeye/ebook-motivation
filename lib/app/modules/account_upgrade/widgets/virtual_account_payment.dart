import 'package:ebookapp/app/modules/account_upgrade/models/payment/virtual_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class VirtualAccountPayment extends StatelessWidget {
  final VirtualAccount va;

  const VirtualAccountPayment({
    super.key,
    required this.va,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: Colors.grey.withValues(alpha: 0.4),
          ),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bank ${va.channelCode.label}',
                style: GoogleFonts.leagueSpartan(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'No Virtual Account',
                style: GoogleFonts.leagueSpartan(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 330,
                height: 50,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      va.channelProperties.virtualAccountNumber,
                      style: GoogleFonts.leagueSpartan(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Salin nomor virtual account ke clipboard
                        Clipboard.setData(ClipboardData(
                            text: va.channelProperties.virtualAccountNumber));
                        // Tampilkan snackbar sebagai feedback
                        Get.snackbar(
                          'Berhasil',
                          'Nomor Virtual Account disalin',
                          snackPosition: SnackPosition.BOTTOM,
                          duration: const Duration(seconds: 2),
                        );
                      },
                      child: Text(
                        'Salin',
                        style: GoogleFonts.leagueSpartan(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
