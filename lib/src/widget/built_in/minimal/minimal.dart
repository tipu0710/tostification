import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:toastification/src/widget/built_in/built_in.dart';
import 'package:toastification/src/widget/built_in/widget/undo_button.dart';

import 'minimal_style.dart';

class MinimalToastWidget extends StatelessWidget {
  const MinimalToastWidget({
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
    this.progressBarValue,
    this.progressBarWidget,
    this.progressIndicatorTheme,
    this.applyBlurEffect = false,
    this.undoButtontextStyle,
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

  final VoidCallback? onCloseTap;
  final TextStyle? undoButtontextStyle;

  final TextDirection? direction;

  final bool? showCloseButton;

  final bool applyBlurEffect;

  final bool showProgressBar;
  final double? progressBarValue;
  final Widget? progressBarWidget;

  final ProgressIndicatorThemeData? progressIndicatorTheme;

  MinimalStyle get defaultStyle => MinimalStyle(type);

  @override
  Widget build(BuildContext context) {
    final primary = primaryColor ?? defaultStyle.primaryColor(context);
    final iconColor = primaryColor ?? defaultStyle.iconColor(context);

    final background = backgroundColor ?? defaultStyle.backgroundColor(context);

    final showCloseButton = this.showCloseButton ?? true;

    final direction = this.direction ?? Directionality.of(context);

    final borderRadius =
        (this.borderRadius ?? defaultStyle.borderRadius(context))
            .resolve(direction);

    final borderSide = this.borderSide ?? defaultStyle.borderSide(context);

    return Directionality(
      textDirection: direction,
      child: IconTheme(
        data: Theme.of(context).primaryIconTheme.copyWith(color: iconColor),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 64),
          child: Material(
            color: Colors.transparent,
            shape: LinearBorder.start(
              side: BorderSide(
                color: primary,
                width: 3,
              ),
            ),
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
        ),
      ),
    );
  }

  Widget buildBody({
    required BuildContext context,
    required Color background,
    required BorderRadius borderRadius,
    required BorderSide borderSide,
    required Color iconColor,
    required bool showCloseButton,
    required bool applyBlurEffect,
  }) {
    Widget body = Container(
      decoration: BoxDecoration(
        color: applyBlurEffect ? background.withOpacity(0.5) : background,
        borderRadius: defaultStyle.effectiveBorderRadius(borderRadius),
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
            backgroundColor: defaultStyle.undoButtonColor(context),
          ),
        ],
      ),
    );

    if (applyBlurEffect) {
      body = body = ClipRRect(
        borderRadius: defaultStyle.effectiveBorderRadius(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: body,
        ),
      );
    }

    return body;
  }
}
