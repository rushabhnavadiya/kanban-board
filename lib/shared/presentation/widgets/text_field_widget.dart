import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:take_home_challenge_innoscripta/core/styles/app_colors.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController? controller;
  final TextStyle? textStyle;
  final String? hintText;
  final TextStyle? hintStyle;
  final double? borderRadius;
  final Color? borderColor;
  final double? borderWidth;
  final Function(String? value)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final AutovalidateMode? autoValidateMode;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? minLines;
  final EdgeInsets? contentPadding;
  final double? height;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const TextFieldWidget({
    Key? key,
    this.controller,
    this.textStyle,
    this.hintText,
    this.hintStyle,
    this.borderRadius,
    this.borderColor,
    this.borderWidth,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.autoValidateMode,
    this.focusNode,
    this.inputFormatters,
    this.maxLines,
    this.minLines,
    this.contentPadding,
    this.height,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    double defaultBorderWidth = 0.5;
    double defaultBorderRadius = 6;
    Color defaultColor = AppColors.boardHeader;
    TextStyle hintStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
      color: AppColors.boardHeader,
    );

    TextStyle textStyle = Theme.of(context).textTheme.bodyLarge!;
    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      validator: widget.validator,
      autovalidateMode: widget.autoValidateMode ?? AutovalidateMode.onUserInteraction,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      cursorColor: Theme.of(context).iconTheme.color,
      style: widget.textStyle ?? textStyle,
      inputFormatters: widget.inputFormatters,
      maxLines: widget.maxLines ?? 1,
      minLines: widget.minLines,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        contentPadding: widget.contentPadding ?? const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
        hintText: widget.hintText,
        hintStyle: widget.hintStyle ?? hintStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              widget.borderRadius ?? defaultBorderRadius),
          borderSide: BorderSide(
            color: widget.borderColor ?? defaultColor,
            width: widget.borderWidth ?? defaultBorderWidth,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              widget.borderRadius ?? defaultBorderRadius),
          borderSide: BorderSide(
            color: widget.borderColor ?? defaultColor,
            width: widget.borderWidth ?? defaultBorderWidth,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              widget.borderRadius ?? defaultBorderRadius),
          borderSide: const BorderSide(
            color: AppColors.red,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
              widget.borderRadius ?? defaultBorderRadius),
          borderSide: BorderSide(
            color: widget.borderColor ?? defaultColor,
            width: widget.borderWidth ?? defaultBorderWidth,
          ),
        ),
      ),
    );
  }
}