import 'package:flutter/material.dart';
import 'package:obm_market/constants/app_theme.dart';

class StepProgress extends StatelessWidget {
  const StepProgress({
    Key? key,
    required this.curStep,
    required this.steppers,
  }) : super(key: key);

  final int curStep;
  final List<StepItem> steppers;

  @override
  Widget build(BuildContext context) {
    return _buildHorizontal(context);
  }

  Widget _buildHorizontal(BuildContext context) {
    final List<Widget> stepPanels = <Widget>[];
    for (int i = 0; i < steppers.length; i += 1) {
      stepPanels.add(
        Visibility(
          maintainState: true,
          visible: i+1 == curStep,
          child: steppers[i].content,
        ),
      );
    }

    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16.0, right: 20.0),
              child: Row(children: _stepViews())
            ),
            SizedBox(height: 1.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _stepTitleViews()
            ),
            Container(
              height: 0.5,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 4.0, bottom: 1.0),
              color: AppTheme.grey.withOpacity(0.6),
            )
          ],
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(top: 10.0),
            children: <Widget>[
              AnimatedSize(
                curve: Curves.fastOutSlowIn,
                duration: kThemeAnimationDuration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: stepPanels
                ),
              ),
             // _buildControls(context, curStep)
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _stepViews() {
    var list = <Widget>[];

    steppers.asMap().forEach((i, steppe) {
      var circleColor = (i == 0 || curStep > i) ? AppTheme.primary : AppTheme.darkerText.withOpacity(0.7);
      var lineColor = curStep > i+1 ? AppTheme.primary : AppTheme.darkerText.withOpacity(0.7);

      list.add(
        Container(
          width: 35.0,
          height: 35.0,
          padding: EdgeInsets.all(0),
          alignment: Alignment.center,
          child: Text(
            steppe.number,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: (i == 0 || curStep > i) ? AppTheme.white : AppTheme.primary,
              fontSize: 15.0,
              fontWeight: FontWeight.w600
            ),
          ),
          decoration: BoxDecoration(
            color: (i == 0 || curStep > i) ? circleColor : AppTheme.white,
            borderRadius: const BorderRadius.all(Radius.circular(25.0)),
            border: Border.all(
              color: (i == 0 || curStep > i) ? AppTheme.primary : AppTheme.darkerText.withOpacity(0.7),
              width: 3.0
            ),
          ),
        ),
      );

      if (i != steppers.length - 1) {
        list.add(
          Expanded(
            child: Container(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              height: 5.0,
              color: lineColor
            )
          )
        );
      }
    });

    return list;
  }

  List<Widget> _stepTitleViews() {
    var list = <Widget>[];
    steppers.asMap().forEach((i, steppe) {
      list.add(
        Container(
          padding: EdgeInsets.only(right: 18.0, left: 7.0, bottom: 5.0),
          child: Text(
            steppe.title,
            style: TextStyle(
              color: AppTheme.dark_grey,
              fontWeight: FontWeight.w600,
              fontSize: 10.0,
              letterSpacing: 0.3
            )
          ),
        )
      );
    });

    return list;
  }
}

class StepItem {
  const StepItem({
    Key? key,
    required this.title,
    required this.content,
    required this.number,
    this.state = StepState.indexed,
    this.isActive = false,
  });

  final String title;
  final String number;
  final Widget content;
  final StepState state;
  final bool isActive;
}