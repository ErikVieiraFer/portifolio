import 'package:flutter/material.dart';

class HorizontalBlinkingCursor extends StatefulWidget {
  final double width;
  final double height;

  const HorizontalBlinkingCursor({
    super.key,
    this.width = 40.0,
    this.height = 5.0,
  });

  @override
  State<HorizontalBlinkingCursor> createState() =>
      _HorizontalBlinkingCursorState();
}

class _HorizontalBlinkingCursorState extends State<HorizontalBlinkingCursor>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _controller.value,
          child: Container(
            width: widget.width,
            height: widget.height,
            margin: const EdgeInsets.only(left: 2),

            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(221, 233, 30, 98),
                  blurRadius: 3,
                  spreadRadius: 1,
                ),
                BoxShadow(
                  color: const Color.fromARGB(88, 233, 30, 98),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
