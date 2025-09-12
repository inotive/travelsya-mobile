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
          final menu = model.dataMenu[index];
          final isDisabled = model.isDisableMenu(menu['id']);

          return FractionallySizedBox(
            widthFactor: 0.25,
            child: GestureDetector(
              onTap: () {
                model.onMainMenuTap(context, menu['id']);
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
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isDisabled
                                  ? Colors.grey.shade300
                                  : const Color(0xfff3f3f3),
                            ),
                            alignment: Alignment.center,
                            child: Image.asset(
                              menu['assets'],
                              width: 40,
                              height: 40,
                              fit: BoxFit.contain,
                              color: isDisabled
                                  ? Colors.black.withOpacity(0.4)
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: margin4),
                    Text(
                      menu['title'],
                      textAlign: TextAlign.center,
                      style: mainBody5.copyWith(
                        color: isDisabled ? Colors.grey : Colors.black,
                      ),
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
