import 'package:ebookapp/app/data/enum/option.dart';
import 'package:ebookapp/app/modules/account_upgrade/models/payment/qr_code.dart';
import 'package:ebookapp/app/modules/account_upgrade/models/payment/virtual_account.dart';
import 'package:ebookapp/app/modules/settings/enums/payment.dart';

class PaymentMethod {
  final PaymentMethodType type;
  final QRCode? qrCode;
  final VirtualAccount? virtualAccount;

  PaymentMethod({
    required this.type,
    this.qrCode,
    this.virtualAccount,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      type: PaymentMethodType.values.firstWhere(
        (e) => e.value == json['type'],
      ),
      qrCode: json['qr_code'] != null ? QRCode.fromJson(json['qr_code']) : null,
      virtualAccount: json['virtual_account'] != null
          ? VirtualAccount.fromJson(json['virtual_account'])
          : null,
    );
  }
}

enum PaymentMethodType implements Option {
  ewallet,
  qrCode,
  virtualAccount;

  @override
  String get label {
    switch (this) {
      case PaymentMethodType.ewallet:
        return 'E-Wallet';
      case PaymentMethodType.qrCode:
        return 'QR Code';
      case PaymentMethodType.virtualAccount:
        return 'Virtual Account';
    }
  }

  @override
  String get value {
    switch (this) {
      case PaymentMethodType.ewallet:
        return 'EWALLET';
      case PaymentMethodType.qrCode:
        return 'QR_CODE';
      case PaymentMethodType.virtualAccount:
        return 'VIRTUAL_ACCOUNT';
    }
  }

  List<Option> get channels {
    switch (this) {
      case PaymentMethodType.ewallet:
        return EWalletChannel.values;
      case PaymentMethodType.qrCode:
        return QRCodeChannel.values;
      case PaymentMethodType.virtualAccount:
        return VirtualAccountChannel.values;
    }
  }
}
