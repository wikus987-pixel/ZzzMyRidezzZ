import 'package:ride_share_supa/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'button3_model.dart';
export 'button3_model.dart';

class Button3Widget extends StatefulWidget {
  const Button3Widget({
    super.key,
    this.icon,
    bool? iconPresent,
    this.iconEnd,
    bool? iconEndPresent,
    String? content,
    String? variant,
    String? size,
    bool? fullWidth,
    bool? loading,
    bool? disabled,
  })  : iconPresent = iconPresent ?? false,
        iconEndPresent = iconEndPresent ?? false,
        content = content ?? 'Save Changes',
        variant = variant ?? 'primary',
        size = size ?? 'large',
        fullWidth = fullWidth ?? true,
        loading = loading ?? false,
        disabled = disabled ?? false;

  final Widget? icon;
  final bool iconPresent;
  final Widget? iconEnd;
  final bool iconEndPresent;
  final String content;
  final String variant;
  final String size;
  final bool fullWidth;
  final bool loading;
  final bool disabled;

  @override
  State<Button3Widget> createState() => _Button3WidgetState();
}

class _Button3WidgetState extends State<Button3Widget> {
  late Button3Model _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => Button3Model());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
