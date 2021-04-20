import 'package:adonis_web_test/config/config.dart';
import 'package:adonis_web_test/presentation/screens/library/create_program_screen/summary_view/week_row_button.dart';
import 'package:flutter/material.dart';

class WeekRow extends StatefulWidget {
  final int sessions;
  final int weekNumber;
  WeekRow({@required this.sessions, @required this.weekNumber});

  @override
  _WeekRowState createState() => _WeekRowState();
}

class _WeekRowState extends State<WeekRow> {
  int _weekNumber;
  List<WeekRowButton> buttons = [];
  int _selectedWeekRowBtn;

  @override
  void initState() {
    super.initState();
    _weekNumber = widget.weekNumber;
    _setButtonsList();
  }

  ///Only used during initState to obtain buttons List;
  void _setButtonsList() {
    for (int i = 1; i <= widget.sessions; i++) {
      buttons.add(WeekRowButton(
        week: _weekNumber,
        sessionNumber: i,
        onTap: () => setSelectedWeekRowBtn(index: i),
      ));
    }
  }

  int setSelectedWeekRowBtn({@required int index}) {
    setState(() {
      _selectedWeekRowBtn = index;
    });
    return _selectedWeekRowBtn;
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return LayoutBuilder(builder: (context, dimensions) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Week $_weekNumber',
              style: kTableHeading.copyWith(fontSize: 20),
            ),
            Container(
              width: dimensions.maxWidth,
              height: 30,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: widget.sessions,
                  itemBuilder: (context, index) {
                    return buttons[index];
                  }),
            ),
          ],
        ),
      );
    });
  }
}
