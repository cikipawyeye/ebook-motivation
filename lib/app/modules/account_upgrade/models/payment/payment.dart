import 'package:ebookapp/app/data/enum/option.dart';
import 'package:ebookapp/app/modules/account_upgrade/models/payment/payment_method.dart';

class Payment {
  final PaymentStatus status;
  final PaymentMethod paymentMethod;
  final List<dynamic>? requiredActions;

  Payment({
    required this.status,
    required this.paymentMethod,
    this.requiredActions,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      status: PaymentStatus.values.firstWhere(
        (e) => e.value == json['status'],
        orElse: () => PaymentStatus.unknown,
      ),
      paymentMethod: PaymentMethod.fromJson(
          json['payment_method'] as Map<String, dynamic>),
      requiredActions: json['required_actions'] as List<dynamic>?,
    );
  }
}

enum PaymentStatus implements Option {
  pending,
  requiresAction,
  canceled,
  succeeded,
  failed,
  voided,
  unknown,
  awaitingCapture,
  expired;

  @override
  String get label {
    switch (this) {
      case PaymentStatus.pending:
        return 'Pending';
      case PaymentStatus.requiresAction:
        return 'Requires Action';
      case PaymentStatus.canceled:
        return 'Canceled';
      case PaymentStatus.succeeded:
        return 'Succeeded';
      case PaymentStatus.failed:
        return 'Failed';
      case PaymentStatus.voided:
        return 'Voided';
      case PaymentStatus.unknown:
        return 'Unknown';
      case PaymentStatus.awaitingCapture:
        return 'Awaiting Capture';
      case PaymentStatus.expired:
        return 'Expired';
    }
  }

  @override
  String get value {
    switch (this) {
      case PaymentStatus.pending:
        return 'PENDING';
      case PaymentStatus.requiresAction:
        return 'REQUIRES_ACTION';
      case PaymentStatus.canceled:
        return 'CANCELED';
      case PaymentStatus.succeeded:
        return 'SUCCEEDED';
      case PaymentStatus.failed:
        return 'FAILED';
      case PaymentStatus.voided:
        return 'VOIDED';
      case PaymentStatus.unknown:
        return 'UNKNOWN';
      case PaymentStatus.awaitingCapture:
        return 'AWAITING_CAPTURE';
      case PaymentStatus.expired:
        return 'EXPIRED';
    }
  }
}
