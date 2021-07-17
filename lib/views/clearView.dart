import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class ClearView extends StatefulWidget {
  String? total; //총 격리자 수
  int? diff; //변동 수
  int? real; //실 확진자 수

  ClearView({this.total, this.diff, this.real});
  @override
  _ClearViewState createState() => _ClearViewState();
}

class _ClearViewState extends State<ClearView> {
  String? totalCnt;
  int? diffCnt;
  int? realCnt;
  @override
  void initState() {
    updateData(widget.total, widget.diff, widget.real);

    super.initState();
  }

  void updateData(dynamic total, dynamic diff, dynamic real) {
    totalCnt = total;
    diffCnt = diff;
    realCnt = real;
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "격리해제 수",
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
            '총 ' + "$totalCnt" + '명',
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
                'images/Increase_Positive.svg',
                width: 10,
                height: 10,
              ),
              Text(
                "$diffCnt",
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
              Text(
                "명 해제 ",
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Text(
                '남은 확진자 ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$realCnt',
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
              Text(
                '명',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
