part of 'home_page.dart';

class _HomePageMenuSection extends StatelessWidget {
  final BerandaVM model;
  const _HomePageMenuSection({required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: margin8),
      child: Wrap(
        runSpacing: margin16,
        children: List.generate(model.dataMenu.length, (index) {
          return FractionallySizedBox(
            widthFactor: 0.25,
            child: GestureDetector(
              onTap: () {
                model.onMainMenuTap(context, model.dataMenu[index]['id']);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: margin4),
                child: Column(
                  children: [
                    Center(
                      child: FractionallySizedBox(
                        widthFactor: 0.7,
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: model.isDisableMenu(
                                        model.dataMenu[index]['id'])
                                    ? Colors.grey
                                    : const Color(0xfff3f3f3)),
                            alignment: Alignment.center,
                            child: Image.asset(
                              model.dataMenu[index]['assets'],
                              width: 40,
                              height: 40,
                              fit: BoxFit.contain,
                            ),
                            // child: ColorFiltered(
                            //   colorFilter: model.isDisableMenu(
                            //           model.dataMenu[index]['id'])
                            //       ? const ColorFilter.mode(
                            //           Colors.grey,
                            //           BlendMode.saturation,
                            //         )
                            //       : const ColorFilter.mode(
                            //           Colors.transparent,
                            //           BlendMode.multiply,
                            //         ),
                            //   child: FractionallySizedBox(
                            //     widthFactor: 0.6,
                            //     child: AspectRatio(
                            //       aspectRatio: 1,
                            //       child: Image.asset(
                            //         model.dataMenu[index]['assets'],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: margin4,
                    ),
                    Text(
                      model.dataMenu[index]['title'],
                      textAlign: TextAlign.center,
                      style: mainBody5,
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
