import 'package:flutter/material.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:intl/intl.dart';

class HealthCheckoutBillDetailCard extends StatelessWidget {
  final List<HealthBillItem> items;
  final double adminFeePercent;
  final double unikCode;

  const HealthCheckoutBillDetailCard({
    super.key,
    required this.items,
    this.adminFeePercent = 1.0,
    this.unikCode = 1000,
  });

  @override
  Widget build(BuildContext context) {
    double totalItemPrice =
        items.fold(0, (sum, item) => sum + (item.price * item.quantity));
    double adminFee = totalItemPrice * (adminFeePercent / 100);
    double total = totalItemPrice + adminFee + unikCode;

    final currencyFormat = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    );
    return Container(
      // padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detail Tagihan',
            style: mainBody2.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: margin16),
          ...items.map((item) => _billCard(
              title: item.title,
              subtitle: '${item.quantity} x ${item.subtitle}',
              price: item.price * item.quantity,
              format: currencyFormat)),
          const SizedBox(height: 10),
          _summaryRow(
              label: 'Admin ($adminFeePercent%)',
              price: adminFee,
              format: currencyFormat),
          const SizedBox(height: 10),
          _summaryRow(
              label: 'Kode Unik',
              price: unikCode.toDouble(),
              format: currencyFormat),
          const SizedBox(height: 10),
          _summaryRow(label: 'Total', price: total, format: currencyFormat),
        ],
      ),
    );
  }

  Widget _billCard({
    required String title,
    required String subtitle,
    required double price,
    required NumberFormat format,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: mainBody4),
            const SizedBox(height: 6),
            Text(subtitle, style: secondaryBody5.copyWith(color: neutral60))
          ],
        ),
        Text(
          format.format(price),
          // 'Rp${price.toStringAsFixed(0)}',
          style: secondaryBody4.copyWith(
              color: primaryColor, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget _summaryRow({
    required String label,
    required double price,
    required NumberFormat format,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: mainBody4),
        Text(
          format.format(price),
          // 'Rp${price.toStringAsFixed(0)}',
          style: mainBody4.copyWith(color: primaryColor),
        )
      ],
    );
  }
}

class HealthBillItem {
  final String title;
  final String subtitle;
  final double price;
  final int quantity;

  HealthBillItem({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.quantity,
  });
}
