import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/rekreasi/cubits/quantity_cubit.dart';
import 'package:travelsya/app/rekreasi/models/recreation_model.dart';
import 'package:travelsya/app/rekreasi/widgets/rekreasi_rules_checkout_section.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class RekreasiCheckoutDetailCard extends StatelessWidget {
  final RecreationPackageModel package;
  final RecreationDetailModel dataDetail;

  const RekreasiCheckoutDetailCard({
    super.key,
    required this.package,
    required this.dataDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, top: 24),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: neutral50.withOpacity(0.3),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/icons/group_23.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    color: Colors.red.withOpacity(0.1),
                    colorBlendMode: BlendMode.srcATop,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(margin16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        package.name,
                        style: mainBody4.copyWith(
                          color: neutral100,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${package.isRefundable == 1 ? 'Bisa' : 'Tidak Bisa'} refund dan ${package.isRescheduleable == 1 ? 'Bisa' : 'Tidak Bisa'} reschedule',
                        style: mainBody5.copyWith(color: neutral50),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: margin24 / 2),
                        width: double.infinity,
                        height: 1,
                        color: neutral50.withOpacity(0.3),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: mainBody5.copyWith(color: neutral50),
                                  children: [
                                    const TextSpan(text: 'mulai '),
                                    TextSpan(
                                      text: moneyChanger(
                                        package.price,
                                        customLabel: 'IDR ',
                                      ),
                                      style: mainBody4.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '/orang (termasuk pajak)',
                                style: mainBody5.copyWith(color: neutral50),
                              ),
                            ],
                          ),
                          BlocBuilder<QuantityManagerCubit, Map<String, int>>(
                            builder: (context, state) {
                              final qty = context
                                  .read<QuantityManagerCubit>()
                                  .getQty(package.id.toString());
                              return Text(
                                'x$qty',
                                style:
                                    secondaryBody5.copyWith(color: neutral30),
                              );
                            },
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: margin24 / 2),
                        width: double.infinity,
                        height: 1,
                        color: neutral50.withOpacity(0.3),
                      ),
                      RekreasiRulesCheckoutSection(
                        package: package,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
