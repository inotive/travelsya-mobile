part of 'hostel_checkout_page.dart';

class _HostelCheckoutInfoSection extends StatelessWidget {
  final HostelDetailModel data;
  final HostelFormVM model;
  final HostelRoom selectedRoom;

  const _HostelCheckoutInfoSection(
      {required this.data, required this.selectedRoom, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(margin16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: data.image == null
                        ? const DecorationImage(
                            image: AssetImage(ConstHelper.logoIcon),
                            fit: BoxFit.cover)
                        : DecorationImage(
                            image: NetworkImage(data.image!),
                            fit: BoxFit.cover)),
              ),
              SizedBox(
                width: margin24 / 2,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    style: mainBody3.copyWith(
                        fontWeight: FontWeight.bold, color: neutral100),
                  ),
                  Text(
                    '${model.filter.totalDuration} x (${model.filter.selectedDuration})',
                    style: mainBody5.copyWith(color: neutral100),
                  )
                ],
              ))
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: margin24 / 2),
            width: double.infinity,
            height: 1,
            color: neutral10Stroke,
          ),
          IntrinsicHeight(
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: margin24 / 2),
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
                          dateToReadable(DateFormat('yyyy-MM-dd')
                              .format(model.filter.startDate)),
                          style: mainBody4.copyWith(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data.checkIn,
                          style: mainBody5.copyWith(color: neutral100),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: margin24 / 2,
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: margin24 / 2),
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
                          model.getEndSewa(context),
                          style: mainBody4.copyWith(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data.checkOut,
                          style: mainBody5.copyWith(color: neutral100),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: margin24 / 2),
            width: double.infinity,
            height: 1,
            color: neutral10Stroke,
          ),
          BlocBuilder<HostelCubit, HostelState>(
              bloc: model.hostelRoomCubit,
              builder: (context, state) {
                if (state is HostelLoading) {
                  return PlaceHolder(
                      child: Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                  ));
                } else if (state is HostelDetailRoomLoaded) {
                  return SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Spesifikasi Unit',
                          style:
                              mainBody4.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: margin4,
                        ),
                        AspectRatio(
                            aspectRatio: 2 / 1,
                            child: CarouselSlider(
                                items: List.generate(state.data.images.length,
                                    (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => PhotoViewListPage(
                                                    images: state.data.images,
                                                  )));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: margin4),
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: Image.network(
                                        state.data.images[index],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                }),
                                options: CarouselOptions(
                                    viewportFraction: 0.8,
                                    height: double.infinity))),
                        SizedBox(
                          height: margin8,
                        ),
                        FormHelper.splitRow(
                            data: state.data.totalBed.toString(),
                            title: 'Jumlah Kamar'),
                        SizedBox(
                          height: margin4,
                        ),
                        FormHelper.splitRow(
                            data: state.data.totalBath.toString(),
                            title: 'Jumlah Kamar Mandi'),
                        SizedBox(
                          height: margin4,
                        ),
                        FormHelper.splitRow(
                            data: state.data.maxGuest == '0'
                                ? 'Tidak Ada Batasan'
                                : state.data.maxGuest.toString(),
                            title: 'Maksimal Penghuni'),
                        SizedBox(
                          height: margin8,
                        ),
                        Text(
                          'Fasilitas Unit',
                          style:
                              mainBody4.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: margin4,
                        ),
                        Wrap(
                          children: List.generate(
                              state.data.roomFacilities.length, (index) {
                            return FractionallySizedBox(
                              widthFactor: 0.5,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: Image.network(baseUrl +
                                          data.facilities[index]['image']),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Text(
                                      data.facilities[index]['name'],
                                      style: mainBody4.copyWith(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ))
                                  ],
                                ),
                              ),
                            );
                          }),
                        )
                      ],
                    ),
                  );
                } else {
                  return FailedRequestHorizontalWidget(onRetry: () {
                    model.hostelRoomCubit.fetchDetailRoom(context,
                        id: selectedRoom.id.toString());
                  });
                }
              })
        ],
      ),
    );
  }
}
