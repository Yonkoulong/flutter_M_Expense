// ignore_for_file: prefer_const_constructor, prefer_const_constructors, use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import '../../sqflite/database_helper.dart';
import '../../models/trip_entity.dart';
import '../trip/trip_view.dart';

class AddAndEditTrip extends StatefulWidget {
  AddAndEditTrip({Key? key, this.theTrip}) : super(key: key);

  TripEntity? theTrip;

  @override
  State<AddAndEditTrip> createState() => _AddAndEditTripState();
}

class _AddAndEditTripState extends State<AddAndEditTrip> {
  // _AddAndEditTripState() {
  //   _selectedTripName = _tripList[0];
  // }

  final _tripList = [
    "Conference",
    "Client meeting",
    "Holiday",
    "Visiting",
    "Discovery",
    "Interview"
  ];

  String _selectedTripName = "";
  String _tripNameRequire = "";
  String _tripDateValidate = "";
  String _riskRequire = "";

  bool isSwitched = false;
  bool isFlag = false;

  final TextEditingController _dateTime = TextEditingController();
  final TextEditingController _destination = TextEditingController();
  final TextEditingController _description = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    widget.theTrip ??= TripEntity.newTrip(
        _tripList[0], '', '', "false", ''); //if null, assign empty trip
    _selectedTripName = widget.theTrip!.tripName == ""
        ? _tripList[0]
        : widget.theTrip!.tripName;
    _destination.text = widget.theTrip!.destination;
    _dateTime.text = widget.theTrip!.tripDate;
    isSwitched = widget.theTrip!.riskAssessment.toLowerCase() == 'true';
    _description.text = widget.theTrip!.description;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double fontSize = 18;
    return Scaffold(
        appBar: AppBar(
          title: widget.theTrip?.id == null
              ? Text('Add a New Trip')
              : Text('Edit Trip'),
          actions: buildMenus,
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //trip name
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: DropdownButtonFormField(
                          value: _selectedTripName,
                          items: _tripList
                              .map((String value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  ))
                              .toList(),
                          onChanged: (String? val) {
                            setState(() {
                              _selectedTripName = val!;
                            });
                          },
                          icon: const Icon(
                            Icons.arrow_drop_down_circle,
                            color: Colors.lightBlueAccent,
                          ),
                          dropdownColor: Colors.white,
                          decoration: InputDecoration(
                              labelText: "Trip Name",
                              border: OutlineInputBorder()),
                        ),
                      ),

                      //Trip Destination
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextFormField(
                            validator: requiredField,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: _destination,
                            decoration: InputDecoration(
                                labelText: "Destination",
                                icon: Icon(Icons.place_outlined)),
                          )),

                      // Date and time trip
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          validator: requiredField,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _dateTime,
                          decoration: InputDecoration(
                            labelText: "Date",
                            icon: Icon(Icons.calendar_today_rounded),
                          ),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101));

                            if (pickedDate == null) return;
                            setState(() {
                              _dateTime.text =
                                  DateFormat('dd-MM-yyyy').format(pickedDate);
                            });
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text('Risk Assessment'),
                      ),

                      //Risk assessment
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        child: LiteRollingSwitch(
                          value: isSwitched,
                          textOn: "Yes",
                          textOff: "No",
                          colorOn: Colors.blueAccent,
                          colorOff: Colors.blue.shade100,
                          iconOn: Icons.done,
                          iconOff: Icons.warning_amber_outlined,
                          textSize: 18.0,
                          onChanged: (bool position) => {isSwitched = position},
                          onTap: () => {},
                          onDoubleTap: () => {},
                          onSwipe: () => {},
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 170, 0),
                        child: Text(_riskRequire,
                            style: TextStyle(
                                color: Color.fromARGB(255, 206, 61, 61))),
                      ),

                      // Description
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: TextFormField(
                            controller: _description,
                            decoration: InputDecoration(
                                labelText: "Description",
                                icon: Icon(Icons.description)),
                          )),

                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(300, 60)),
                              onPressed: _saveTrip,
                              child: Text(widget.theTrip?.id == null ? "Create" : "Save",
                                  style: TextStyle(fontSize: fontSize))))
                    ],
                  ))),
        ));
  }

  List<Widget> get buildMenus {
    var d = <Widget>[];
    if (widget.theTrip!.id != null) {
      d.add(IconButton(
          onPressed: deleteTrip,
          icon: const Icon(Icons.delete_outline_rounded)));
      d.add(Padding(padding: const EdgeInsets.symmetric(horizontal: 5)));
    }
    return d;
  }

  _saveTrip() async {
    if (_formKey.currentState!.validate() && handleValidateField()) {
      setState(() {
        //close keyboard
        var currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      });

      TripEntity updateTrip = TripEntity.newTrip(
          _selectedTripName,
          _destination.text,
          _dateTime.text,
          isSwitched.toString(),
          _description.text);

      var tripId = widget.theTrip!.id;
      try {
        if (tripId == null) {
          await DatabaseHelper.instance.add(updateTrip);
        } else {
          await DatabaseHelper.instance.update(TripEntity(
              tripId,
              _selectedTripName,
              _destination.text,
              _dateTime.text,
              isSwitched.toString(),
              _description.text));
        }
      } catch (e) {
        rethrow;
      } finally {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TripView(),
          ),
        );
      }
    }
  }

  handleValidateField() {
    // if (_selectedTripName == _tripList[0]) {
    //   _tripNameRequire = 'Please select trip name';
    //   isFlag = false;
    if (isSwitched == false) {
      setState(() => {_riskRequire = 'This field is require'});
      isFlag = false;
    } else {
      return isFlag = true;
    }
  }

  @override
  void dispose() {
    //dispose all fields
    _destination.dispose();
    _dateTime.dispose();
    _description.dispose();

    super.dispose();
  }

  String? requiredField(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field can not be empty';
    }
    return null;
  }

  void deleteTrip() async {
    var tripId = widget.theTrip!.id;
    try {
      if (tripId != null) {
        await DatabaseHelper.instance.remove(tripId);
      }
    } catch (e) {
      rethrow;
    } finally {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => new TripView(),
        ),
      );
    }
  }
}
