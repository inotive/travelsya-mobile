part of 'home_page.dart';

class _HomePageAdsSection extends StatelessWidget {
  final BerandaVM model;
  const _HomePageAdsSection({required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: margin16),
          child: Text(
            'Iklan',
            style: mainBody2.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: margin4,
        ),
        BlocBuilder<AdsCubit, AdsState>(
            bloc: model.adsCubit,
            builder: (context, state) {
              if (state is AdsLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                );
              } else if (state is AdsLoaded) {
                if (state.data.isEmpty) {
                  return Center(
                    child: Text(
                      'Iklan Tidak Ditemukan',
                      style: mainBody4.copyWith(color: Colors.black54),
                    ),
                  );
                }

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(state.data.length, (index) {
                      return Container(
                          margin: EdgeInsets.only(
                              left: index == 0 ? margin16 : margin4,
                              right: index == state.data.length - 1
                                  ? margin16
                                  : 0),
                          width: 250,
                          child: GestureDetector(
                            onTap: () {
                              if (state.data[index].url != null) {
                                launchUrl(Uri.parse(state.data[index].url!),
                                    mode: LaunchMode.externalApplication);
                              }
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1440 / 576,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        state.data[index].image,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            color: Colors.black12,
                                            child: const Icon(
                                              Icons.broken_image,
                                              size: 40,
                                              color: Colors.grey,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ));
                    }),
                  ),
                );
              } else {
                return Container(
                    margin: EdgeInsets.symmetric(horizontal: margin16),
                    child: FailedRequestWidget(onRetry: () {
                      model.adsCubit.fetchAdsData(context);
                    }));
              }
            }),
      ],
    );
  }
}
