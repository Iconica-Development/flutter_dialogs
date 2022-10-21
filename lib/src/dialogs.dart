import 'package:flutter/material.dart' as m;

class DialogService {
  static DialogService? _instance;
  static DialogService get instance => _instance ??= DialogService();

  Future<T?> showDialog<T>({
    required m.BuildContext context,
    required m.WidgetBuilder builder,
    bool barrierDismissible = true,
    m.Color? barrierColor = m.Colors.black54,
    String? barrierLabel,
    bool useSafeArea = false,
    bool useRootNavigator = true,
    m.RouteSettings? routeSettings,
  }) {
    return m.showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        barrierColor: barrierColor,
        barrierLabel: barrierLabel,
        useSafeArea: useSafeArea,
        useRootNavigator: useRootNavigator,
        builder: (ctx) {
          return m.Builder(builder: builder);
        });
  }
}
