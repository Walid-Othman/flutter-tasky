import 'package:flutter/material.dart';

enum ActionEnum {
  edit(name: "edit"),
  delete(name: "delete");

  final name;
  const ActionEnum({required this.name});
}
