import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:shipmyfix/search_widget.dart';
import 'package:shipmyfix/ship_part_card.dart';
import 'package:shipmyfix/ship_part_dto.dart';
import 'package:shipmyfix/ship_part_list.dart';

class CreateAppointmentRoute extends StatefulWidget {
  @override
  _CreateAppointmentRouteState createState() => _CreateAppointmentRouteState();
}

class _CreateAppointmentRouteState extends State<CreateAppointmentRoute> {
  int _currentStepIndex = 0;

  Future<List<ShipPartDTO>> _shipPartsResponse;
  List<ShipPartDTO> shipParts;
  List<ShipPartDTO> shipPartsSearchResults;

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
                  setState(() {
                    _currentStepIndex = index;
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

  TextEditingController _textEditingController = TextEditingController();

  _onSearchTextChanged(String txt) {
    shipPartsSearchResults.clear();
    if (txt.isEmpty) {
      setState(() {});
      return;
    }

    setState(() {
      shipParts.forEach((item) {
        if (item.partName.toLowerCase().contains(txt.toLowerCase()))
          shipPartsSearchResults.add(item);
      });
    });
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
                  shipParts = snapshot.data;
                  return _buildListOfParts();
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListOfParts() {
    if (_textEditingController.text.isNotEmpty &&
        shipPartsSearchResults.isEmpty) {
      return Container(
        child: Text('No ship parts that match your search term found.'),
      );
    }

    if (shipPartsSearchResults.isNotEmpty) {
      return ListView.separated(
        padding: const EdgeInsets.all(3.0),
        shrinkWrap: true,
        itemCount: shipPartsSearchResults.length,
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemBuilder: (context, index) {
          return ShipPartCard(shipPartsSearchResults[index]);
        },
      );
    } else {
      return ListView.separated(
        padding: const EdgeInsets.all(3.0),
        shrinkWrap: true,
        itemCount: shipParts.length,
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemBuilder: (context, index) {
          return ShipPartCard(shipParts[index]);
        },
      );
    }
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
          child: _buildClockWidget(context),
        ),
      ),
    ];
  }

  _nextStep() {
    setState(() {
      _currentStepIndex++;
    });
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
}
