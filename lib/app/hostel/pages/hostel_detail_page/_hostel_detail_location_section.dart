part of 'hostel_detail_page.dart';

class _HostelDetailLocationSection extends StatelessWidget {
  final HostelDetailModel data;

  const _HostelDetailLocationSection({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding:
              EdgeInsets.only(top: margin16, left: margin16, right: margin16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Lokasi',
                    style: mainBody3.copyWith(fontWeight: FontWeight.bold),
                  ),
                  data.latitude != null && data.longitude != null
                      ? GestureDetector(
                          onTap: () async {
                            final url =
                                'https://www.google.com/maps/search/?api=1&query=${data.latitude},${data.longitude}';
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(Uri.parse(url),
                                  mode: LaunchMode.externalApplication);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Text(
                            'Buka di Map',
                            style: mainFont.copyWith(
                                fontSize: 13,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: margin16,
        ),
        data.latitude != null && data.longitude != null
            ? AspectRatio(
                aspectRatio: 375 / 142,
                child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: FlutterMap(
                        options: MapOptions(
                          initialCenter: LatLng(double.parse(data.latitude!),
                              double.parse(data.longitude!)),
                          initialZoom: 7,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName:
                                'dev.fleaflet.flutter_map.example',
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                width: 50,
                                height: 70,
                                point: LatLng(double.parse(data.latitude!),
                                    double.parse(data.longitude!)),
                                child: Icon(
                                  Icons.location_on,
                                  color: Theme.of(context).primaryColor,
                                  size: 40,
                                ),
                              )
                            ],
                          )
                        ])),
              )
            : const SizedBox(),
        SizedBox(
          height: data.latitude != null && data.longitude != null
              ? margin24 / 2
              : 0,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: margin16),
          child: Row(
            children: [
              Icon(
                Icons.map_outlined,
                color: Colors.grey,
                size: margin16,
              ),
              SizedBox(
                width: margin24 / 2,
              ),
              Expanded(
                  child: Text(
                data.address ?? 'Data Alamat Tidak Ditemukan',
                style: mainBody5.copyWith(
                    fontStyle: data.address == null
                        ? FontStyle.italic
                        : FontStyle.normal,
                    color: const Color(0xff333333)),
              )),
              data.latitude != null && data.longitude != null
                  ? GestureDetector(
                      onTap: () async {
                        final url =
                            'https://www.google.com/maps/search/?api=1&query=${data.latitude},${data.longitude}';
                        if (await canLaunchUrl(Uri.parse(url))) {
                          await launchUrl(Uri.parse(url),
                              mode: LaunchMode.externalApplication);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: margin24 / 2),
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).primaryColor),
                        child: const Icon(
                          Icons.open_in_new_outlined,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
        SizedBox(
          height: margin16,
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
