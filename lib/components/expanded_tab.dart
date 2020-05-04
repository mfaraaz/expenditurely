import 'package:flutter/material.dart';

class ExpandedTab extends StatelessWidget {
  ExpandedTab({this.displayText, this.backColor, this.textColor, this.func,});
  final String displayText;
  final Color backColor;
  final Function func;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: backColor),
        padding: EdgeInsets.symmetric(vertical: 0),
        child: FlatButton(
          onPressed: func,
          child: Text(displayText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: textColor,
              )),
        ),
      ),
    );
  }
}
