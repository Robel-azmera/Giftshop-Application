import 'package:flutter/material.dart';
import 'package:lezemed_mobile_app/config/palete.dart';
import 'package:intl/intl.dart';

class BuildDateTimePicker extends StatefulWidget {
  final Icon icon;
  final String lableText;
  final TextEditingController dateTimeEditingController;
  BuildDateTimePicker({
    Key key,
    @required this.icon,
    @required this.lableText,
    @required this.dateTimeEditingController,
  }) : super(key: key);

  @override
  _BuildDateTimePickerState createState() => _BuildDateTimePickerState();
}

class _BuildDateTimePickerState extends State<BuildDateTimePicker> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        widget.dateTimeEditingController
          ..text = DateFormat.yMMMd().format(selectedDate)
          ..selection = TextSelection.fromPosition(TextPosition(
              offset: widget.dateTimeEditingController.text.length,
              affinity: TextAffinity.upstream));
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "${selectedDate.toLocal()}".split(' ')[0],
            style: TextStyle(
              fontSize: 16,
              color: kSecondaryColor,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          IconButton(
            onPressed: () => _selectDate(context),
            icon: Icon(
              Icons.calendar_today_outlined,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
