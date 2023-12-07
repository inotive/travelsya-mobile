part of 'hotel_checkout_page.dart';

class _HotelCheckoutInvoiceSection extends StatelessWidget {
  final HotelDetailModel data;
  final HotelFormVM model;

  final HotelRoom selectedRoom;

  const _HotelCheckoutInvoiceSection(
      {required this.data, required this.selectedRoom, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(margin16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detail Tagihan',
            style: mainBody3.copyWith(
                color: neutral100, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: margin16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    style: mainBody4.copyWith(color: Colors.black87),
                  ),
                  Text(
                    '${model.filter.roomCount} x Kamar ${selectedRoom.name} (${model.filter.selectedTime.endDate!.difference(model.filter.selectedTime.startDate!).inDays} Hari)',
                    style: mainBody5.copyWith(color: Colors.black54),
                  )
                ],
              ),
              Text(
                model.getTotalInvoice(selectedRoom),
                style: mainBody4.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: margin4,
          ),
          BlocBuilder<FeeAdminCubit, FeeAdminState>(
              bloc: BlocProvider.of<FeeAdminCubit>(context),
              builder: (context, state) {
                if (state is FeeAdminLoading) {
                  return PlaceHolder(
                      child: Container(
                    width: double.infinity,
                    height: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                  ));
                } else if (state is FeeAdminLoaded) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                          text: TextSpan(
                              style: mainBody4.copyWith(color: Colors.black87),
                              children: [
                            const TextSpan(text: 'Admin'),
                            TextSpan(
                              text: model.feeAdminData(state.data) == null
                                  ? ''
                                  : model.feeAdminData(state.data)!.isPercent ==
                                          1
                                      ? ' (${model.feeAdminData(state.data)!.value}%)'
                                      : '',
                            )
                          ])),
                      Text(
                        moneyChanger(
                            model.getAdminValue(context, selectedRoom)),
                        style: mainBody4.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    ],
                  );
                } else {
                  return FailedRequestHorizontalWidget(onRetry: () {
                    BlocProvider.of<FeeAdminCubit>(context)
                        .fetchFeeAdmin(context);
                  });
                }
              }),
          SizedBox(
            height: margin4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Kode Unik',
                style: mainBody4.copyWith(color: Colors.black87),
              ),
              Text(
                model.uniqueCode,
                style: mainBody4.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
