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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(model.listIklan.length, (index) {
              return Container(
                  margin: EdgeInsets.only(
                      left: index == 0 ? margin16 : margin4,
                      right:
                          index == model.listIklan.length - 1 ? margin16 : 0),
                  width: 150,
                  child: GestureDetector(
                    onTap: () {},
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 417 / 301,
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black12,
                                  image: DecorationImage(
                                      image:
                                          AssetImage(model.listIklan[index]))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
            }),
          ),
        ),
      ],
    );
  }
}
