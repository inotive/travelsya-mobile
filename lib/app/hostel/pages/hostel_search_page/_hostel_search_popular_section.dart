part of 'hostel_search_page.dart';

class _HostelSearchPopularSection extends StatelessWidget {
  final HostelSearchVM model;
  const _HostelSearchPopularSection({required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: margin16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Yang paling populer',
            style: mainBody3.copyWith(
                color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          Text(
            'Hostel yang paling sering dikunjungi',
            style: mainBody4.copyWith(
              color: Colors.black87,
            ),
          ),
          SizedBox(height: margin16),
          BlocBuilder<HostelCubit, HostelState>(
              bloc: model.hostelPopularCubit,
              builder: (context, state) {
                if (state is ListPreviewHostelLoaded) {
                  return SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: List.generate(state.data.length, (index) {
                        return FractionallySizedBox(
                            widthFactor: 0.49,
                            child: HostelPreviewWidget(
                              data: state.data[index],
                            ));
                      }),
                    ),
                  );
                } else if (state is HostelLoading) {
                  return SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      runSpacing: margin8,
                      children: List.generate(6, (index) {
                        return FractionallySizedBox(
                          widthFactor: 0.48,
                          child: PlaceHolder(
                            child: Container(
                              width: double.infinity,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                } else {
                  return FailedRequestWidget(onRetry: () {
                    model.hostelPopularCubit.fetchPopulerHostel(context);
                  });
                }
              }),
        ],
      ),
    );
  }
}
