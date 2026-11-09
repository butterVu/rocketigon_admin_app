import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Builds the cell at [index] of a [CodeInput].
///
/// [digit] is `null` while the cell is empty. [isActive] is `true` for the
/// cell receiving the next digit while the input has focus.
typedef CodeCellBuilder =
    Widget Function(
      BuildContext context,
      int index,
      String? digit,
      bool isActive,
    );

/// Nền tảng cho các ô nhập mã số (OTP, mã mở khoá).
///
/// Một `TextField` ẩn nhận dữ liệu từ bàn phím, [cellBuilder] vẽ từng ô.
class CodeInput extends StatefulWidget {
  /// Tạo [CodeInput].
  const CodeInput({
    super.key,
    required this.length,
    required this.cellBuilder,
    this.spacing = 12,
    this.controller,
    this.focusNode,
    this.autofocus = true,
    this.enabled = true,
    this.autofillHints,
    this.onChanged,
    this.onCompleted,
  });

  /// Số chữ số của mã.
  final int length;

  /// Vẽ từng ô.
  final CodeCellBuilder cellBuilder;

  /// Khoảng cách giữa các ô.
  final double spacing;

  /// Controller chứa mã đã nhập, dùng để đọc hoặc xoá mã.
  final TextEditingController? controller;

  /// Focus node của ô nhập ẩn.
  final FocusNode? focusNode;

  /// Tự động mở bàn phím khi hiển thị.
  final bool autofocus;

  /// Cho phép nhập hay không.
  final bool enabled;

  /// Gợi ý tự điền, ví dụ `AutofillHints.oneTimeCode`.
  final Iterable<String>? autofillHints;

  /// Gọi mỗi khi mã thay đổi.
  final ValueChanged<String>? onChanged;

  /// Gọi khi đã nhập đủ [length] chữ số.
  final ValueChanged<String>? onCompleted;

  @override
  State<CodeInput> createState() => _CodeInputState();
}

class _CodeInputState extends State<CodeInput> {
  TextEditingController? _ownedController;
  FocusNode? _ownedFocusNode;

  TextEditingController get _controller =>
      widget.controller ?? (_ownedController ??= TextEditingController());

  FocusNode get _focusNode =>
      widget.focusNode ?? (_ownedFocusNode ??= FocusNode());

  @override
  void initState() {
    super.initState();
    _controller.addListener(_refresh);
    _focusNode.addListener(_refresh);
  }

  @override
  void didUpdateWidget(CodeInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldController = oldWidget.controller ?? _ownedController;
    final oldFocusNode = oldWidget.focusNode ?? _ownedFocusNode;
    if (oldController != _controller) {
      oldController?.removeListener(_refresh);
      _controller.addListener(_refresh);
    }
    if (oldFocusNode != _focusNode) {
      oldFocusNode?.removeListener(_refresh);
      _focusNode.addListener(_refresh);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_refresh);
    _focusNode.removeListener(_refresh);
    _ownedController?.dispose();
    _ownedFocusNode?.dispose();
    super.dispose();
  }

  void _refresh() => setState(() {});

  void _handleChanged(String code) {
    widget.onChanged?.call(code);
    if (code.length == widget.length) widget.onCompleted?.call(code);
  }

  @override
  Widget build(BuildContext context) {
    final code = _controller.text;
    final activeIndex = math.min(code.length, widget.length - 1);
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var index = 0; index < widget.length; index++)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: widget.spacing / 2),
                child: widget.cellBuilder(
                  context,
                  index,
                  index < code.length ? code[index] : null,
                  _focusNode.hasFocus && index == activeIndex,
                ),
              ),
          ],
        ),
        Positioned.fill(
          child: Opacity(
            opacity: 0,
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              autofocus: widget.autofocus,
              enabled: widget.enabled,
              keyboardType: TextInputType.number,
              autofillHints: widget.autofillHints,
              showCursor: false,
              enableInteractiveSelection: false,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(widget.length),
              ],
              decoration: const InputDecoration.collapsed(hintText: null),
              onChanged: _handleChanged,
            ),
          ),
        ),
      ],
    );
  }
}
