import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SadWidget extends StatelessWidget {
  const SadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'sprites/ghost.svg',
      width: 80,
      height: 80,
      colorFilter: ColorFilter.mode(
        (CupertinoTheme.of(context).textTheme.textStyle.color ??
                CupertinoColors.systemGrey)
            .withOpacity(0.5),
        BlendMode.srcIn,
      ),
    );
  }
}
