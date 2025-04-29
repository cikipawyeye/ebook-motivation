import 'package:ebookapp/app/data/enum/option.dart';
import 'package:ebookapp/app/modules/account_upgrade/models/account_status/payment.dart';

class AccountStatus {
  final AccountUpgradeStatus status;
  final Payment? payment;

  AccountStatus({
    required this.status,
    this.payment,
  });

  factory AccountStatus.fromJson(Map<String, dynamic> json) {
    return AccountStatus(
      status: AccountUpgradeStatus.values.firstWhere(
        (e) => e.value == json['status'],
        orElse: () => AccountUpgradeStatus.notPremium,
      ),
      payment:
          json['payment'] != null ? Payment.fromJson(json['payment']) : null,
    );
  }
}

enum AccountUpgradeStatus implements Option {
  premium,
  notPremium,
  pendingPayment;

  @override
  String get label {
    switch (this) {
      case AccountUpgradeStatus.premium:
        return 'Premium';
      case AccountUpgradeStatus.notPremium:
        return 'Not Premium';
      case AccountUpgradeStatus.pendingPayment:
        return 'Pending Payment';
    }
  }

  @override
  String get value {
    switch (this) {
      case AccountUpgradeStatus.premium:
        return 'PREMIUM';
      case AccountUpgradeStatus.notPremium:
        return 'NOT_PREMIUM';
      case AccountUpgradeStatus.pendingPayment:
        return 'PENDING_PAYMENT';
    }
  }
}
