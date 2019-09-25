import 'package:flutter/material.dart';

class DeviceNameEntryView extends StatefulWidget {
  @override
  _DeviceNameEntryViewState createState() => _DeviceNameEntryViewState();
}

class _DeviceNameEntryViewState extends State<DeviceNameEntryView> {
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
              height: MediaQuery.of(context).size.height * 0.85,
              child: getBodyWidget(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget getBodyWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Name your device",
            style: TextStyle(fontSize: 20, color: Colors.white70),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Enter the name of the device you're installing",
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Device Name',
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
