import 'package:flutter/material.dart';

class EmptyLoader extends StatelessWidget {
  final Widget? loadingIndicator;
  const EmptyLoader({
    super.key,
    this.loadingIndicator,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        body: Center(
          child: loadingIndicator ??
              const CircularProgressIndicator(color: Colors.white),
        ),
      ),
    );
  }
}
