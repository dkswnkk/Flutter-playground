import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DecideView extends StatefulWidget {
  final String? total; //총 확진자
  final int? diff; //변동 수

  DecideView({
    this.total,
    this.diff,
  });

  @override
  _DecideViewState createState() => _DecideViewState();
}

class _DecideViewState extends State<DecideView> {
  String? totalCnt;
  int? diffCnt;
  @override
  void initState() {
    updateData(widget.total, widget.diff);

    super.initState();
  }

  void updateData(dynamic total, dynamic diff) {
    totalCnt = total;
    diffCnt = diff;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 21),
            blurRadius: 53,
            color: Colors.black.withOpacity(0.05),
          )
        ],
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.black87, // foreground
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "확진자 수",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              '총 ' + '$totalCnt' + '명',
            ),
            SizedBox(height: 4.0),
            Row(
              children: [
                Text(
                  "오늘 ",
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 16,
                  ),
                ),
                SvgPicture.asset(
                  'images/Increase_Negative.svg',
                  width: 10,
                  height: 10,
                ),
                Text(
                  "$diffCnt",
                  style: TextStyle(
                    color: Colors.redAccent,
                  ),
                ),
                Text(
                  "명 확진 ",
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
        onPressed: () {},
      ),
    );
  }
}
