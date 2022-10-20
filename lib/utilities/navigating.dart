import 'package:flutter/material.dart';

void spPush({required BuildContext context, required Widget screen}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
  );
}

void spPop({required BuildContext context}) {
  Navigator.pop(context);
}

void spLoader({
  required BuildContext context,
  required Widget loader,
}) {
  Navigator.of(context).push(PageRouteBuilder(
    opaque: false,
    pageBuilder: (BuildContext context, _, __) => loader,
  ));
}
