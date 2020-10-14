import 'package:flutter/material.dart';

class ToggleButton extends StatelessWidget {
  ToggleButton({this.active, this.onPressed, this.child});

  final bool active;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: FlatButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textColor: Colors.white,
        color: active ? Colors.blue : Colors.grey,
        child: child,
      ),
    );
  }
}
