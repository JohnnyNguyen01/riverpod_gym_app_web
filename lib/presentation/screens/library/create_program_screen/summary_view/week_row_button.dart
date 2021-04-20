import 'package:adonis_web_test/states/workout_program/selected_week_session_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeekRowButton extends StatefulWidget {
  int week;
  int sessionNumber;
  // bool isSelected;
  Function onTap;

  WeekRowButton(
      {@required this.week,
      @required this.sessionNumber,
      // @required this.isSelected,
      @required this.onTap});

  @override
  _WeekRowButtonState createState() => _WeekRowButtonState();
}

class _WeekRowButtonState extends State<WeekRowButton> {
  bool _isSelected = false;

  void handleOnTap() {
    int selectedSession = widget.onTap();
    setState(() {
      if (selectedSession == widget.sessionNumber) {
        _isSelected = true;
        print('week ${widget.week}, session ${widget.sessionNumber} selected');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Consumer(builder: (context, watch, child) {
        return GestureDetector(
          onTap: () {
            handleOnTap();
            final stateNotifier =
                context.read(selectedWeekSessionStateProivder.notifier);
            stateNotifier.setSelectedWeekSession(
                week: widget.week, sessionNumber: widget.sessionNumber);
            print(context.read(selectedWeekSessionStateProivder));
          },
          child: AnimatedContainer(
            width: 30,
            height: 30,
            margin: EdgeInsets.only(right: 10.0),
            color: _isSelected ? Colors.black : Colors.transparent,
            // decoration: BoxDecoration(shape: BoxShape.circle),
            duration: const Duration(seconds: 1),
            child: Text(
              '${widget.sessionNumber}',
              style:
                  TextStyle(color: _isSelected ? Colors.white : Colors.black),
            ),
          ),
        );
      }),
    );
  }
}
