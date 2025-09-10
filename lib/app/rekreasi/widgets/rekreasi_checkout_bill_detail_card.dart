import 'package:flutter/material.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class RekreasiCheckoutBillDetailCard extends StatelessWidget {
  const RekreasiCheckoutBillDetailCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detail Tagihan',
            style: mainBody2.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: margin16,
          ),
          _billCard(
              title: 'Meiso Kelapa Gading',
              subtitle: '1 x Reflexology 30 menit',
              price: '130.500'),
          const SizedBox(
            height: 10,
          ),
          _billCard(
              title: 'Meiso Kelapa Gading',
              subtitle: '1 x Reflexology 60 menit',
              price: '230.500'),
          const SizedBox(
            height: 10,
          ),
          _summaryRow(label: 'Admin (1.0%)', price: '3.610'),
          const SizedBox(
            height: 10,
          ),
          _summaryRow(label: 'Kode Unit', price: '1.000'),
        ],
      ),
    );
  }

  Widget _billCard({
    required String title,
    required String subtitle,
    required String price,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: mainBody4,
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              subtitle,
              style: secondaryBody5.copyWith(color: neutral60),
            )
          ],
        ),
        Text(
          'Rp$price',
          style: secondaryBody4.copyWith(
              color: primaryColor, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Widget _summaryRow({required String label, required String price}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: mainBody4,
        ),
        Text(
          'Rp$price',
          style: mainBody4.copyWith(color: primaryColor),
        )
      ],
    );
  }
}
