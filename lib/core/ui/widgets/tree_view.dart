import 'dart:developer';

import 'package:flutter/material.dart';

class TreeView extends InheritedWidget {
  final List<Widget> children;
  final bool startExpanded;

  TreeView({
    Key? key,
    required this.children,
    this.startExpanded = false,
  }) : super(
          key: key,
          child: _TreeViewData(
            children: children,
          ),
        );

  static TreeView? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TreeView>();
  }

  @override
  bool updateShouldNotify(TreeView oldWidget) {
    if (oldWidget.children == children && oldWidget.startExpanded == startExpanded) {
      return false;
    }
    return true;
  }
}

class _TreeViewData extends StatelessWidget {
  final List<Widget>? children;

  const _TreeViewData({
    this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children!.map((e) => e).toList(),
    );
  }
}

class TreeViewChild extends StatefulWidget {
  final bool? startExpanded;
  final Widget parent;
  final List<Widget> children;
  final VoidCallback? onParentTapped;
  final EdgeInsetsGeometry? parentPadding;
  final EdgeInsetsGeometry? childPadding;
  final bool enableTapping;

  const TreeViewChild({
    super.key,
    required this.parent,
    required this.children,
    this.startExpanded = false,
    this.enableTapping = true,
    this.parentPadding,
    this.childPadding,
    this.onParentTapped,
  });

  @override
  TreeViewChildState createState() => TreeViewChildState();
}

class TreeViewChildState extends State<TreeViewChild> with SingleTickerProviderStateMixin {
  late ValueNotifier<bool> isExpanded;

  @override
  void initState() {
    super.initState();
    isExpanded = ValueNotifier(widget.startExpanded!);
  }

  @override
  void didChangeDependencies() {
    isExpanded.value = widget.startExpanded ?? TreeView.of(context)!.startExpanded;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: widget.enableTapping
              ? widget.onParentTapped != null
                  ? () {
                      widget.onParentTapped!();
                      toggleExpanded();
                    }
                  : () => toggleExpanded()
              : null,
          child: Padding(
            padding: widget.parentPadding ?? const EdgeInsets.all(0),
            child: widget.parent,
          ),
        ),
        ValueListenableBuilder<bool>(
            valueListenable: isExpanded,
            builder: (context, value, _) {
              log(value.toString());
              return AnimatedSize(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeIn,
                child: AnimatedSwitcher(
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeIn,
                  duration: const Duration(milliseconds: 400),
                  child: value
                      ? Padding(
                          padding: widget.childPadding ?? const EdgeInsets.all(8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: widget.children,
                          ),
                        )
                      : Container(),
                ),
              );
            }),
      ],
    );
  }

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
  }
}
