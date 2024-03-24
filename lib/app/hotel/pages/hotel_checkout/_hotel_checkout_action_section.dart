part of 'hotel_checkout_page.dart';

class _HotelCheckoutActionSection extends StatelessWidget {
  final HotelDetailModel data;
  final HotelFormVM model;

  final HotelRoom selectedRoom;

  const _HotelCheckoutActionSection(
      {required this.data, required this.selectedRoom, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(margin16),
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: neutral10Stroke))),
      child: Column(
        children: [
          BlocBuilder<PointCubit, PointState>(
              bloc: BlocProvider.of<PointCubit>(context),
              builder: (context, statePoint) {
                if (statePoint is PointLoaded) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Poin Travelsya Anda',
                            style: mainBody5.copyWith(color: Colors.black54),
                          ),
                          Text(
                            '${moneyChanger(statePoint.data.currentPoint, customLabel: '')} Poin',
                            style: mainBody5.copyWith(
                                color: Theme.of(context).primaryColor),
                          )
                        ],
                      ),
                      SizedBox(
                        height: margin4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Poin yang dapat digunakan',
                            style: mainBody5.copyWith(color: Colors.black54),
                          ),
                          Text(
                            '${moneyChanger(statePoint.data.pointAvailable, customLabel: '')} Poin',
                            style: mainBody5.copyWith(
                                color: Theme.of(context).primaryColor),
                          )
                        ],
                      ),
                      SizedBox(
                        height: margin8,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: margin8),
                        padding: EdgeInsets.symmetric(
                            vertical: margin4, horizontal: margin8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.black.withOpacity(0.05)),
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tukar ${moneyChanger(statePoint.data.pointAvailable, customLabel: '')} Travelsya Poin',
                                  style: mainBody4.copyWith(
                                      color: model.usePoint
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                            SizedBox(
                              width: margin8,
                            ),
                            CupertinoSwitch(
                                value: model.usePoint,
                                activeColor: Theme.of(context).primaryColor,
                                onChanged: (val) {
                                  model.onChangePointUsed(context);
                                })
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (statePoint is PointLoading) {
                  return SizedBox(
                    width: 15,
                    height: 15,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Gagal Memuat Data Poin',
                        style: mainBody5.copyWith(color: Colors.black54),
                      ),
                      GestureDetector(
                        onTap: () {
                          BlocProvider.of<PointCubit>(context)
                              .fetchPoint(context);
                        },
                        child: Text(
                          'Coba Lagi',
                          style: mainBody5.copyWith(
                              color: Theme.of(context).primaryColor),
                        ),
                      )
                    ],
                  );
                }
              }),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Tagihan',
                style: mainBody5.copyWith(color: neutral100),
              ),
              Text(
                model.getGrandTotalInvoice(context, selectedRoom),
                style: mainBody4.copyWith(
                    color: neutral100, fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: margin24 / 2,
          ),
          ElevatedButtonWidget(
              enabled: true,
              onTap: () {
                model.onSubmit(context, data: data, room: selectedRoom);
              },
              title: 'Lanjutkan ke Pembayaran')
        ],
      ),
    );
  }
}
