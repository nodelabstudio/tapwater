import 'package:flutter/material.dart';

class MilestoneMessage extends StatelessWidget {
  final int currentMl;
  final int goalMl;

  const MilestoneMessage({
    super.key,
    required this.currentMl,
    required this.goalMl,
  });

  @override
  Widget build(BuildContext context) {
    if (goalMl <= 0 || currentMl <= 0) return const SizedBox.shrink();

    final pct = (currentMl / goalMl * 100).round();
    final message = _messageForPercent(pct);
    if (message == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Text(message.icon, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message.text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _Milestone? _messageForPercent(int pct) {
    if (pct >= 100) return const _Milestone('\u{1F389}', 'Goal reached! Amazing work today!');
    if (pct >= 75) return const _Milestone('\u{1F4AA}', 'Almost there! Just a little more.');
    if (pct >= 50) return const _Milestone('\u{1F31F}', 'Halfway there! Keep it up!');
    if (pct >= 25) return const _Milestone('\u{1F44D}', 'Great start! You\'re making progress.');
    return null;
  }
}

class _Milestone {
  final String icon;
  final String text;
  const _Milestone(this.icon, this.text);
}
