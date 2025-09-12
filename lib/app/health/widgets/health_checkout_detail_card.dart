import 'package:flutter/material.dart';

import 'package:travelsya/app/health/models/health_model.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class HealthCheckoutDetailCard extends StatelessWidget {
  final HealthDetailModel dataDetail;
  final HealthPackageModel dataPackage;

  const HealthCheckoutDetailCard({
    super.key,
    required this.dataDetail,
    required this.dataPackage,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: neutral50.withOpacity(0.3)),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white),
            alignment: Alignment.topRight,
            child: SizedBox(
              width: 45,
              height: 45,
              child: Image.asset(
                'assets/icons/group_23.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(margin16),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dataDetail.name,
                style: mainBody4.copyWith(
                  color: neutral100,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                dataPackage.name,
                style:
                    mainBody5.copyWith(color: Theme.of(context).primaryColor),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                moneyChanger(dataPackage.price, customLabel: 'Rp'),
                style: mainBody4.copyWith(fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: margin24 / 2),
                width: double.infinity,
                height: 1,
                color: neutral50.withOpacity(0.3),
              ),
              Row(
                children: [
                  Text(
                    'Deskripsi',
                    style: mainBody4.copyWith(
                        fontWeight: FontWeight.bold, color: neutral100),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    'Reflexology 30 menit',
                    style: mainBody4.copyWith(
                        fontWeight: FontWeight.w600, color: primaryColor),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse nisl justo, imperdiet ut metus sit amet, semper molestie quam. Pellentesque molestie ante tempus mauris tincidunt, sed elementum massa venenatis. Duis facilisis urna massa, ut varius nibh viverra in. ',
                style: secondaryBody5.copyWith(color: neutral100),
              )
            ],
          ),
        )
      ],
    );
  }
}
