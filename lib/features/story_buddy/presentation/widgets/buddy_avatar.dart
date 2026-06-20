import 'package:flutter/material.dart';

class BuddyAvatar extends StatefulWidget {
  final bool isSuccess;

  const BuddyAvatar({
    super.key,
    this.isSuccess = false,
  });

  @override
  State<BuddyAvatar> createState() => _BuddyAvatarState();
}

class _BuddyAvatarState extends State<BuddyAvatar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      lowerBound: 0.95,
      upperBound: 1.05,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _controller,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/robot_buddy.png',
              height: widget.isSuccess ? 220 : 200,
            ),
            const SizedBox(height: 12),
            Text(
              widget.isSuccess ? '🥳 Hooray!' : '🤖 Hi Friend!',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
