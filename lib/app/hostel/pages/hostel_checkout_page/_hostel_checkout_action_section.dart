part of 'hostel_checkout_page.dart';

class _HostelCheckoutActionSection extends StatelessWidget {
  final HostelDetailModel data;
  final HostelFormVM model;
  final HostelRoom selectedRoom;

  const _HostelCheckoutActionSection(
      {required this.data, required this.selectedRoom, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(margin16),
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: neutral10Stroke))),
      child: Column(
        children: [
          BlocBuilder<ProfileCubit, ProfileState>(
              bloc: BlocProvider.of<ProfileCubit>(context),
              builder: (context, stateProfile) {
                if (stateProfile is ProfileLoaded) {
                  return Container(
                    margin: EdgeInsets.only(bottom: margin8),
                    padding: EdgeInsets.symmetric(
                        vertical: margin8, horizontal: margin24 / 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.black.withOpacity(0.05)),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          'Tukar ${moneyChanger(stateProfile.data.user.point.toDouble(), customLabel: '')} Travelsya Poin',
                          style: mainBody5.copyWith(
                              color: model.usePoint
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey,
                              fontWeight: FontWeight.bold),
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
                  );
                }

                return Container();
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
