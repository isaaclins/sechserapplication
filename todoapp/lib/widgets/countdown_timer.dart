import 'dart:async';
import 'package:flutter/cupertino.dart';

class CountdownTimer extends StatefulWidget {
  final DateTime dueDate;
  final TextStyle? style;

  const CountdownTimer({
    super.key,
    required this.dueDate,
    this.style,
  });

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  late Duration _timeLeft;

  @override
  void initState() {
    super.initState();
    _updateTimeLeft();
    // Update every second
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateTimeLeft();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateTimeLeft() {
    final now = DateTime.now();
    setState(() {
      _timeLeft = widget.dueDate.difference(now);
    });
  }

  String _formatDuration() {
    if (_timeLeft.isNegative) {
      return 'Overdue';
    }

    final days = _timeLeft.inDays;
    final hours = _timeLeft.inHours % 24;
    final minutes = _timeLeft.inMinutes % 60;
    final seconds = _timeLeft.inSeconds % 60;

    if (days > 0) {
      return '($days days, $hours hrs)';
    } else if (hours > 0) {
      return '($hours hrs, $minutes min)';
    } else if (minutes > 0) {
      return '($minutes min, $seconds sec)';
    } else {
      return '($seconds seconds)';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatDuration(),
      style: widget.style,
    );
  }
}
