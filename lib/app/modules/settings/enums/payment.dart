import 'package:ebookapp/app/data/enum/option.dart';
import 'package:ebookapp/app/modules/account_upgrade/models/payment/qr_code.dart';
import 'package:ebookapp/app/modules/account_upgrade/models/payment/virtual_account.dart';

enum PaymentType implements Option {
  ewallet,
  qrCode,
  virtualAccount;

  @override
  String get label {
    switch (this) {
      case PaymentType.ewallet:
        return 'E-Wallet';
      case PaymentType.qrCode:
        return 'QR Code';
      case PaymentType.virtualAccount:
        return 'Virtual Account';
    }
  }

  @override
  String get value {
    switch (this) {
      case PaymentType.ewallet:
        return 'EWALLET';
      case PaymentType.qrCode:
        return 'QR_CODE';
      case PaymentType.virtualAccount:
        return 'VIRTUAL_ACCOUNT';
    }
  }

  List<Option> get channels {
    switch (this) {
      case PaymentType.ewallet:
        return EWalletChannel.values;
      case PaymentType.qrCode:
        return QRCodeChannel.values;
      case PaymentType.virtualAccount:
        return VirtualAccountChannel.values;
    }
  }
}

enum EWalletChannel implements Option {
  ovo;

  @override
  String get label {
    switch (this) {
      case EWalletChannel.ovo:
        return 'OVO';
    }
  }

  @override
  String get value {
    switch (this) {
      case EWalletChannel.ovo:
        return 'OVO';
    }
  }
}
