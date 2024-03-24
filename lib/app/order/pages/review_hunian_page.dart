import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/order/vm/hunian_review_vm.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';

class ReviewHunianPage extends StatelessWidget {
  final bool isHotel;
  final int hunianId;
  final int roomId;
  final String transactionId;

  const ReviewHunianPage(
      {super.key,
      required this.transactionId,
      required this.isHotel,
      required this.hunianId,
      required this.roomId});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HunianReviewVM>.reactive(
        viewModelBuilder: () {
          return HunianReviewVM();
        },
        onViewModelReady: (model) {},
        builder: (context, model, child) {
          return SafeArea(
              child: Scaffold(
                  body: Column(children: [
            Container(
              padding: EdgeInsets.all(margin16),
              color: Theme.of(context).primaryColor,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: margin24 / 2,
                  ),
                  Expanded(
                    child: Text(
                      'Review ${isHotel ? 'Hotel' : 'Hostel'}',
                      style: mainBody4.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: ListView(
              padding: EdgeInsets.symmetric(horizontal: margin16),
              children: [
                SizedBox(
                  height: margin16,
                ),
                Center(
                  child: RatingBar.builder(
                    initialRating: 5,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      model.onChangeRating(rating);
                    },
                  ),
                ),
                SizedBox(
                  height: margin8,
                ),
                Center(
                  child: Text(
                    model.getReviewVal(model.rating),
                    style: mainBody2.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: margin32,
                ),
                FormHelper.titleWithWidget(
                    title: 'Review',
                    widget: FormHelper.roundedTextfield(context,
                        maxLines: 5,
                        hintText: 'Review Anda..',
                        controller: model.reviewController)),
                SizedBox(
                  height: margin16,
                ),
                FormHelper.elevatedButtonBasic(context, enabled: true,
                    onTap: () {
                  model.onSubmit(context,
                      isHotel: isHotel,
                      transactionId: transactionId,
                      id: hunianId.toString(),
                      roomId: roomId.toString());
                }, title: 'Review'),
                SizedBox(
                  height: margin72,
                )
              ],
            ))
          ])));
        });
  }
}
