import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MiniListItem extends StatefulWidget {
  final String? text;

  const MiniListItem({Key? key, required String? this.text}) : super(key: key);

  @override
  _MiniListItemState createState() => _MiniListItemState();
}

class _MiniListItemState extends State<MiniListItem> {
  @override
  Widget build(BuildContext context) {
    return widget.text != null && widget.text != '' ? Container(color: Colors.transparent, child: Expanded(
      child: Container(
          padding: EdgeInsets.all(8),
          child:
          Text(widget.text!,
              style: GoogleFonts.mochiyPopOne(
            fontSize: 12,
          ))),
    )) : Text('');
  }

}