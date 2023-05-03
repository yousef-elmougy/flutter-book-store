import 'package:flutter/material.dart';

class PaginationWidget extends StatefulWidget {
  const PaginationWidget({
    super.key,
    required this.onScrollEnd,
    required this.child,
  });

  final void Function() onScrollEnd;
 
  final Widget Function(
    BuildContext context,
    ScrollController controller,
  ) child;

  @override
  State<PaginationWidget> createState() => _PaginationWidgetState();
}

class _PaginationWidgetState extends State<PaginationWidget> {
  final controller = ScrollController();
  
  @override
  void initState() {
    super.initState();
    controller.addListener(_onScroll);
  }

  void _onScroll() {
    final currentPosition = controller.position.pixels;
    final maxPosition = controller.position.maxScrollExtent;
    if (currentPosition == maxPosition) {
      widget.onScrollEnd();
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller
      ..removeListener(_onScroll)
      ..dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child(context,controller);
}
