import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class SelfAssessmentPage extends StatefulWidget {
  @override
  _SelfAssessmentPageState createState() => _SelfAssessmentPageState();
}

class _SelfAssessmentPageState extends State<SelfAssessmentPage> {
  var _tested;
  var _fever = false;
  var _cough = false;
  var _breathing = false;
  var _days = 1.0;
  var _confirm = false;
  var _loading = false;
  var _step = 0;

  @override
  Widget build(BuildContext context) {
    var enableContinue = false;

    switch (_step) {
      case 0:
        enableContinue = _tested != null;
        break;
      case 1:
        enableContinue = _fever || _cough || _breathing;
    }

    var textTheme = Theme.of(context).textTheme;
    var stepTextTheme = textTheme.subtitle1;
    var bodyText = textTheme.subtitle1.merge(TextStyle(height: 1.4));

    var assessmentSteps = <Step>[
      Step(
        isActive: _step == 0,
        state: _step > 0 ? StepState.complete : StepState.indexed,
        title: Text(
          'Official Testing',
          style: textTheme.headline6,
        ),
        content: Column(
          children: <Widget>[
            Text('Have you tested positive for COVID-19?',
                style: stepTextTheme),
            ...['Tested Positive', 'Tested Negative', 'Pending', 'Not Tested']
                .map(
                  (e) => ListTileTheme(
                    contentPadding: EdgeInsets.all(0),
                    child: RadioListTile(
                      controlAffinity: ListTileControlAffinity.platform,
                      groupValue: _tested,
                      title: Text(e),
                      onChanged: (e) {
                        setState(() => _tested = e);
                        if (e == 'Tested Positive') {
                          setState(() => _confirm = true);
                        }
                      },
                      value: e,
                    ),
                  ),
                )
                .toList()
          ],
        ),
      ),
      Step(
        isActive: _step == 1,
        state: _step > 1 ? StepState.complete : StepState.indexed,
        title: Text(
          'Symptoms',
          style: textTheme.headline6,
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('What symptoms are you experiencing?', style: stepTextTheme),
            ListTileTheme(
                contentPadding: EdgeInsets.all(0),
                child: CheckboxListTile(
                  value: _fever,
                  onChanged: (selected) => setState(() => _fever = selected),
                  title: Text('Fever (38°C or above)'),
                )),
            ListTileTheme(
                contentPadding: EdgeInsets.all(0),
                child: CheckboxListTile(
                  value: _cough,
                  onChanged: (selected) => setState(() => _cough = selected),
                  title: Text('Dry cough'),
                )),
            ListTileTheme(
                contentPadding: EdgeInsets.all(0),
                child: CheckboxListTile(
                  value: _breathing,
                  onChanged: (selected) =>
                      setState(() => _breathing = selected),
                  title: Text('Difficulty breathing'),
                )),
            ListTileTheme(
                contentPadding: EdgeInsets.only(right: 10),
                child: ListTile(
                  title: Text('Days with symptoms'),
                  trailing: Text(
                      '${_days.round() == 10 ? '10+' : _days.round()}',
                      style: textTheme.headline6),
                )),
            Slider.adaptive(
                min: 1,
                max: 10,
                value: _days,
                onChanged: (value) => setState(() => _days = value)),
          ],
        ),
      ),
      Step(
          isActive: _step == 2,
          title: Text(
            'Send Report',
            style: textTheme.headline6,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTileTheme(
                  contentPadding: EdgeInsets.all(0),
                  child: CheckboxListTile(
                    value: _confirm,
                    title: Text(
                        'I confirm that the above information has been entered to the best of my ability',
                        style: textTheme.subtitle1),
                    onChanged: (selected) =>
                        setState(() => _confirm = selected),
                  )),
              ButtonBar(
                alignment: MainAxisAlignment.start,
                children: <Widget>[
                  PlatformButton(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      color: Theme.of(context).buttonTheme.colorScheme.primary,
                      child: _loading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  value: null,
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white)))
                          : Text("Submit"),
                      onPressed: _confirm ? () => null : null),
                  PlatformButton(
                    child: Text('Cancel'),
                    onPressed: () => Navigator.pop(context),
                    androidFlat: (context) => MaterialFlatButtonData(),
                  )
                ],
              )
            ],
          )),
    ];

    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('Self Assessment Tool'),
      ),
      iosContentPadding: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: <Widget>[
            Text(
              'When you report you help others, save lives and end the COVID-19 crisis sooner',
              style: bodyText,
            ),
            Stepper(
                physics: NeverScrollableScrollPhysics(),
                currentStep: _step,
                onStepContinue: () => setState(() => _step++),
                onStepTapped: (index) {
                  if (index < _step) {
                    setState(() => _step = index);
                  }
                },
                onStepCancel: () => _step == 0
                    ? Navigator.pop(context, false)
                    : setState(() => _step--),
                controlsBuilder: (context, {onStepCancel, onStepContinue}) {
                  return _step < 2
                      ? ButtonBar(
                          alignment: MainAxisAlignment.start,
                          children: <Widget>[
                            PlatformButton(
                              color: Theme.of(context)
                                  .buttonTheme
                                  .colorScheme
                                  .primary,
                              onPressed: enableContinue ? onStepContinue : null,
                              child: PlatformText('Continue'),
                            ),
                            PlatformButton(
                              onPressed: onStepCancel,
                              child: PlatformText('Cancel'),
                              androidFlat: (_) => MaterialFlatButtonData(),
                            )
                          ],
                        )
                      : SizedBox.shrink();
                },
                steps: assessmentSteps),
          ],
        ),
      ),
    );
  }
}
