part of 'hostel_detail_page.dart';

class _HostelDetailReviewSection extends StatelessWidget {
  final HostelDetailModel data;
  final HostelDetailVM model;

  const _HostelDetailReviewSection({required this.data, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding:
              EdgeInsets.only(top: margin16, left: margin16, right: margin16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Review',
                    style: mainBody3.copyWith(
                        color: Colors.black87, fontWeight: FontWeight.bold),
                  ),
                  // data.reviews.isEmpty
                  //     ? Container()
                  //     : GestureDetector(
                  //         onTap: () {
                  //           // Navigator.push(
                  //           //     context,
                  //           //     MaterialPageRoute(
                  //           //         builder: (_) => HotelReviewDetailPage(
                  //           //               data: data,
                  //           //               dataDetail: dataDetail,
                  //           //             )));
                  //         },
                  //         child: Text(
                  //           'Lihat Semua',
                  //           style: mainBody4.copyWith(
                  //               color: Theme.of(context).primaryColor,
                  //               fontWeight: FontWeight.bold),
                  //         ),
                  //       )
                ],
              ),
              SizedBox(
                height: margin16,
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(margin24 / 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: neutral30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(Icons.star_rounded,
                            color: Theme.of(context).primaryColor, size: 20),
                        SizedBox(
                          width: margin4,
                        ),
                        Text(
                          data.avgRating.toStringAsFixed(1),
                          style: mainBody3.copyWith(
                              color: neutral100, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' /5',
                          style: mainBody4.copyWith(
                              color: neutral50, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: margin24 / 2,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.reviews.isEmpty
                            ? 'Belum Ada Review'
                            : model.getReviewVal(data.avgRating),
                        style: mainBody4.copyWith(
                            color: neutral100, fontWeight: FontWeight.bold),
                      ),
                      data.reviews.isEmpty
                          ? Container()
                          : Text(
                              'dari ${data.ratingCount} review',
                              style: mainBody5.copyWith(
                                  color: neutral70,
                                  fontWeight: FontWeight.w400),
                            )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: margin16,
        ),
        SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: IntrinsicHeight(
              child: Row(
                children: List.generate(data.reviews.length, (index) {
                  return Container(
                    margin: EdgeInsets.only(
                        left: index == 0 ? margin16 : 0,
                        right: index == data.reviews.length - 1 ? margin16 : 0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 200),
                        padding: EdgeInsets.all(margin24 / 2),
                        height: double.infinity,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: margin24,
                                  height: margin24,
                                  child: Icon(Icons.account_circle,
                                      color: neutral30, size: margin24),
                                ),
                                SizedBox(width: margin24 / 2),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.reviews[index].username ??
                                          'Nama Disembunyikan',
                                      style: mainBody4.copyWith(
                                          color: neutral100,
                                          fontStyle:
                                              data.reviews[index].username ==
                                                      null
                                                  ? FontStyle.italic
                                                  : FontStyle.normal,
                                          fontWeight:
                                              data.reviews[index].username ==
                                                      null
                                                  ? FontWeight.normal
                                                  : FontWeight.bold),
                                    ),
                                    Text(
                                      data.reviews[index].createdAt == null
                                          ? ''
                                          : dateToReadable(data
                                              .reviews[index].createdAt!
                                              .substring(0, 10)),
                                      style:
                                          mainBody5.copyWith(color: neutral30),
                                    )
                                  ],
                                )),
                                SizedBox(width: margin24 / 2),
                                Icon(
                                  Icons.star_rounded,
                                  color: Theme.of(context).primaryColor,
                                  size: 20,
                                ),
                                SizedBox(width: margin4),
                                Text(
                                  data.reviews[index].rate.toString(),
                                  style: mainBody4.copyWith(
                                      color: neutral100,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Container(
                              margin:
                                  EdgeInsets.symmetric(vertical: margin24 / 2),
                              width: double.infinity,
                              height: 1,
                              color: neutral30.withOpacity(0.3),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                data.reviews[index].comment,
                                style: mainBody5.copyWith(color: neutral100),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
        SizedBox(
          height: margin32,
        ),
      ],
    );
  }
}
