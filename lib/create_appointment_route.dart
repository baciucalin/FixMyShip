import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class CreateAppointmentRoute extends StatefulWidget {
  @override
  _CreateAppointmentRouteState createState() => _CreateAppointmentRouteState();
}

class _CreateAppointmentRouteState extends State<CreateAppointmentRoute> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create an appointment'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Stepper(
                type: StepperType.horizontal,
                steps: _buildListOfSteps(),
                currentStep: _index,
                onStepTapped: (index) {
                  setState(() {
                    _index = index;
                  });
                },
                onStepCancel: () {
                  _previousStep();
                },
                onStepContinue: () {
                  _nextStep();
                },
                controlsBuilder: (BuildContext context,
                    {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                  return Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          SizedBox(
                            height: 80,
                          ),
                          RaisedButton(
                            elevation: 5,
                            color: Colors.blueGrey,
                            child: _index == 0 ? Text('Cancel') : Text('Back'),
                            onPressed: onStepCancel,
                          ),
                          RaisedButton(
                            elevation: 5,
                            color: Colors.teal,
                            child:
                                _index == 1 ? Text('Finish') : Text('Continue'),
                            onPressed: onStepContinue,
                          )
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _chosenTime;

  _buildClockWidget(BuildContext context) {
    return Container(
      child: Center(
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 5,
          child: _chosenTime != null
              ? Text('Date chosen: $_chosenTime')
              : Text('Choose a date'),
          onPressed: () {
            DatePicker.showDateTimePicker(context,
                theme: DatePickerTheme(
                  containerHeight: 220.0,
                ),
                minTime: DateTime.now(),
                maxTime: DateTime.now().add(Duration(days: 30)),
                showTitleActions: true, onConfirm: (time) {
              print('confirm $time');
              _chosenTime =
                  '${time.day}/${time.month}/${time.year} ${time.hour}:${time.minute}';
              setState(() {});
            }, currentTime: DateTime.now(), locale: LocaleType.en);
            setState(() {});
          },
        ),
      ),
    );
  }

  List<Step> _buildListOfSteps() {
    return [
      Step(
        title: _index == 0 ? Text('Choose the part(s)') : Text(''),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Text('step1'),
        ),
      ),
      Step(
        title: _index == 1 ? Text('Pick a date!') : Text(''),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: _buildClockWidget(context),
        ),
      ),
    ];
  }

  _nextStep() {
    setState(() {
      _index++;
    });
  }

  _previousStep() {
    if (_index == 0) {
      Navigator.pop(context);
      return;
    }
    setState(() {
      _index--;
    });
  }
}
