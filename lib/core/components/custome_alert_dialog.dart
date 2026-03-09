import 'package:flutter/material.dart';
import 'package:to_do_app/core/enums/action_enum.dart';

class CustomeAlertDialog extends StatelessWidget {
  CustomeAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.actionName,
    required this.actionType,
    required this.onPress,
  });
  final String title;
  final String content;
  final String actionName;
  final ActionEnum actionType;
  final VoidCallback onPress;
  Color get actionColor => switch (actionType) {
    ActionEnum.delete => Color(0xFFe63946),
    ActionEnum.edit => Color(0xFF15886c),
  };

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(actionColor),
          ),
          onPressed: () {
            onPress();
          },
          child: Text(actionName),
        ),
      ],
    );
  }
}
