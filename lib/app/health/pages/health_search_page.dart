import 'package:flutter/material.dart';
import 'package:travelsya/app/health/pages/health_detail_page.dart';
import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';

class HealthSearchPage extends StatefulWidget {
  const HealthSearchPage({super.key});

  @override
  State<HealthSearchPage> createState() => _HealthSearchPageState();
}

class _HealthSearchPageState extends State<HealthSearchPage> {
  List<String> dataFilter = [
    'Health',
    'Beauty',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.topCenter,
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          'assets/images/health_illustration.jpeg'))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Health & Beauty',
                    style: mainBody3.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Cantik Sehat, Hidup Lebih Bahagia',
                    style: mainBody4.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: margin24,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: margin16,
            top: MediaQuery.of(context).padding.top + margin16,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 45,
                height: 45,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          Positioned(
            top: 180,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24))),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  SizedBox(
                    height: margin16,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: margin16),
                    child: Column(
                      children: [
                        FormHelper.dropdownForm(context,
                            hintText: 'Cari..', customIcons: Icons.search),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: margin16,
                  ),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: margin16),
                          child: Text(
                            'Apa yang ingin kamu lakukan?',
                            style: mainBody3.copyWith(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: margin24 / 2,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(dataFilter.length, (index) {
                              return Container(
                                margin: EdgeInsets.only(
                                    left: index == 0 ? margin16 : margin4,
                                    right: index == 9 ? margin16 : 0),
                                padding: EdgeInsets.symmetric(
                                    vertical: margin4, horizontal: margin16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: index == 0
                                        ? const Color(0xffFFEEF1)
                                        : Colors.transparent,
                                    border: Border.all(
                                        color: index == 0
                                            ? Theme.of(context).primaryColor
                                            : const Color(0xffA5A5A5))),
                                child: Text(
                                  dataFilter[index],
                                  style: mainBody4.copyWith(
                                      color: index == 0
                                          ? Theme.of(context).primaryColor
                                          : const Color(0xffA5A5A5)),
                                ),
                              );
                            }),
                          ),
                        ),
                        SizedBox(
                          height: margin16,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: margin16),
                          width: double.infinity,
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            children: List.generate(4, (index) {
                              return FractionallySizedBox(
                                widthFactor: 0.49,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const HealthDetailPage()));
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      children: [
                                        AspectRatio(
                                          aspectRatio: 167 / 100,
                                          child: Container(
                                            width: double.infinity,
                                            height: double.infinity,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(8),
                                                    topRight:
                                                        Radius.circular(8)),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: AssetImage(
                                                        ConstHelper
                                                            .helperPhoto))),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(margin24 / 2),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Martha Tilaar Salon & Day Spa',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: mainBody4.copyWith(
                                                    color: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                'Jakarta Utara',
                                                style: mainBody5.copyWith(
                                                    color: const Color(
                                                        0xffa5a5a5)),
                                              ),
                                              SizedBox(
                                                height: margin8,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'mulai dari ',
                                                    style: mainBody5.copyWith(
                                                        color: const Color(
                                                            0xffa5a5a5)),
                                                  ),
                                                  Text(
                                                    '500.000',
                                                    style: mainBody5.copyWith(
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                        color: const Color(
                                                            0xffa5a5a5)),
                                                  )
                                                ],
                                              ),
                                              Text(
                                                'IDR 400,500',
                                                style: mainBody4.copyWith(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: margin8),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                  SizedBox(
                                                    width: margin4,
                                                  ),
                                                  Text(
                                                    '4,8 ',
                                                    style: mainBody4.copyWith(
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    '(120)',
                                                    style: mainBody5.copyWith(
                                                      color: const Color(
                                                          0xffa5a5a5),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        SizedBox(
                          height: margin16,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: margin16),
                          child: FormHelper.borderButton(context,
                              onTap: () {}, title: 'Lihat Semua'),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: margin32,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
