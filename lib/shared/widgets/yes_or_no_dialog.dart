import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/app/hostel/cubits/hostel_cubit.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';

Future<bool> yesOrNoDialog(BuildContext context,
    {required String title,
    required String desc,
    String? customYes,
    double? customSizeYes,
    double? customSizeNo,
    String? customNo}) async {
  bool? result = await showDialog(
      context: context,
      builder: (context) {
        return Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black12,
            alignment: Alignment.center,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.all(margin16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: mainBody4.copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: margin24 / 2),
                    Text(desc, textAlign: TextAlign.center, style: mainBody5),
                    SizedBox(height: margin24 / 2),
                    Row(children: [
                      Flexible(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: double.infinity,
                              padding:
                                  EdgeInsets.symmetric(vertical: margin24 / 2),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor)),
                              child: Text(
                                customNo ?? 'Tidak',
                                style: mainFont.copyWith(
                                    fontSize: customSizeNo ?? 12.0.sp,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                      SizedBox(width: margin8),
                      Flexible(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context, true);
                            },
                            child: Container(
                              width: double.infinity,
                              padding:
                                  EdgeInsets.symmetric(vertical: margin24 / 2),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).primaryColor),
                              alignment: Alignment.center,
                              child: Text(
                                customYes ?? 'Ya',
                                style: mainFont.copyWith(
                                    fontSize: customSizeYes ?? 12.0.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                    ])
                  ],
                )));
      });

  return result != null;
}

Future<String?> modalBottomSheetWithSearch(BuildContext context,
    {required HostelCubit dataCubit, required String title}) async {
  List<Widget> listingDataWidget = [];
  int? returnValue;
  String searchValue = '';

  returnValue = await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      constraints: BoxConstraints(maxHeight: 90.0.h),
      isScrollControlled: true,
      builder: (context) {
        return DialogSearchCity(title: title, data: []);
      });
  return returnValue.toString();
}

class DialogSearchCity extends StatefulWidget {
  final String title;
  final List<String> data;
  const DialogSearchCity({Key? key, required this.data, required this.title})
      : super(key: key);

  @override
  State<DialogSearchCity> createState() => _DialogSearchCityState();
}

class _DialogSearchCityState extends State<DialogSearchCity> {
  String searchValue = '';
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            width: 100.0.w,
            height: 7.0.h,
            padding: EdgeInsets.symmetric(horizontal: margin16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title,
                    style: mainFont.copyWith(
                        fontSize: 12.0.sp,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold)),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close, color: Colors.black87))
              ],
            )),
        Container(
          color: Colors.white,
          margin: EdgeInsets.symmetric(
              vertical: margin24 / 2, horizontal: margin16),
          child: FormHelper.roundedTextfield(
            context,
            controller: controller,
            onChanged: (value) {
              setState(() {
                searchValue = value;
              });
            },
            prefixIcon: Icon(Icons.search),
            hintText: 'Cari ${widget.title}..',
          ),
        ),
        Expanded(
            child: ListView(
          children: List.generate(widget.data.length, (index) {
            bool isShow = widget.data[index]
                .toLowerCase()
                .contains(searchValue.toLowerCase());

            return isShow
                ? Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context, index);
                        },
                        child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(margin16),
                            width: 100.0.w,
                            child: Text(widget.data[index],
                                style: mainFont.copyWith(
                                    fontSize: 11.0.sp, color: Colors.black87))),
                      ),
                      Container(
                          width: 100.0.w, height: 0.3.w, color: Colors.black12)
                    ],
                  )
                : Container();
          }),
        ))
      ],
    );
  }
}

Future<dynamic> modalBottomSheet(BuildContext context,
    {required List<String> data,
    required String title,
    Widget? customWidget}) async {
  List<Widget> listingDataWidget = [];
  dynamic returnValue;

  for (var i = 0; i < data.length; i++) {
    listingDataWidget.add(Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context, i);
          },
          child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(margin16),
              width: 100.0.w,
              child: Text(data[i],
                  style: mainFont.copyWith(
                      fontSize: 11.0.sp, color: Colors.black87))),
        ),
        Container(width: 100.0.w, height: 0.3.w, color: Colors.black12)
      ],
    ));
  }

  returnValue = await showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (context) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                  width: 100.0.w,
                  height: 50.0.h,
                  padding: EdgeInsets.only(
                    top: 7.0.h,
                  ),
                  child: customWidget ??
                      ListView(
                        children: listingDataWidget,
                      )),
            ),
            Positioned(
                top: 0,
                child: Container(
                    width: 100.0.w,
                    height: 7.0.h,
                    padding: EdgeInsets.symmetric(horizontal: margin16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(title,
                            style: mainFont.copyWith(
                                fontSize: 12.0.sp,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold)),
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.close, color: Colors.black87))
                      ],
                    )))
          ],
        );
      });
  return returnValue;
}
