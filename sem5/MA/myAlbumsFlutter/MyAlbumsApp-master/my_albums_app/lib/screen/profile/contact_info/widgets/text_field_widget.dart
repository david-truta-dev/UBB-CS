import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:my_albums_app/screen/profile/contact_info/contact_info_view_model.dart';
import 'package:my_albums_app/screen/profile/contact_info/validator.dart';

import '../../../../theming/dimensions.dart';

class TextFieldWidget extends StatefulWidget {
  final MyField field;

  const TextFieldWidget.fromField({Key? key, required this.field})
      : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  InputDecoration _getInputDecoration([String? title]) {
    final border = UnderlineInputBorder(
      borderSide: BorderSide(
          color: widget.field.error == ValidationError.none
              ? Theme.of(context).primaryColor
              : Theme.of(context).errorColor,
          width: textFieldBorderThickness),
    );
    return InputDecoration(
        contentPadding: noPadding,
        floatingLabelStyle: Theme.of(context).textTheme.labelMedium,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        label: title != null
            ? Text(
                title,
                style: widget.field.error == ValidationError.none
                    ? Theme.of(context).textTheme.labelMedium
                    : TextStyle(color: Theme.of(context).errorColor),
              )
            : null,
        enabledBorder: border,
        focusedBorder: border);
  }

  String _buildStringFromValidationError(
      BuildContext context, ValidationError error) {
    switch (error) {
      case ValidationError.required:
        return AppLocalizations.of(context)!.required;
      case ValidationError.lettersOnly:
        return AppLocalizations.of(context)!.lettersOnly;
      case ValidationError.digitsOnly:
        return AppLocalizations.of(context)!.digitsOnly;
      case ValidationError.invalidStreet:
        return AppLocalizations.of(context)!.invalidStreet;
      case ValidationError.invalidEmail:
        return AppLocalizations.of(context)!.invalidEmail;
      default:
        return AppLocalizations.of(context)!.unknown;
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.field.focusNode?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          controller: widget.field.controller,
          keyboardType: widget.field.textInputType,
          style: Theme.of(context).textTheme.labelSmall,
          decoration: _getInputDecoration(widget.field.title),
          onEditingComplete: () {
            if (widget.field.toFocus != null) {
              widget.field.toFocus!.requestFocus();
            }
          },
          focusNode: widget.field.focusNode,
          onChanged: (str) {
            setState(() {
              widget.field.error = ValidationError.none;
            });
          },
        ),
        if (widget.field.error != ValidationError.none)
          IgnorePointer(
            ignoring: true,
            child: Column(
              children: [
                normalVerticalDistance,
                Text(
                  _buildStringFromValidationError(context, widget.field.error),
                  style: TextStyle(
                    color: Theme.of(context).errorColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
