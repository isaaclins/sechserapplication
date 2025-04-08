import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimatedSmileyWidget extends StatefulWidget {
  const AnimatedSmileyWidget({super.key});

  @override
  State<AnimatedSmileyWidget> createState() => _AnimatedSmileyWidgetState();
}

class _AnimatedSmileyWidgetState extends State<AnimatedSmileyWidget> {
  int _currentIndex = 0;
  final List<String> _svgPaths = [
    'sprites/animation/1.svg',
    'sprites/animation/2.svg',
    'sprites/animation/3.svg',
  ];
  late Timer _timer;
  bool _increasing = true;

  @override
  void initState() {
    super.initState();
    // Update every 0.5 seconds
    _timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      setState(() {
        if (_increasing) {
          _currentIndex++;
          if (_currentIndex == _svgPaths.length - 1) {
            _increasing = false;
          }
        } else {
          _currentIndex--;
          if (_currentIndex == 0) {
            _increasing = true;
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          _svgPaths[_currentIndex],
          width: 60,
          height: 60,
          colorFilter: ColorFilter.mode(
            (CupertinoTheme.of(context).textTheme.textStyle.color ??
                    CupertinoColors.systemGrey)
                .withOpacity(0.5),
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'You can work now!',
          style: TextStyle(
            fontSize: 20,
            color: (CupertinoTheme.of(context).textTheme.textStyle.color ??
                    CupertinoColors.systemGrey)
                .withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}
