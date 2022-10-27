import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  final ShapeBorder? shape;
  final Color? iconColor;
  final Text? title;
  final Text? subtitle;
  final Function? onTap;
  final IconData? leadingIconData;
  final Widget? trailing;
  final Widget? leading;

  const ListTileWidget(
      {Key? key,
      this.onTap,
      this.shape,
      this.iconColor,
      this.title,
      this.subtitle,
      this.leadingIconData,
      this.leading,
      this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      iconColor: iconColor ?? Theme.of(context).colorScheme.primary,
      shape: shape ??
          RoundedRectangleBorder(
            side: BorderSide(
              color: Theme.of(context).colorScheme.outline,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
      onTap: onTap != null ? onTap as VoidCallback : null,
      leading: leadingIconData != null
          ? CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.surface,
              child: Icon(
                leadingIconData,
                color: Theme.of(context).colorScheme.primary,
              ),
            )
          : leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing ?? const Icon(Icons.arrow_forward_ios),
    );
  }
}
