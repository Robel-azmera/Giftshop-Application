import 'package:flutter/material.dart';
import 'package:lezemed_mobile_app/config/size.dart';

class ListItem extends StatelessWidget {
  final int index;

  const ListItem({Key key, @required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.only(top: 0.0, left: 5.0, right: 5.0),
      padding: EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.0)),
      child: Row(
        children: <Widget>[
          Container(
            width: getProportionateScreenWidth(100.0),
            height: getProportionateScreenWidth(60.0),
            margin: EdgeInsets.only(right: 15.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: Colors.grey[400]),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.grey[400]),
            ),
          )
        ],
      ),
    );
  }
}
