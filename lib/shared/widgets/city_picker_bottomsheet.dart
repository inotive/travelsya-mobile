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
      );
    },
  );
}

class CityPickerBottomsheet<TItem, TCubit extends Cubit<TState>, TState>
    extends StatefulWidget {
  final TCubit cubit;
  final Future<void> Function(TCubit cubit, BuildContext ctx) fetchFunction;
  final bool Function(TState state) isLoading;
  final List<TItem> Function(TState state)? getCities;
  final String Function(TItem item) displayName;

  const CityPickerBottomsheet({
    super.key,
    required this.cubit,
    required this.fetchFunction,
    required this.isLoading,
    this.getCities,
    required this.displayName,
  });

  @override
  State<CityPickerBottomsheet<TItem, TCubit, TState>> createState() =>
      _CityPickerBottomsheetState<TItem, TCubit, TState>();
}

enum CityPickerType { hotel, bus, recreation, health }

class _CityPickerBottomsheetState<TItem, TCubit extends Cubit<TState>, TState>
    extends State<CityPickerBottomsheet<TItem, TCubit, TState>> {
  @override
  void initState() {
    super.initState();
    widget.fetchFunction(widget.cubit, context);
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
              final cities = widget.getCities?.call(state) ?? [];
              if (cities.isEmpty) {
                return const Center(child: Text("Kota tidak tersedia"));
              }
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  final item = cities[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context, item);
                      // Navigator.pop(context, widget.displayName(item));
                    },
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
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
