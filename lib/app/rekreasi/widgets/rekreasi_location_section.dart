import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:travelsya/app/rekreasi/models/recreation_model.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class RekreasiLocationSection extends StatelessWidget {
  final RecreationDetailModel data;
  const RekreasiLocationSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    double latitude = data.latitude;
    double longitude = data.longitude;

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
                  GestureDetector(
                    onTap: () async {
                      final url =
                          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
                      if (await canLaunchUrl(Uri.parse(url))) {
                        await launchUrl(Uri.parse(url),
                            mode: LaunchMode.externalApplication);
                      } else {
                        if (context.mounted) {
                          showSnackbar(context,
                              data: 'Tidak dapat membukan maps',
                              colors: Colors.orange);
                        }
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
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: margin16,
        ),
        AspectRatio(
          aspectRatio: 375 / 142,
          child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(latitude, longitude),
                    initialZoom: 7,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 50,
                          height: 70,
                          point: LatLng(latitude, longitude),
                          child: Icon(
                            Icons.location_on,
                            color: Theme.of(context).primaryColor,
                            size: 40,
                          ),
                        )
                      ],
                    )
                  ])),
        ),
        SizedBox(
          height: margin24 / 2,
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
                data.address,
                style: mainBody5.copyWith(
                    fontStyle: FontStyle.normal,
                    color: const Color(0xff333333)),
              )),
              GestureDetector(
                onTap: () async {
                  final url =
                      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
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
