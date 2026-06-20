import 'package:flutter/material.dart';

class StoryCard extends StatelessWidget {
  final String story;

  const StoryCard({
    super.key,
    required this.story,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        story,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 18,
          height: 1.6,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
