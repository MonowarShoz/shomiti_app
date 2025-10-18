import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imsomitiapp/core/utils/app_strings.dart';



extension StringExtensions on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

extension ListExtension on List? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

extension NavigationGoRouter on BuildContext {
  void goNamed(
    String routeName, {
    Map<String, String> params = const {},
    Object? extra,
  }) {
    GoRouter.of(this).goNamed(routeName, pathParameters: params, extra: extra);
  }

  void pushNamed(
    String routeName, {
    Map<String, String> params = const {},
    Object? extra,
  }) {
    GoRouter.of(
      this,
    ).pushNamed(routeName, pathParameters: params, extra: extra);
  }

  void pushReplacementNamed(
    String routeName, {
    Map<String, String> params = const {},
    Object? extra,
  }) {
    GoRouter.of(
      this,
    ).replaceNamed(routeName, pathParameters: params, extra: extra);
  }

  /// Remove all routes and push new route
  void pushAndRemoveUntil(
    String routeName, {
    Map<String, String> params = const {},
    Object? extra,
    bool Function(Route<dynamic>)? predicate,
  }) {
    final removeAllPredicate = predicate ?? (Route<dynamic> route) => false;
    pushNamed(routeName, params: params, extra: extra);
    Navigator.of(this).popUntil(removeAllPredicate);
  }

  /// Alternative version that works with MaterialPageRoute
  void pushAndRemoveUntilMaterial(
    Widget Function(BuildContext) builder, {

    bool Function(Route<dynamic>)? predicate,
  }) {
    Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: builder),
      predicate ?? (Route<dynamic> route) => false,
    );
  }

  void pop() => Navigator.of(this).pop();
}

extension NullableExtension<T> on T? {
  R? let<R>(R Function(T it) block){
    final self = this;
    if(self != null){
      return block(self);
    }
    return null;
  }

}
extension Regex on String {
  String? isValidateEmail() {
    if (isEmpty) {
      return AppStrings.enterEmail;
    } else if (!RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(this)) {
      return AppStrings.enterValidEmail;
    }
    return null;
  }
}