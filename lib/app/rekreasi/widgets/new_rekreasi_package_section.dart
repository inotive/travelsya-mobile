import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/rekreasi/cubits/quantity_cubit.dart';
import 'package:travelsya/app/rekreasi/models/recreation_model.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class NewRekreasiPackageSection extends StatelessWidget {
  final List<RecreationPackageModel> data;
  final RecreationDetailModel dataDetail;

  const NewRekreasiPackageSection({
    super.key,
    required this.data,
    required this.dataDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          padding:
              EdgeInsets.only(top: margin16, left: margin16, right: margin16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Paket Tersedia',
                style: mainBody4.copyWith(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: margin16),

        // List Package
        Container(
          padding: EdgeInsets.symmetric(horizontal: margin16),
          child: Column(
            children: List.generate(data.length, (index) {
              final package = data[index];
              return _PackageCard(
                package: package,
                dataDetail: dataDetail,
              );
            }),
          ),
        ),
      ],
    );
  }
}

class _PackageCard extends StatelessWidget {
  final RecreationPackageModel package;
  final RecreationDetailModel dataDetail;

  const _PackageCard({
    required this.package,
    required this.dataDetail,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuantityManagerCubit, Map<String, int>>(
      builder: (context, state) {
        final qty = state[package.id.toString()] ?? 0;

        return Container(
          padding: EdgeInsets.all(margin16),
          margin: EdgeInsets.only(bottom: margin24 / 2),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: neutral50.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(package.name,
                  style: mainBody4.copyWith(
                    color: neutral100,
                    fontWeight: FontWeight.bold,
                  )),
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
                children: [
                  Expanded(
                    child: Column(
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
                                  // package.price * qty,
                                  customLabel: 'IDR ',
                                ),
                                style: mainBody4.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
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
                  ),
                  InkWell(
                    onTap: () {
                      if (qty > 0) {
                        context
                            .read<QuantityManagerCubit>()
                            .updateQty(package.id.toString(), qty - 1);
                      }
                    },
                    child: const Icon(Icons.remove, size: 20),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: const Color(0XFF8F8F8F).withOpacity(0.25),
                    ),
                    child: Text('$qty',
                        style: mainBody4.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      context
                          .read<QuantityManagerCubit>()
                          .updateQty(package.id.toString(), qty + 1);
                    },
                    child: const Icon(Icons.add, size: 20),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
