import 'package:bodyflow/ui/core/themes/colors.dart';
import 'package:flutter/material.dart';

class GeneratorPageHeader extends SliverPersistentHeaderDelegate {
  final double? height;
  GeneratorPageHeader(this.height);
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final double progress = shrinkOffset / maxExtent;
    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedOpacity(
            duration: const Duration(milliseconds: 150),
            opacity: progress,
            child: ColoredBox(color: const Color.fromARGB(189, 255, 255, 255)),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 150),
            opacity: 1 - progress,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/barbell.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    AppColors.appBlue.withValues(alpha: 0.5),
                    BlendMode.screen,
                  ),
                ),
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            padding: EdgeInsets.lerp(
              EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              progress,
            ),
            alignment: Alignment.centerLeft,

            child: Text(
              'Generator',
              style: TextStyle.lerp(
                Theme.of(context).textTheme.displayLarge,
                Theme.of(context).textTheme.titleLarge,
                progress,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => height ?? 124;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
