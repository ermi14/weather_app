import 'package:coopah_frontend_dev_task/presentation/theme.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.cornerRadius,
    super.key,
  });

  final VoidCallback? onPressed;
  final Widget child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? cornerRadius;

  @override
  Widget build(BuildContext context) {
    final elevatedTheme = Theme.of(context).elevatedButtonTheme.style!;
    final shape = elevatedTheme.shape?.resolve({WidgetState.selected});
    final theme = Theme.of(context);

    final elevatedTextStyle = elevatedTheme.textStyle!
        .resolve({WidgetState.selected})!.copyWith(color: foregroundColor);

    return Material(
      shape: shape,
      clipBehavior: Clip.antiAlias,
      elevation: elevatedTheme.elevation!.resolve({WidgetState.selected})!,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          color: backgroundColor ?? theme.colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cornerRadius ?? 100),
          ),
        ),
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: AppPaddings.hx2.add(
              const EdgeInsets.symmetric(
                vertical: AppPaddings.baseSpace * 2.2,
              ),
            ),
            child: DefaultTextStyle(
              style: elevatedTextStyle.copyWith(
                fontSize: 16,
              ),
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}
