// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:travelsya/app/health/cubits/health_city_cubit.dart';
// import 'package:travelsya/app/health/models/health_model.dart';
// import 'package:travelsya/app/health/pages/health_search_result_page.dart';
// import 'package:travelsya/app/health/pages/tabs/health_tab.dart';
// import 'package:travelsya/app/health/pages/tabs/beauty_tab.dart';
// import 'package:travelsya/app/health/pages/tabs/spa_tab.dart';
// import 'package:travelsya/shared/widgets/city_picker_bottomsheet.dart';
// import 'package:travelsya/shared/widgets/date_picker_single.dart';
// import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';
// import 'package:travelsya/shared/styles/font_style.dart';
// import 'package:travelsya/shared/styles/size_styles.dart';

// class HealthSearchPage extends StatefulWidget {
//   const HealthSearchPage({super.key});

//   @override
//   State<HealthSearchPage> createState() => _HealthSearchPageState();
// }

// class _HealthSearchPageState extends State<HealthSearchPage> {
//   HealthCityModel? selectedCity;
//   DateTime? selectedDate;

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => HealthCityCubit(),
//       child: DefaultTabController(
//         length: 3,
//         child: Scaffold(
//           body: Column(
//             children: [
//               // ===== HEADER =====
//               Stack(
//                 children: [
//                   Container(
//                     width: double.infinity,
//                     height: 200,
//                     decoration: const BoxDecoration(
//                       image: DecorationImage(
//                         fit: BoxFit.cover,
//                         image: AssetImage('assets/new/health_beauty.png'),
//                       ),
//                     ),
//                     child: Container(color: Colors.black45),
//                   ),
//                   Positioned(
//                     left: margin16,
//                     top: MediaQuery.of(context).padding.top + margin24,
//                     child: GestureDetector(
//                       onTap: () => Navigator.pop(context),
//                       child: const CircleAvatar(
//                         backgroundColor: Colors.white,
//                         child: Icon(Icons.arrow_back),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 0,
//                     left: 0,
//                     right: 0,
//                     child: Container(
//                       height: 20,
//                       decoration: const BoxDecoration(
//                         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               // ===== TABBAR =====
//               const TabBar(
//                 indicatorColor: Colors.blue,
//                 labelColor: Colors.blue,
//                 unselectedLabelColor: Colors.grey,
//                 tabs: [
//                   Tab(text: "Health"),
//                   Tab(text: "Beauty"),
//                   Tab(text: "Spa & Kecantikan"),
//                 ],
//               ),

//               // ===== SEARCH + DATE =====
//               Expanded(
//                 child: TabBarView(
//                   children: [
//                     _buildCommonFilter(context, isHealth: true),
//                     _buildCommonFilter(context, isHealth: false),
//                     _buildCommonFilter(context, isHealth: false, isSpa: true),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCommonFilter(BuildContext context,
//       {required bool isHealth, bool isSpa = false}) {
//     return ListView(
//       padding: EdgeInsets.all(margin16),
//       children: [
//         // Lokasi
//         GestureDetector(
//           onTap: () async {
//             final result = await showCityPicker<HealthCityModel,
//                 HealthCityCubit, HealthCityState>(
//               context,
//               cubit: context.read<HealthCityCubit>(),
//               fetchFunction: (cubit, ctx) => cubit.fetchCities(ctx),
//               isLoading: (state) => state is HealthCityLoading,
//               getCities: (state) =>
//                   state is HealthCityLoaded ? state.cities : [],
//               displayName: (city) => city.name,
//             );

//             if (result != null) {
//               setState(() {
//                 selectedCity = result;
//               });
//             }
//           },
//           child: Container(
//             padding: EdgeInsets.symmetric(vertical: 14, horizontal: margin16),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: const Color(0xffa5a5a5)),
//             ),
//             child: Row(
//               children: [
//                 const Icon(Icons.location_city, color: Colors.grey),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Text(
//                     selectedCity?.name ?? "Semua Lokasi",
//                     style: mainBody5.copyWith(
//                       color: selectedCity == null
//                           ? const Color(0xffa5a5a5)
//                           : Colors.black87,
//                     ),
//                   ),
//                 ),
//                 const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(height: margin16),

//         // Tanggal reservasi
//         GestureDetector(
//           onTap: () async {
//             final selected = await showDialog(
//               context: context,
//               builder: (_) => DateSinglePicker(
//                 selectedDate: selectedDate,
//                 minDate: DateTime.now(),
//               ),
//             );
//             if (selected != null) {
//               setState(() => selectedDate = selected);
//             }
//           },
//           child: Container(
//             padding: EdgeInsets.symmetric(vertical: 14, horizontal: margin16),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: const Color(0xffa5a5a5)),
//             ),
//             child: Row(
//               children: [
//                 const Icon(Icons.date_range, color: Colors.grey),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Text(
//                     selectedDate != null
//                         ? DateFormat('dd MMM yyyy').format(selectedDate!)
//                         : 'Tanggal reservasi',
//                     style: mainBody5.copyWith(
//                         color: const Color(0xffa5a5a5)),
//                   ),
//                 ),
//                 const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
//               ],
//             ),
//           ),
//         ),
//         SizedBox(height: margin16),

//         // Tombol Cari
//         ElevatedButtonWidget(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => HealthSearchResultPage(
//                   isHealth: isHealth,
//                   city: selectedCity?.name,
//                 ),
//               ),
//             );
//           },
//           title: 'Cari Sekarang',
//         ),
//         SizedBox(height: margin16),

//         // ===== KONTEN TAB =====
//         if (isHealth) const HealthTab(),
//         if (!isHealth && !isSpa) const BeautyTab(),
//         if (isSpa) const SpaTab(),
//       ],
//     );
//   }
// }
