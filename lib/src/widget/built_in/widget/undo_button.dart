import 'package:flutter/material.dart';

class UndoButton extends StatelessWidget {
  const UndoButton({
    super.key,
    this.showUndoButton = true,
    required this.backgroundColor,
    this.onUndoTap,
    this.textStyle,
  });

  final bool showUndoButton;
  final VoidCallback? onUndoTap;
  final Color backgroundColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 60,
      child: IgnorePointer(
        ignoring: !showUndoButton,
        child: AnimatedOpacity(
          opacity: showUndoButton ? 1 : 0,
          duration: const Duration(milliseconds: 200),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5),
            child: Builder(
              builder: (context) {
                return TextButton(
                  onPressed: onUndoTap,
                  style: TextButton.styleFrom(
                    fixedSize: const Size(60, 30),
                    padding: EdgeInsets.zero,
                    backgroundColor: backgroundColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                  child: Text(
                    "Undo",
                    style: textStyle ?? Theme.of(context).textTheme.labelMedium,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
