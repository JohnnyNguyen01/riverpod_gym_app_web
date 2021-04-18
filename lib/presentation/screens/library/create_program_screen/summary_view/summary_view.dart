import 'package:adonis_web_test/config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SummaryView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Expanded(
      flex: 1,
      child: Material(
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: [_buildWeekColumn(context)],
        ),
      ),
    );
  }

  Widget _buildWeekColumn(BuildContext context) {
    return LayoutBuilder(builder: (context, dimensions) {
      return dimensions.maxWidth > 252
          ? Container(
              width: dimensions.maxWidth,
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Card(
                elevation: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Day', style: kPageHeading),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (int i = 1; i <= 7; i++)
                          _BuildNumberButton(number: i)
                      ],
                    ),
                    TextButton(
                      child: Text('maxWidth'),
                      onPressed: () => print(dimensions.maxWidth),
                    )
                  ],
                ),
              ),
            )
          : Container();
    });
  }
}

class _BuildNumberButton extends StatefulWidget {
  final int number;
  _BuildNumberButton({@required this.number});
  @override
  __BuildNumberButtonState createState() => __BuildNumberButtonState();
}

class __BuildNumberButtonState extends State<_BuildNumberButton> {
  Color _containerColor = Colors.transparent;
  Color _textColor = Colors.black;
  bool _isSelected = false;

  void _handleOnTap() {
    setState(() {
      _isSelected = !_isSelected;
      if (_isSelected) {
        _containerColor = Colors.black;
        _textColor = Colors.white;
      } else {
        _containerColor = Colors.transparent;
        _textColor = Colors.black;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _handleOnTap,
        child: AnimatedContainer(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _containerColor,
          ),
          duration: const Duration(seconds: 1),
          curve: Curves.linear,
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            widget.number.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 22).copyWith(color: _textColor),
          ),
        ),
      ),
    );
  }
}
