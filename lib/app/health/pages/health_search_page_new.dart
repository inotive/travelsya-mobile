import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/health/cubits/health_cubit.dart';
import 'package:travelsya/app/health/cubits/health_state.dart';
import 'package:travelsya/app/health/models/health_model.dart';
import 'package:travelsya/app/health/pages/health_detail_page.dart';
import 'package:travelsya/app/health/pages/health_search_result_page.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/city_picker_bottomsheet.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';

class HealthSearchPageNew extends StatefulWidget {
  const HealthSearchPageNew({super.key});

  @override
  State<HealthSearchPageNew> createState() => _HealthSearchPageNewState();
}

class _HealthSearchPageNewState extends State<HealthSearchPageNew> {
  String? selectedCity;

  final healthHomeCubit = HealthCubit();
  final beautyHomeCubit = HealthCubit();
  final healthBeautyCubit = HealthCubit();

  @override
  void initState() {
    super.initState();
    healthHomeCubit.fetchHealthCategory(context);
    beautyHomeCubit.fetchHealthCategory(context, isHealth: false);
    healthBeautyCubit.fetchHealthBeautyHome(context);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildHeader(context),

            // TabBar
            Container(
              margin: EdgeInsets.symmetric(horizontal: margin16),
              child: TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: const Color(0xffa5a5a5),
                labelStyle: mainBody4.copyWith(fontWeight: FontWeight.bold),
                unselectedLabelStyle: mainBody4,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                      width: 2.0, color: Theme.of(context).primaryColor),
                ),
                tabs: const [
                  Tab(text: "Health"),
                  Tab(text: "Beauty"),
                  Tab(text: "Spa & Kecantikan"),
                ],
              ),
            ),

            SizedBox(height: margin16),

            // City picker
            Container(
              margin: EdgeInsets.symmetric(horizontal: margin16),
              child: GestureDetector(
                onTap: () async {
                  String? result = await showCityPicker(context);
                  if (result != null) setState(() => selectedCity = result);
                },
                child: FormHelper.dropdownForm(
                  context,
                  data: selectedCity ?? 'Semua Lokasi',
                  hintText: 'Kota Reservasi',
                ),
              ),
            ),

            SizedBox(height: margin16),

            // Cari sekarang
            Container(
              margin: EdgeInsets.symmetric(horizontal: margin16),
              child: ElevatedButtonWidget(
                onTap: () {
                  final tabIndex = DefaultTabController.of(context).index;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HealthSearchResultPage(
                        isHealth: tabIndex == 0,
                      ),
                    ),
                  );
                },
                title: 'Cari Sekarang',
              ),
            ),

            SizedBox(height: margin16),

            // TabBarView konten
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: TabBarView(
                children: [
                  _buildHealthTab(context, healthHomeCubit, true), // Health
                  _buildHealthTab(context, beautyHomeCubit, false), // Beauty
                  _buildSpaTab(context), // Spa
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================================
  // HEADER
  Widget _buildHeader(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/new/health_beauty.png'),
            ),
          ),
          child: Container(color: Colors.black45),
        ),
        Positioned(
          left: margin16,
          top: MediaQuery.of(context).padding.top + margin24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 37,
                  height: 37,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 16,
                    height: 16,
                    child: Image.asset('assets/new/back.png'),
                  ),
                ),
              ),
              SizedBox(height: margin48),
              Text(
                'Health & Beauty',
                style: mainBody3.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 20,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  // ================================
  // TAB HEALTH / BEAUTY
  Widget _buildHealthTab(
      BuildContext context, HealthCubit cubit, bool isHealth) {
    return BlocBuilder<HealthCubit, HealthState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is HealthLoading) {
          return Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor),
          );
        } else if (state is HealthHomeLoaded) {
          return ListView(
            children: [
              _buildSpecialDeals(context, state.specialDeal, isHealth),
              SizedBox(height: margin16),
              _buildCategories(context, state.category),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }

  // ================================
  // TAB SPA
  Widget _buildSpaTab(BuildContext context) {
    return BlocBuilder<HealthCubit, HealthState>(
      bloc: healthBeautyCubit,
      builder: (context, state) {
        if (state is HealthLoading) {
          return Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor),
          );
        } else if (state is HealthBeautyHomeLoaded) {
          return ListView(
            children: [
              _buildProductGrid(context, state.beauty, false),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }

  // ================================
  // SPECIAL DEALS
  Widget _buildSpecialDeals(
      BuildContext context, List<HealthPreviewModel> deals, bool isHealth) {
    if (deals.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: margin16),
          child: Row(
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Image.asset('assets/new/deals.png'),
              ),
              SizedBox(width: margin8),
              Expanded(
                child: Text(
                  'Special Deals',
                  style: mainBody4.copyWith(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: margin8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(deals.length, (index) {
              final data = deals[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HealthDetailPage(
                        isHealth: isHealth,
                        id: data.id.toString(),
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(left: margin16),
                  width: 160,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        child: Image.network(
                          data.image,
                          width: 160,
                          height: 90,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.broken_image, size: 50),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(margin8),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: mainBody4.copyWith(
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: margin4),
                            Text(
                              moneyChanger(data.price, customLabel: 'IDR '),
                              style: mainBody5.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  // ================================
  // CATEGORIES
  Widget _buildCategories(
      BuildContext context, List<HealthCategoryModel> categories) {
    if (categories.isEmpty) return const SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: margin16),
          child: Text(
            'Kategori',
            style: mainBody3.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: margin8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(categories.length, (index) {
              return Container(
                width: 140,
                height: 70,
                margin: EdgeInsets.only(
                  left: index == 0 ? margin16 : margin8,
                  right: index == categories.length - 1 ? margin16 : 0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/new/deals_image.jpg'),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  categories[index].name,
                  style: mainBody5.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  // ================================
  // PRODUCT GRID (SPA)
  Widget _buildProductGrid(
      BuildContext context, List<HealthPreviewModel> items, bool isHealth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: margin16),
      child: Wrap(
        spacing: margin8,
        runSpacing: margin8,
        children: List.generate(items.length, (index) {
          final item = items[index];
          return SizedBox(
            width: (MediaQuery.of(context).size.width - margin32) / 2,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HealthDetailPage(
                      isHealth: isHealth,
                      id: item.id.toString(),
                    ),
                  ),
                );
              },
              child: Card(
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 167 / 100,
                      child: Image.network(
                        item.image,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.broken_image, size: 50),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(margin8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: mainBody4.copyWith(
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: margin4),
                          Text(
                            moneyChanger(item.price, customLabel: 'IDR '),
                            style: mainBody5.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
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
    );
  }
}
