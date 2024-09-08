import 'package:flutter/material.dart';

class LoadingProgressWidget extends StatelessWidget {
  final Color color;

  const LoadingProgressWidget({Key? key, this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
