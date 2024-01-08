import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

typedef _OnWidgetSizeChange = void Function(Size? size);

class MTMeasureSize extends StatefulWidget {
  const MTMeasureSize({
    Key? key,
    required this.onSizeChange,
    required this.child,
  }) : super(key: key);
  final Widget? child;
  final _OnWidgetSizeChange onSizeChange;

  @override
  _MTMeasureSizeState createState() => _MTMeasureSizeState();
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
