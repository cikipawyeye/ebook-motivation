import 'package:ebookapp/app/data/enum/option.dart';

class QRCode {
  QRCodeChannel channelCode;
  QRCodeChannelProperties channelProperties;

  QRCode({
    required this.channelCode,
    required this.channelProperties,
  });

  factory QRCode.fromJson(Map<String, dynamic> json) {
    return QRCode(
      channelCode: QRCodeChannel.values
          .firstWhere((e) => e.value == json['channel_code']),
      channelProperties: QRCodeChannelProperties.fromJson(
          json['channel_properties'] as Map<String, dynamic>),
    );
  }
}

enum QRCodeChannel implements Option {
  qris;

  @override
  String get label {
    switch (this) {
      case QRCodeChannel.qris:
        return 'QRIS';
    }
  }

  @override
  String get value {
    switch (this) {
      case QRCodeChannel.qris:
        return 'QRIS';
    }
  }
}

class QRCodeChannelProperties {
  final String qrString;
  final DateTime? expiresAt;

  QRCodeChannelProperties({
    required this.qrString,
    this.expiresAt,
  });

  factory QRCodeChannelProperties.fromJson(Map<String, dynamic> json) {
    return QRCodeChannelProperties(
      qrString: json['qr_string'] as String,
      expiresAt: json['expires_at'] != null
          ? DateTime.parse(json['expires_at'] as String)
              .subtract(Duration(minutes: 10))
          : null,
    );
  }
}
