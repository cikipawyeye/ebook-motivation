abstract class Option {
  String get label;
  String get value;
}

enum PaymentType implements Option {
  ewallet,
  virtualAccount;

  @override
  String get label {
    switch (this) {
      case PaymentType.ewallet:
        return 'E-Wallet';
      case PaymentType.virtualAccount:
        return 'Virtual Account';
    }
  }

  @override
  String get value {
    switch (this) {
      case PaymentType.ewallet:
        return 'EWALLET';
      case PaymentType.virtualAccount:
        return 'VIRTUAL_ACCOUNT';
    }
  }

  List<Option> get channels {
    switch (this) {
      case PaymentType.ewallet:
        return EWalletChannel.values;
      case PaymentType.virtualAccount:
        return VirtualAccountChannel.values;
    }
  }
}

enum EWalletChannel implements Option {
  dana,
  linkaja,
  ovo;

  @override
  String get label {
    switch (this) {
      case EWalletChannel.dana:
        return 'DANA';
      case EWalletChannel.linkaja:
        return 'LinkAja';
      case EWalletChannel.ovo:
        return 'OVO';
    }
  }

  @override
  String get value {
    switch (this) {
      case EWalletChannel.dana:
        return 'DANA';
      case EWalletChannel.linkaja:
        return 'LINKAJA';
      case EWalletChannel.ovo:
        return 'OVO';
    }
  }
}

enum VirtualAccountChannel implements Option {
  bca,
  bri,
  bni,
  mandiri,
  bsi,
  bjb,
  cimb,
  sahabatSampoerna,
  permata;

  @override
  String get label {
    switch (this) {
      case VirtualAccountChannel.bca:
        return 'BCA';
      case VirtualAccountChannel.bri:
        return 'BRI';
      case VirtualAccountChannel.bni:
        return 'BNI';
      case VirtualAccountChannel.mandiri:
        return 'Mandiri';
      case VirtualAccountChannel.bsi:
        return 'BSI';
      case VirtualAccountChannel.bjb:
        return 'BJB';
      case VirtualAccountChannel.cimb:
        return 'CIMB Niaga';
      case VirtualAccountChannel.sahabatSampoerna:
        return 'Sahabat Sampoerna';
      case VirtualAccountChannel.permata:
        return 'Permata Bank';
    }
  }

  @override
  String get value {
    switch (this) {
      case VirtualAccountChannel.bca:
        return 'BCA';
      case VirtualAccountChannel.bri:
        return 'BRI';
      case VirtualAccountChannel.bni:
        return 'BNI';
      case VirtualAccountChannel.mandiri:
        return 'MANDIRI';
      case VirtualAccountChannel.bsi:
        return 'BSI';
      case VirtualAccountChannel.bjb:
        return 'BJB';
      case VirtualAccountChannel.cimb:
        return 'CIMB';
      case VirtualAccountChannel.sahabatSampoerna:
        return 'SAHABAT_SAMPOERNA';
      case VirtualAccountChannel.permata:
        return 'PERMATA';
    }
  }
}
