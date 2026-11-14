import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ToDoEntryLoading extends StatelessWidget {
  const ToDoEntryLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Text('Loading'),
      ),
    );
  }
}
