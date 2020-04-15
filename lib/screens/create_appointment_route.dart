import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:shipmyfix/search_widget.dart';
import 'package:shipmyfix/components/ship_parts/model/ship_part_dto.dart';
import 'package:shipmyfix/components/ship_parts/ship_part_list.dart';
import 'package:shipmyfix/searchable_listview.dart';

const kLastStep = 1; //this could be extracted in a constants file

class CreateAppointmentRoute extends StatefulWidget {
  @override
  _CreateAppointmentRouteState createState() => _CreateAppointmentRouteState();
}

class _CreateAppointmentRouteState extends State<CreateAppointmentRoute> {
  int _currentStepIndex = 0;
  String _chosenTime;

  Future<List<ShipPartDTO>> _shipPartsResponse;
  List<ShipPartDTO> _shipParts;
  List<ShipPartDTO> shipPartsSearchResults;

  TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    shipPartsSearchResults = [];
    _shipPartsResponse = ShipPartList().loadAssets();
  }

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
                currentStep: _currentStepIndex,
                onStepTapped: (index) {
                  if (_validateStep()) {
                    setState(() {
                      _currentStepIndex = index;
                    });
                  }
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
                            child: _currentStepIndex == 0
                                ? Text('Cancel')
                                : Text('Back'),
                            onPressed: onStepCancel,
                          ),
                          RaisedButton(
                            elevation: 5,
                            color: Colors.teal,
                            child: _currentStepIndex == 1
                                ? Text('Finish')
                                : Text('Continue'),
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

  List<Step> _buildListOfSteps() {
    return [
      Step(
        title: _currentStepIndex == 0 ? Text('Choose the part(s)') : Text(''),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: _buildListOfPartsWidget(),
        ),
      ),
      Step(
        title: _currentStepIndex == 1 ? Text('Pick a date!') : Text(''),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: _buildDateTimePickerWidget(context),
        ),
      ),
    ];
  }

  _buildDateTimePickerWidget(BuildContext context) {
    //todo: can be moved to another file not for bloating this one and for readability
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

  _buildListOfPartsWidget() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SearchWidget(_textEditingController, _onSearchTextChanged),
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: FutureBuilder(
              future: _shipPartsResponse,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _shipParts = snapshot.data;
                  return SearchableListView(_shipParts, _textEditingController,
                      ListCardType.SHIP_PART);
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }

  _nextStep() {
    if (_validateStep()) {
      setState(() {
        if (_currentStepIndex != kLastStep) {
          //last step
          _currentStepIndex++;
        } else {
          //todo create appointment:
          //todo this can be implemented using the Provider package, so it would be visible across the widget tree
          //todo then Navigator.pop()
        }
      });
    }
  }

  _previousStep() {
    if (_currentStepIndex == 0) {
      Navigator.pop(context);
      return;
    }
    setState(() {
      _currentStepIndex--;
    });
  }

  bool _validateStep() {
    return (_shipParts.where((i) => i.shipPartCounter >= 1).length > 0) ||
        (shipPartsSearchResults.where((i) => i.shipPartCounter >= 1).length >
            0);
  }

  _onSearchTextChanged(String txt) {
    setState(() {});
  }
}
