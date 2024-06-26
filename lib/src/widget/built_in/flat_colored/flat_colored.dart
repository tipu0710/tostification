import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toastification/src/widget/built_in/built_in.dart';
import 'package:toastification/src/widget/built_in/flat_colored/flat_colored_style.dart';
import 'package:toastification/src/widget/built_in/widget/undo_button.dart';

class FlatColoredToastWidget extends StatelessWidget {
  const FlatColoredToastWidget({
    super.key,
    required this.type,
    this.title,
    this.description,
    this.primaryColor,
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
    this.brightness,
    this.padding,
    this.borderRadius,
    this.borderSide,
    this.boxShadow,
    this.direction,
    this.onCloseTap,
    this.showCloseButton,
    this.showProgressBar = false,
    this.applyBlurEffect = false,
    this.progressBarValue,
    this.progressBarWidget,
    this.progressIndicatorTheme,
    this.undoButtontextStyle,
    this.undoButtonBackgroundColor,
  });

  final ToastificationType type;

  final Widget? title;
  final Widget? description;

  final Widget? icon;

  final MaterialColor? primaryColor;

  final MaterialColor? backgroundColor;

  final Color? foregroundColor;

  final Brightness? brightness;

  final EdgeInsetsGeometry? padding;

  final BorderRadiusGeometry? borderRadius;

  final BorderSide? borderSide;

  final List<BoxShadow>? boxShadow;

  final TextDirection? direction;

  final VoidCallback? onCloseTap;
  final TextStyle? undoButtontextStyle;
  final Color? undoButtonBackgroundColor;

  final bool? showCloseButton;

  final bool showProgressBar;
  final bool applyBlurEffect;
  final double? progressBarValue;
  final Widget? progressBarWidget;

  final ProgressIndicatorThemeData? progressIndicatorTheme;

  FlatColoredStyle get defaultStyle => FlatColoredStyle(type);

  @override
  Widget build(BuildContext context) {
    final iconColor = primaryColor ?? defaultStyle.iconColor(context);

    final background = backgroundColor ?? defaultStyle.backgroundColor(context);

    final showCloseButton = this.showCloseButton ?? true;

    final borderRadius =
        this.borderRadius ?? defaultStyle.borderRadius(context);

    final borderSide = this.borderSide ??
        defaultStyle.borderSide(context).copyWith(color: primaryColor);

    final direction = this.direction ?? Directionality.of(context);

    return Directionality(
      textDirection: direction,
      child: IconTheme(
        data: Theme.of(context).primaryIconTheme.copyWith(color: iconColor),
        child: buildBody(
          context: context,
          background: background,
          borderRadius: borderRadius,
          borderSide: borderSide,
          iconColor: iconColor,
          showCloseButton: showCloseButton,
          applyBlurEffect: applyBlurEffect,
        ),
      ),
    );
  }

  Widget buildBody({
    required BuildContext context,
    required Color background,
    required BorderRadiusGeometry borderRadius,
    required BorderSide borderSide,
    required Color iconColor,
    required bool showCloseButton,
    required bool applyBlurEffect,
  }) {
    Widget body = Container(
      constraints: const BoxConstraints(minHeight: 64),
      decoration: BoxDecoration(
        color: applyBlurEffect ? background.withOpacity(0.5) : background,
        borderRadius: borderRadius,
        border: Border.fromBorderSide(borderSide),
        boxShadow: boxShadow ?? defaultStyle.boxShadow(context),
      ),
      padding: padding ?? defaultStyle.padding(context),
      child: Row(
        children: [
          icon ??
              Icon(
                defaultStyle.icon(context),
                size: 24,
                color: iconColor,
              ),
          const SizedBox(width: 12),
          Expanded(
            child: BuiltInContent(
              style: defaultStyle,
              title: title,
              description: description,
              primaryColor: primaryColor,
              foregroundColor: foregroundColor,
              backgroundColor: backgroundColor,
              showProgressBar: showProgressBar,
              progressBarValue: progressBarValue,
              progressBarWidget: progressBarWidget,
              progressIndicatorTheme: progressIndicatorTheme,
            ),
          ),
          const SizedBox(width: 8),
          UndoButton(
            showUndoButton: showCloseButton,
            onUndoTap: onCloseTap,
            textStyle: undoButtontextStyle,
            backgroundColor: undoButtonBackgroundColor ??
                defaultStyle.undoButtonColor(context),
          ),
        ],
      ),
    );

    if (applyBlurEffect) {
      body = ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: body,
        ),
      );
    }

    return body;
  }
}
