import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LugoButton extends StatefulWidget {
  const LugoButton({
    super.key,
    required this.textButton,
    required this.textColor,
    required this.textSize,
    required this.width,
    required this.height,
    required this.color,
    required this.onTap,
  });

  final String textButton;
  final double textSize;
  final Color textColor;
  final double width;
  final double height;
  final Color color;
  final Function() onTap;

  @override
  State<LugoButton> createState() => _LugoButtonState();
}

class _LugoButtonState extends State<LugoButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: widget.onTap,
        style: ElevatedButton.styleFrom(
            elevation: 5,
            fixedSize: Size(widget.width, widget.height),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
            ),
            backgroundColor: widget.color
        ),
        child: Text(
          widget.textButton,
          style: GoogleFonts.readexPro(
              fontSize: widget.textSize,
              color: widget.textColor
          ),
        )
    );
  }
}