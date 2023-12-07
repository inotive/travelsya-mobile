part of 'hotel_detail_page.dart';

class _HotelDetailRoomSection extends StatelessWidget {
  final HotelDetailModel data;

  const _HotelDetailRoomSection({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding:
              EdgeInsets.only(top: margin16, left: margin16, right: margin16),
          width: double.infinity,
          child: Text(
            'Tipe Kamar',
            style: mainBody3.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: margin16,
        ),
        data.room.isEmpty
            ? Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(bottom: margin8),
                child: Text(
                  'Data Tipe Kamar Tidak Ditemukan',
                  style: mainBody5.copyWith(
                      fontStyle: FontStyle.italic, color: neutral80),
                ),
              )
            : Column(
                children: List.generate(data.room.length, (index) {
                  List<Map<String, String>> dataFacility = [
                    {
                      'assets': 'assets/icons/users.png',
                      'title': '${data.room[index].guest} Tamu'
                    },
                    {
                      'assets': 'assets/icons/bed 1.png',
                      'title': data.room[index].bedType
                    },
                  ];
                  return Container(
                    margin: EdgeInsets.only(
                        bottom: margin24 / 2, left: margin16, right: margin16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: const Color(0xffa5a5a5).withOpacity(0.3))),
                    child: Column(
                      children: [
                        data.room[index].images.isEmpty
                            ? AspectRatio(
                                aspectRatio: 167 / 100,
                                child: SizedBox(
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: Image.asset(ConstHelper.logoIcon)),
                              )
                            : AspectRatio(
                                aspectRatio: 167 / 100,
                                child: CarouselSlider(
                                    items: List.generate(
                                        data.room[index].images.length,
                                        (index2) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      PhotoViewListPage(
                                                        images: data
                                                            .room[index].images,
                                                      )));
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(data
                                                      .room[index]
                                                      .images[index2]))),
                                        ),
                                      );
                                    }),
                                    options: CarouselOptions(
                                        viewportFraction: 1,
                                        height: double.infinity))),
                        Container(
                            padding: EdgeInsets.all(margin24 / 2),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.room[index].name,
                                    style: mainBody4.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xff333333)),
                                  ),
                                  Text(
                                    'Tidak bisa refund dan reschedule',
                                    style: mainBody5.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: neutral80,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: margin24 / 2),
                                    width: double.infinity,
                                    height: 1,
                                    color: neutral30.withOpacity(0.3),
                                  ),
                                  Column(
                                    children: List.generate(dataFacility.length,
                                        (index) {
                                      return Container(
                                        margin:
                                            EdgeInsets.only(bottom: margin4),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: margin16,
                                              height: margin16,
                                              child: Image.asset(
                                                  dataFacility[index]
                                                      ['assets']!),
                                            ),
                                            SizedBox(
                                              width: margin8,
                                            ),
                                            Expanded(
                                                child: Text(
                                              dataFacility[index]['title']!,
                                              style: mainBody4.copyWith(
                                                  color: neutral100,
                                                  fontWeight: FontWeight.w400),
                                            ))
                                          ],
                                        ),
                                      );
                                    }),
                                  ),
                                  SizedBox(
                                    height: margin24 / 2,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Column(
                                        children: [
                                          SizedBox(
                                            width: double.infinity,
                                            child: RichText(
                                                text: TextSpan(
                                                    style: mainBody5.copyWith(
                                                        color: neutral70),
                                                    children: [
                                                  const TextSpan(
                                                      text: 'mulai '),
                                                  TextSpan(
                                                      text: moneyChanger(
                                                          data.room[index]
                                                              .sellingPrice
                                                              .toDouble(),
                                                          customLabel: 'IDR '),
                                                      style: mainBody4.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor)),
                                                ])),
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              '/kamar/malam (termasuk pajak)',
                                              style: mainBody5.copyWith(
                                                  color: neutral70),
                                            ),
                                          )
                                        ],
                                      )),
                                      SizedBox(
                                        width: margin24 / 2,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          needLoginFeature(context, () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        HotelCheckoutPage(
                                                          data: data,
                                                          selectedRoom:
                                                              data.room[index],
                                                        )));
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: margin24 / 2,
                                              horizontal: margin16),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          child: Text(
                                            'Pesan',
                                            style: mainBody4.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ]))
                      ],
                    ),
                  );
                }),
              ),
        SizedBox(
          height: margin8,
        ),
        Container(
          width: double.infinity,
          height: 8,
          color: const Color(0xfff4f4f4),
        ),
      ],
    );
  }
}
