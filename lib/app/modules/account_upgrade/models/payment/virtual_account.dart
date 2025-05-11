import 'package:ebookapp/app/data/enum/option.dart';

class VirtualAccount {
  final int amount;
  final VirtualAccountChannel channelCode;
  final ChannelProperties channelProperties;

  VirtualAccount({
    required this.amount,
    required this.channelCode,
    required this.channelProperties,
  });

  factory VirtualAccount.fromJson(Map<String, dynamic> json) {
    return VirtualAccount(
      amount: json['amount'] as int,
      channelCode: VirtualAccountChannel.values
          .firstWhere((e) => e.value == json['channel_code']),
      channelProperties: ChannelProperties.fromJson(
          json['channel_properties'] as Map<String, dynamic>),
    );
  }
}

class ChannelProperties {
  final String customerName;
  final String virtualAccountNumber;
  final DateTime expiresAt;

  ChannelProperties({
    required this.customerName,
    required this.virtualAccountNumber,
    required this.expiresAt,
  });

  factory ChannelProperties.fromJson(Map<String, dynamic> json) {
    return ChannelProperties(
      customerName: json['customer_name'] as String,
      virtualAccountNumber: json['virtual_account_number'] as String,
      expiresAt: DateTime.parse(json['expires_at'] as String)
          .subtract(Duration(minutes: 10)),
    );
  }
}

enum VirtualAccountChannel implements Option {
  bri,
  bni,
  mandiri,
  // bsi,
  bjb,
  cimb,
  sahabatSampoerna;

  @override
  String get label {
    switch (this) {
      case VirtualAccountChannel.bri:
        return 'BRI';
      case VirtualAccountChannel.bni:
        return 'BNI';
      case VirtualAccountChannel.mandiri:
        return 'Mandiri';
      // Uncomment this block if you want to add BSI payment instructions
      // case VirtualAccountChannel.bsi:
      //   return 'BSI';
      case VirtualAccountChannel.bjb:
        return 'BJB';
      case VirtualAccountChannel.cimb:
        return 'CIMB Niaga';
      case VirtualAccountChannel.sahabatSampoerna:
        return 'Sahabat Sampoerna';
    }
  }

  @override
  String get value {
    switch (this) {
      case VirtualAccountChannel.bri:
        return 'BRI';
      case VirtualAccountChannel.bni:
        return 'BNI';
      case VirtualAccountChannel.mandiri:
        return 'MANDIRI';
      // Uncomment this block if you want to add BSI payment instructions
      // case VirtualAccountChannel.bsi:
      //   return 'BSI';
      case VirtualAccountChannel.bjb:
        return 'BJB';
      case VirtualAccountChannel.cimb:
        return 'CIMB';
      case VirtualAccountChannel.sahabatSampoerna:
        return 'SAHABAT_SAMPOERNA';
    }
  }
}
