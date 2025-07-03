import 'package:flutter/material.dart';

class BlinkingRecordingText extends StatefulWidget {
  const BlinkingRecordingText({super.key, required this.text});
  final String text;

  @override
  State<BlinkingRecordingText> createState() => _BlinkingRecordingTextState();
}

class _BlinkingRecordingTextState extends State<BlinkingRecordingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true); // blink back and forth

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.fiber_manual_record, color: Colors.red, size: 18),
          const SizedBox(width: 6),
           Text(
            widget.text,
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
