import 'package:flutter/material.dart';
import 'app_state.dart';

class EventForm extends StatefulWidget {
  @override
  _EventFormState createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  final TextEditingController _controller =
      TextEditingController(text: 'Dart Click');

  void onPress() {
    AppState.of(context)
      ..analytics.logEvent(name: _controller.text)
      ..setMessage('Event sent.');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(r'Event',
            textScaleFactor: 1.2,
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        TextField(
            decoration: InputDecoration(
                filled: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                labelText: 'Event Name'),
            controller: _controller),
        RaisedButton(child: const Text('Send Event'), onPressed: onPress)
      ],
    );
  }
}
