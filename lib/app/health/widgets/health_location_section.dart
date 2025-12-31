import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:travelsya/app/health/models/health_model.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class HealthLocationSection extends StatelessWidget {
  final HealthDetailModel data;
  const HealthLocationSection({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    double? latitude = data.latitude;
    double? longitude = data.longitude;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(margin16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lokasi',
                style: mainBody3.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: margin16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  children: [
                    // Container(
                    //   width: double.infinity,
                    //   height: 120,
                    //   decoration: const BoxDecoration(
                    //     borderRadius: BorderRadius.only(
                    //       topLeft: Radius.circular(10),
                    //       topRight: Radius.circular(10),
                    //     ),
                    //     image: DecorationImage(
                    //       image: AssetImage('assets/new/maps_example.png'),
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    // ),
                    Container(
                      padding: EdgeInsets.all(margin16),
                      child: Column(
                        children: [
                          if (latitude != null && longitude != null)
                            SizedBox(
                              width: double.infinity,
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 375 / 142,
                                        child: SizedBox(
                                          width: double.infinity,
                                          height: double.infinity,
                                          child: FlutterMap(
                                            options: MapOptions(
                                              initialCenter:
                                                  LatLng(latitude, longitude),
                                              initialZoom: 7,
                                              minZoom: 3,
                                              maxZoom: 18,
                                              interactiveFlags:
                                                  InteractiveFlag.pinchZoom |
                                                      InteractiveFlag.drag,
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
                                                    point: LatLng(
                                                        latitude, longitude),
                                                    child: Icon(
                                                      Icons.location_on,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      size: 40,
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: Image.asset(
                                              'assets/new/location.png',
                                              color: const Color(0xffa5a5a5),
                                            ),
                                          ),
                                          SizedBox(width: margin16),
                                          Expanded(
                                            child: Text(
                                              data.address ?? '-',
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: mainBody5.copyWith(
                                                  color: Colors.black87),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.black12),
                                            ),
                                            alignment: Alignment.center,
                                            child: SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: Image.asset(
                                                  'assets/new/direction.png'),
                                            ),
                                          ),
                                          SizedBox(height: margin8),
                                          Text(
                                            'Panduan ke Lokasi',
                                            style: mainBody5.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(width: 16),
                                      GestureDetector(
                                        onTap: () async {
                                          final url =
                                              'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
                                          if (await canLaunchUrl(
                                              Uri.parse(url))) {
                                            await launchUrl(Uri.parse(url),
                                                mode: LaunchMode
                                                    .externalApplication);
                                          } else {
                                            if (context.mounted) {
                                              showSnackbar(
                                                context,
                                                data:
                                                    'Tidak dapat membuka maps',
                                                colors: Colors.orange,
                                              );
                                            }
                                          }
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Colors.black12),
                                              ),
                                              alignment: Alignment.center,
                                              child: SizedBox(
                                                width: 24,
                                                height: 24,
                                                child: Image.asset(
                                                    'assets/new/location.png'),
                                              ),
                                            ),
                                            SizedBox(height: margin8),
                                            Text(
                                              'Lihat Peta',
                                              style: mainBody5.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          else
                            Center(
                              child: Text(
                                'Lokasi tidak tersedia',
                                style: mainBody5.copyWith(color: Colors.red),
                              ),
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
