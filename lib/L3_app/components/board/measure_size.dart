import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class MTMeasureSize extends StatefulWidget {
  const MTMeasureSize({
    super.key,
    required this.onSizeChange,
    required this.child,
  });
  final Widget? child;
  final void Function(Size? size) onSizeChange;

  @override
  State<StatefulWidget> createState() => _MTMeasureSizeState();
}

class _MTMeasureSizeState extends State<MTMeasureSize> {
  var widgetKey = GlobalKey();
  Size? oldSize;

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final context = widgetKey.currentContext;
      if (context == null) {
        return;
      }

      final newSize = context.size;
      if (oldSize != newSize) {
        widget.onSizeChange(newSize);
        oldSize = newSize;
      }
    });
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }
}
