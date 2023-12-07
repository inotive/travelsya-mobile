part of 'hostel_search_page.dart';

class _HostelSearchBackgroundSection extends StatelessWidget {
  const _HostelSearchBackgroundSection();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.topCenter,
          child: Container(
            width: double.infinity,
            height: 200,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                        'assets/images/edvin-johansson-rlwE8f8anOc-unsplash 1 (5).png'))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hostel',
                  style: mainBody2.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Cari dan book Hostel untuk hari spesialmu!',
                  style: mainBody5.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: margin16,
          top: margin16 + MediaQuery.of(context).padding.top,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 35,
              height: 35,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: Icon(
                Icons.arrow_back,
                color: Theme.of(context).primaryColor,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
