import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GhostWidget extends StatelessWidget {
  const GhostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'sprites/ghost.svg',
      width: 100,
      height: 100,
      colorFilter: ColorFilter.mode(
        (CupertinoTheme.of(context).textTheme.textStyle.color ??
                CupertinoColors.systemGrey)
            .withOpacity(0.5),
        BlendMode.srcIn,
      ),
    );
  }
}
