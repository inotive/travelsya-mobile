part of 'hotel_search_page.dart';

class _HotelSearchCitySection extends StatelessWidget {
  final HotelVM model;
  const _HotelSearchCitySection({required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: margin16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Berdasarkan Kota',
                style: mainBody3.copyWith(
                    color: Colors.black87, fontWeight: FontWeight.bold),
              ),
              Text(
                'Cari hotel berdasarkan kota populer di Indonesia',
                style: mainBody4.copyWith(
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: margin16,
        ),
        BlocBuilder<HotelCubit, HotelState>(
            bloc: model.locationHotelCubit,
            builder: (context, state) {
              if (state is ListHotelCityLoaded) {
                return Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(state.data.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                model.onChangeIndexCity(
                                    context, state.data[index]);
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: index == 0 ? margin16 : margin4,
                                    right: index == state.data.length - 1
                                        ? margin16
                                        : 0),
                                padding: EdgeInsets.symmetric(
                                    vertical: margin8, horizontal: margin16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color:
                                        state.data[index] == model.selectedCity
                                            ? Theme.of(context).primaryColor
                                            : Colors.transparent,
                                    border: Border.all(
                                        color: state.data[index] ==
                                                model.selectedCity
                                            ? neutral10
                                            : neutral80)),
                                child: Text(
                                  state.data[index],
                                  style: mainBody5.copyWith(
                                      color: state.data[index] ==
                                              model.selectedCity
                                          ? neutral10
                                          : neutral80),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: margin24 / 2,
                    ),
                    BlocBuilder<HotelCubit, HotelState>(
                      bloc: model.hotelByLocationCubit,
                      builder: (context, stateHotelCity) {
                        if (stateHotelCity is PreviewHotelListLoaded) {
                          return Column(
                            children: List.generate(stateHotelCity.data.length,
                                (index) {
                              return HotelPreviewCard(
                                data: stateHotelCity.data[index],
                              );
                            }),
                          );
                        } else if (stateHotelCity is HotelLoading) {
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: margin16),
                            child: Column(
                              children: List.generate(5, (index) {
                                return PlaceHolder(
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: margin8),
                                    width: double.infinity,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white),
                                  ),
                                );
                              }),
                            ),
                          );
                        } else {
                          return FailedRequestWidget(
                            onRetry: () {},
                          );
                        }
                      },
                    )
                  ],
                );
              } else if (state is HotelLoading) {
                return SizedBox(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(6, (index) {
                          return PlaceHolder(
                              child: Container(
                            margin: EdgeInsets.only(
                                left: index == 0 ? margin16 : margin4,
                                right: index == 5 ? margin16 : 0),
                            width: 50,
                            height: 20,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                          ));
                        }),
                      ),
                    ));
              } else {
                return FailedRequestWidget(
                  onRetry: () {
                    model.locationHotelCubit.fetchHotelAvailableCity(context,
                        onDataReady: (data) {
                      model.initCityHotel(context, data[0]);
                    });
                  },
                );
              }
            }),
      ],
    );
  }
}
