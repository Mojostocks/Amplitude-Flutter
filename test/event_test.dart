import 'package:flutter_test/flutter_test.dart';

import 'package:amplitude_flutter/src/event.dart';

void main() {
  group('Event', () {
    Event subject;

    setUp(() {
      subject = Event('Event Unit Test');
    });

    group('default constructor', () {
      test('adds the passed props if any', () {
        expect(subject.props, isEmpty);

        subject =
            Event('some props', props: <String, dynamic>{'cohort': 'test a'});

        expect(subject.props, containsPair('cohort', 'test a'));
      });
    });

    group('.addProps', () {
      setUp(() {
        subject.addProps(<String, dynamic>{'preexisting': 'data'});
        expect(subject.props, hasLength(1));
      });

      test('handles null props', () {
        subject.addProps(null);
        expect(subject.props, hasLength(1));
      });

      test('adds to existing props', () {
        subject.addProps(<String, dynamic>{'key a': 'value a'});
        expect(subject.props, hasLength(2));

        subject.addProps(<String, dynamic>{'key b': 'value b'});
        expect(subject.props, hasLength(3));

        expect(
            subject.props,
            equals(<String, dynamic>{
              'preexisting': 'data',
              'key a': 'value a',
              'key b': 'value b'
            }));
      });
    });

    group('.toPayload', () {
      test('properly formats an API payload', () {
        subject = Event('click', sessionId: '123', props: <String, dynamic>{
          'user_properties': {'cohort': 'test a'}
        })
          ..timestamp = 12345;

        expect(
            subject.toPayload(),
            equals(<String, dynamic>{
              'event_type': 'click',
              'session_id': '123',
              'timestamp': 12345,
              'user_properties': {'cohort': 'test a'}
            }));
      });
    });
  });
}