part of 'hostel_detail_page.dart';

class _HostelDetailFacilitySection extends StatelessWidget {
  final HostelDetailModel data;

  const _HostelDetailFacilitySection({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(5.0.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Fasilitas',
                    style: mainBody3.copyWith(
                        color: Colors.black87, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: margin16,
              ),
              data.facilities.isEmpty
                  ? Center(
                      child: Text(
                        'Data Fasilitas Tidak Ditemukan',
                        style: mainBody5.copyWith(
                            fontStyle: FontStyle.italic, color: neutral80),
                      ),
                    )
                  : SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        children:
                            List.generate(data.facilities.length, (index) {
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
                                        color: Theme.of(context).primaryColor),
                                  ))
                                ],
                              ),
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
