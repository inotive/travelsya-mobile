part of 'hotel_detail_page.dart';

class _HotelDetailGeneralInfoSection extends StatelessWidget {
  final HotelDetailModel data;

  const _HotelDetailGeneralInfoSection({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(margin16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Info Umum',
                    style: mainBody3.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                    top: margin24 / 2,
                    bottom: margin8,
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(vertical: margin24 / 2),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xfff4f4f4)),
                            child: Column(
                              children: [
                                Text(
                                  'Check In',
                                  style: mainBody5.copyWith(
                                      color: const Color(0xffa5a5a5)),
                                ),
                                Text(
                                  data.checkIn,
                                  style: mainBody4.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: margin24 / 2),
                          height: double.infinity,
                          width: 1,
                          color: const Color(0xffa5a5a5),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(vertical: margin24 / 2),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xfff4f4f4)),
                            child: Column(
                              children: [
                                Text(
                                  'Check Out',
                                  style: mainBody5.copyWith(
                                      color: const Color(0xffa5a5a5)),
                                ),
                                Text(
                                  data.checkOut,
                                  style: mainBody4.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              data.rules.isEmpty
                  ? Container()
                  : Container(
                      margin: EdgeInsets.only(top: margin8),
                      child: Column(
                        children: List.generate(data.rules.length, (index) {
                          return Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(right: margin8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 20,
                                  child: Text(
                                    '${index + 1}.',
                                    style: mainBody4,
                                  ),
                                ),
                                Expanded(
                                    child: Text(
                                  data.rules[index].desc,
                                  style: mainBody4,
                                ))
                              ],
                            ),
                          );
                        }),
                      ),
                    )
            ],
          ),
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
