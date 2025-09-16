import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';

Future<TItem?> showCityPicker<TItem, TCubit extends Cubit<TState>, TState>(
  BuildContext context, {
  required TCubit cubit,
  required Future<void> Function(TCubit cubit, BuildContext ctx) fetchFunction,
  required bool Function(TState state) isLoading,
  required List<TItem> Function(TState state)? getCities,
  required String Function(TItem item) displayName,
  bool enableSearch = false,
  bool includeAllLocation = false,
  String allLocationLabel = "Semua Lokasi",
}) {
  return showModalBottomSheet<TItem>(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
    ),
    builder: (context) {
      return CityPickerBottomsheet<TItem, TCubit, TState>(
        cubit: cubit,
        fetchFunction: fetchFunction,
        isLoading: isLoading,
        getCities: getCities,
        displayName: displayName,
        enableSearch: enableSearch,
        includeAllLocation: includeAllLocation,
        allLocationLabel: allLocationLabel,
      );
    },
  );
}

Future<TItem?>
    showSearchCityPicker<TItem, TCubit extends Cubit<TState>, TState>(
  BuildContext context, {
  required TCubit cubit,
  required Future<void> Function(TCubit cubit, BuildContext ctx) fetchFunction,
  required bool Function(TState state) isLoading,
  required List<TItem> Function(TState state)? getCities,
  required String Function(TItem item) displayName,
  String allLocationLabel = "Semua Lokasi",
}) {
  return showCityPicker<TItem, TCubit, TState>(
    context,
    cubit: cubit,
    fetchFunction: fetchFunction,
    isLoading: isLoading,
    getCities: getCities,
    displayName: displayName,
    enableSearch: true,
    includeAllLocation: true,
    allLocationLabel: allLocationLabel,
  );
}

class CityPickerBottomsheet<TItem, TCubit extends Cubit<TState>, TState>
    extends StatefulWidget {
  final TCubit cubit;
  final Future<void> Function(TCubit cubit, BuildContext ctx) fetchFunction;
  final bool Function(TState state) isLoading;
  final List<TItem> Function(TState state)? getCities;
  final String Function(TItem item) displayName;
  final bool enableSearch;
  final bool includeAllLocation;
  final String allLocationLabel;

  const CityPickerBottomsheet({
    super.key,
    required this.cubit,
    required this.fetchFunction,
    required this.isLoading,
    this.getCities,
    required this.displayName,
    required this.enableSearch,
    required this.includeAllLocation,
    required this.allLocationLabel,
  });

  @override
  State<CityPickerBottomsheet<TItem, TCubit, TState>> createState() =>
      _CityPickerBottomsheetState<TItem, TCubit, TState>();
}

enum CityPickerType { hotel, bus, recreation, health }

class _CityPickerBottomsheetState<TItem, TCubit extends Cubit<TState>, TState>
    extends State<CityPickerBottomsheet<TItem, TCubit, TState>> {
  final TextEditingController _searchController = TextEditingController();
  String _query = "";

  @override
  void initState() {
    super.initState();
    widget.fetchFunction(widget.cubit, context);

    _searchController.addListener(() {
      setState(() {
        _query = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: margin16, vertical: margin8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pilih Kota',
                style: mainFont.copyWith(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(
                  context,
                ),
                child: const Icon(Icons.close, color: Colors.black87),
              ),
            ],
          ),
        ),
        if (widget.enableSearch)
          Padding(
            padding: EdgeInsetsGeometry.symmetric(
                horizontal: margin16, vertical: margin8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                  hintText: 'Cari Kota',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  isDense: true),
            ),
          ),
        Expanded(
          child: BlocBuilder<TCubit, TState>(
            bloc: widget.cubit,
            builder: (context, state) {
              if (widget.isLoading(state)) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                );
              }
              List<TItem> cities = widget.getCities?.call(state) ?? [];
              if (_query.isNotEmpty) {
                cities = cities
                    .where((item) =>
                        widget.displayName(item).toLowerCase().contains(_query))
                    .toList();
              }

              // final cities = widget.getCities?.call(state) ?? [];
              if (cities.isEmpty && !widget.includeAllLocation) {
                return const Center(child: Text("Kota tidak tersedia"));
              }
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: cities.length + (widget.includeAllLocation ? 1 : 0),
                itemBuilder: (context, index) {
                  if (widget.includeAllLocation && index == 0) {
                    return GestureDetector(
                      onTap: () =>
                          Navigator.pop(context, null), // null utk semua lokasi
                      child: Container(
                        padding: EdgeInsets.all(margin16),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black12),
                          ),
                        ),
                        child: Text(
                          widget.allLocationLabel,
                          style: mainBody4.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }
                  final item =
                      cities[index - (widget.includeAllLocation ? 1 : 0)];
                  return GestureDetector(
                    onTap: () => Navigator.pop(context, item),
                    child: Container(
                      padding: EdgeInsets.all(margin16),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.black12),
                        ),
                      ),
                      child: Text(
                        widget.displayName(item),
                        style: mainBody4.copyWith(color: Colors.black87),
                      ),
                    ),
                  );
                  // final item = cities[index];
                  // return GestureDetector(
                  //   onTap: () {
                  //     Navigator.pop(context, item);
                  //     // Navigator.pop(context, widget.displayName(item));
                  //   },
                  //   child: Container(
                  //     padding: EdgeInsets.all(margin16),
                  //     decoration: const BoxDecoration(
                  //       border: Border(
                  //         bottom: BorderSide(color: Colors.black12),
                  //       ),
                  //     ),
                  //     child: Text(
                  //       widget.displayName(item),
                  //       style: mainBody4.copyWith(color: Colors.black87),
                  //     ),
                  //   ),
                  // );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
