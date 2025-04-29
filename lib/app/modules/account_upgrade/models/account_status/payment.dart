import 'package:ebookapp/app/data/enum/option.dart';

class Payment {
  final int id;
  final PaymentState state;
  final int amount;

  Payment({
    required this.id,
    required this.state,
    required this.amount,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      id: json['id'] ?? 0,
      state: PaymentState.values.firstWhere(
        (e) => e.value == json['state'],
        orElse: () => PaymentState.pending,
      ),
      amount: json['amount'] ?? 0,
    );
  }
}

enum PaymentState implements Option {
  pending,
  succeeded,
  failed;

  @override
  String get label {
    switch (this) {
      case PaymentState.pending:
        return 'Pending';
      case PaymentState.succeeded:
        return 'Succeeded';
      case PaymentState.failed:
        return 'Failed';
    }
  }

  @override
  String get value {
    switch (this) {
      case PaymentState.pending:
        return 'PENDING';
      case PaymentState.succeeded:
        return 'SUCCEEDED';
      case PaymentState.failed:
        return 'FAILED';
    }
  }
}
