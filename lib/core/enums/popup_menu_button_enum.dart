import 'package:flutter/material.dart';

enum PopupMenuButtonEnum {
  markAsDone,
  edit,
  delete;

  // const PopupMenuButtonEnum({required this.name});
  //  final String name;
   String getDisplayName(bool isComplete) {
    switch (this) {
      case PopupMenuButtonEnum.edit:
        return 'Edit';
      case PopupMenuButtonEnum.delete:
        return 'Delete';
      case PopupMenuButtonEnum.markAsDone:
        return isComplete ? 'Mark As Undone' : 'Mark As Done';
    }
  }
}
