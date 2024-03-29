import 'package:flutter/material.dart';

class LocationEntryView extends StatefulWidget {
  @override
  _LocationEntryViewState createState() => _LocationEntryViewState();
}

class _LocationEntryViewState extends State<LocationEntryView> {
  final _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0x993a93ff),
              Color(0xff3a93ff),
            ],
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
                height: MediaQuery.of(context).size.height * 0.15,
                alignment: Alignment.centerRight,
                child: IconButton(
                    icon: Icon(Icons.close),
                    color: Colors.white,
                    onPressed: () =>
                        Navigator.of(context).pop(_textFieldController.text))),
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: getBodyWidget(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget getBodyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Name your location",
              style: TextStyle(fontSize: 20, color: Colors.white70)),
          SizedBox(height: 10),
          Text(
              "Enter the name for the location where you are installing this device",
              style: TextStyle(fontSize: 16, color: Colors.white70)),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Location Name',
              hintStyle: TextStyle(color: Colors.white30),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white30),
              ),
            ),
            keyboardType: TextInputType.text,
            controller: _textFieldController,
            onSaved: (value) {
              print(value);
            },
          ),
        ],
      ),
    );
  }
}
