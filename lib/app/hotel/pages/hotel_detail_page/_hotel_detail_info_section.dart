part of 'hotel_detail_page.dart';

class _HotelDetailInfoSection extends StatelessWidget {
  final HotelDetailModel data;
  final HotelDetailVM model;
  final String id;

  const _HotelDetailInfoSection(
      {required this.data, required this.model, required this.id});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        model.dataAllImage(data).isEmpty
            ? AspectRatio(
                aspectRatio: 375 / 264,
                child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.asset(ConstHelper.logoIcon)),
              )
            : AspectRatio(
                aspectRatio: 375 / 265,
                child: CarouselSlider(
                    items:
                        List.generate(model.dataAllImage(data).length, (index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => PhotoViewListPage(
                                        images: model.dataAllImage(data),
                                      )));
                        },
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      model.dataAllImage(data)[index]))),
                        ),
                      );
                    }),
                    options: CarouselOptions(
                        viewportFraction: 1, height: double.infinity))),
        Container(
          padding: EdgeInsets.all(margin16),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: margin32,
                  height: margin32,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xffFFEEF1)),
                  child: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              SizedBox(
                width: margin24 / 2,
              ),
              GestureDetector(
                onTap: () {
                  showSnackbar(context,
                      data: 'Coming Soon',
                      colors: Theme.of(context).primaryColor);
                },
                child: Container(
                  width: margin32,
                  height: margin32,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xffFFEEF1)),
                  child: Icon(
                    Icons.share,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: margin16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.name,
                style: mainBody2.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 2.0.w,
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Theme.of(context).primaryColor,
                  ),
                  Text(
                    data.avgRating.toStringAsFixed(1),
                    style: mainFont.copyWith(
                        fontSize: 13.0.sp,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' (${data.ratingCount})',
                    style: mainFont.copyWith(
                        fontSize: 11.0.sp, color: const Color(0xffa5a5a5)),
                  ),
                  SizedBox(
                    width: 1.0.w,
                  ),
                  Text(
                    data.location,
                    style: mainFont.copyWith(
                        fontSize: 12.0.sp,
                        color: Theme.of(context).primaryColor,
                        decoration: TextDecoration.underline),
                  )
                ],
              ),
              SizedBox(
                height: 3.0.w,
              ),
              Container(
                padding: EdgeInsets.all(3.0.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xfff4f4f4)),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                                width: 6.0.w,
                                height: 6.0.w,
                                child: Image.asset(
                                    'assets/icons/Vector copy.png')),
                            SizedBox(
                              width: 2.0.w,
                            ),
                            Text(
                              '${model.searchFilter.roomCount} Kamar',
                              style: mainFont.copyWith(
                                  fontSize: 11.0.sp,
                                  color: const Color(0xff333333)),
                            ),
                            SizedBox(
                              width: 3.0.w,
                            ),
                            SizedBox(
                                width: 6.0.w,
                                height: 6.0.w,
                                child: Image.asset('assets/icons/users.png')),
                            SizedBox(
                              width: 2.0.w,
                            ),
                            Text(
                              '${model.searchFilter.guessCount} Tamu',
                              style: mainFont.copyWith(
                                  fontSize: 11.0.sp,
                                  color: const Color(0xff333333)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 1.0.w,
                        ),
                        Text(
                          '${dateToReadable(DateFormat('yyyy-MM-dd').format(model.searchFilter.selectedTime.startDate!))} - ${dateToReadable(DateFormat('yyyy-MM-dd').format(model.searchFilter.selectedTime.endDate!))} (${model.searchFilter.selectedTime.endDate!.difference(model.searchFilter.selectedTime.startDate!).inDays} Hari)',
                          style: mainFont.copyWith(
                              fontSize: 9.0.sp,
                              fontStyle: FontStyle.italic,
                              color: const Color(0xff333333)),
                        )
                      ],
                    )),
                    GestureDetector(
                      onTap: () {
                        model.onFilterChanged(context, id: id);
                      },
                      child: Text(
                        'Ubah',
                        style: mainFont.copyWith(
                            fontSize: 11.0.sp,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5.0.w,
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 2.0.w,
          color: const Color(0xfff4f4f4),
        ),
        // Container(
        //   width: 100.0.w,
        //   margin: EdgeInsets.only(top: 3.0.w),
        //   child: SizedBox(
        //       height: 8.0.w,
        //       child: model.tabWidgetDummy(context)),
        // ),
      ],
    );
  }
}
