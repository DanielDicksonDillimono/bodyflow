import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Creates a platform-specific page with swipe navigation support.
/// 
/// On iOS/macOS, this uses CupertinoPage which provides native swipe-to-go-back gesture.
/// On Android and other platforms, this uses MaterialPage with the platform's default transition.
Page<dynamic> buildPageWithPlatformTransitions({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  final bool isApplePlatform = defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.macOS;

  if (isApplePlatform) {
    return CupertinoPage(
      key: state.pageKey,
      child: child,
    );
  } else {
    return MaterialPage(
      key: state.pageKey,
      child: child,
    );
  }
}
