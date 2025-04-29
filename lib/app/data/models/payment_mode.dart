import 'package:ebookapp/app/data/enum/option.dart';

class PaymentResponse {
  final PaymentData data;
  final int paymentId;

  PaymentResponse({
    required this.data,
    required this.paymentId,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      data: PaymentData.fromJson(json['data']),
      paymentId: json['payment_id'] ?? 0,
    );
  }
}

class PaymentData {
  final String status;
  final List<String> requiredActions;
  final PaymentMethod paymentMethod;

  PaymentData({
    required this.status,
    required this.requiredActions,
    required this.paymentMethod,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      status: json['status'] ?? '',
      requiredActions: (json['required_actions'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      paymentMethod: PaymentMethod.fromJson(json['payment_method']),
    );
  }
}

class PaymentMethod {
  final String type;
  final dynamic ewallet;
  final dynamic overTheCounter;
  final dynamic qrCode;
  final VirtualAccount? virtualAccount;

  PaymentMethod({
    required this.type,
    this.ewallet,
    this.overTheCounter,
    this.qrCode,
    this.virtualAccount,
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      type: json['type'] ?? '',
      ewallet: json['ewallet'],
      overTheCounter: json['over_the_counter'],
      qrCode: json['qr_code'],
      virtualAccount: json['virtual_account'] != null
          ? VirtualAccount.fromJson(json['virtual_account'])
          : null,
    );
  }
}

class VirtualAccount {
  final double? minAmount;
  final double? maxAmount;
  final double amount;
  final String currency;
  final String channelCode;
  final ChannelProperties channelProperties;

  VirtualAccount({
    this.minAmount,
    this.maxAmount,
    required this.amount,
    required this.currency,
    required this.channelCode,
    required this.channelProperties,
  });

  factory VirtualAccount.fromJson(Map<String, dynamic> json) {
    return VirtualAccount(
      minAmount: json['min_amount']?.toDouble(),
      maxAmount: json['max_amount']?.toDouble(),
      amount: json['amount']?.toDouble() ?? 0.0,
      currency: json['currency'] ?? '',
      channelCode: json['channel_code'] ?? '',
      channelProperties: ChannelProperties.fromJson(json['channel_properties']),
    );
  }
}

class ChannelProperties {
  final String customerName;
  final String virtualAccountNumber;
  final String expiresAt;

  ChannelProperties({
    required this.customerName,
    required this.virtualAccountNumber,
    required this.expiresAt,
  });

  factory ChannelProperties.fromJson(Map<String, dynamic> json) {
    return ChannelProperties(
      customerName: json['customer_name'] ?? '',
      virtualAccountNumber: json['virtual_account_number'] ?? '',
      expiresAt: json['expires_at'] ?? '',
    );
  }
}
