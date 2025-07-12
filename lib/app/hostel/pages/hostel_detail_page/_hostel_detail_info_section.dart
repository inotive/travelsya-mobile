part of 'hostel_detail_page.dart';

class _HostelDetailInfoSection extends StatelessWidget {
  final HostelDetailModel data;
  final HostelDetailVM model;
  final String id;

  const _HostelDetailInfoSection(
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
                                      images: model.dataAllImage(data))));
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
                height: margin8,
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
                        fontSize: 15,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    ' (${data.ratingCount})',
                    style: mainFont.copyWith(
                        fontSize: 13, color: const Color(0xffa5a5a5)),
                  ),
                  SizedBox(
                    width: margin4,
                  ),
                  Text(
                    data.location,
                    style: mainFont.copyWith(
                        fontSize: 14,
                        color: Theme.of(context).primaryColor,
                        decoration: TextDecoration.underline),
                  )
                ],
              ),
              SizedBox(
                height: margin16,
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 8,
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
