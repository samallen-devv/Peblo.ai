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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.auto_awesome,
                  color: Colors.amber,
                  size: 30,
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.star,
                  color: Colors.orange,
                  size: 24,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFEDE9FE),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withValues(
                      alpha: 0.2,
                    ),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Image.asset(
                'assets/images/robot_buddy.png',
                height: widget.isSuccess ? 200 : 180,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.star,
                  color: Colors.orange,
                  size: 24,
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.auto_awesome,
                  color: Colors.amber,
                  size: 30,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              widget.isSuccess ? '🥳 Hooray!' : '🤖 Hi Friend!',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.isSuccess ? 'You are amazing!' : 'Ready for a fun story?',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
