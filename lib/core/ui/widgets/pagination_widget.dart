import 'package:flutter/material.dart';

class PaginationWidget extends StatefulWidget {
  const PaginationWidget({
    super.key,
    required this.index,
    required this.length,
    required this.onLoadMore,
    required this.loadingWidget,
    required this.itemWidget,
  });

  final int index;
  final int length;
  final VoidCallback onLoadMore;
  final Widget loadingWidget;
  final Widget itemWidget;

  @override
  State<PaginationWidget> createState() => _PaginationWidgetState();
}

class _PaginationWidgetState extends State<PaginationWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.index < widget.length) {
      if (widget.index == widget.length - 2) {
        widget.onLoadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return (widget.index < widget.length)
        ? widget.itemWidget
        : widget.loadingWidget;
  }
}
