import 'package:globe_env/globe_env.dart';
import 'package:test/test.dart';

void main() {
  group('GlobeEnv', () {
    late Map<String, String> testEnv;

    setUp(() {
      testEnv = {};
      GlobeEnv.setEnv(testEnv);
    });

    tearDown(() {
      GlobeEnv.clearEnv();
    });

    test('port returns default 8080 when not set', () {
      expect(GlobeEnv.port, equals(8080));
    });

    test('port returns parsed value when set', () {
      testEnv['PORT'] = '3000';
      expect(GlobeEnv.port, equals(3000));
    });

    test('port returns default 8080 when invalid value is set', () {
      testEnv['PORT'] = 'invalid';
      expect(GlobeEnv.port, equals(8080));
    });

    test('isGlobe returns true when GLOBE=1', () {
      testEnv['GLOBE'] = '1';
      expect(GlobeEnv.isGlobeRuntime, isTrue);
    });

    test('isGlobe returns false when GLOBE is not set', () {
      expect(GlobeEnv.isGlobeRuntime, isFalse);
    });

    test('isGlobe returns false when GLOBE is set to other value', () {
      testEnv['GLOBE'] = '0';
      expect(GlobeEnv.isGlobeRuntime, isFalse);
    });

    test('hostname returns null when not set', () {
      expect(GlobeEnv.hostname, isNull);
    });

    test('hostname returns value when set', () {
      testEnv['HOSTNAME'] = 'test-host';
      expect(GlobeEnv.hostname, equals('test-host'));
    });

    test('cronName returns null when not set', () {
      expect(GlobeEnv.cronName, isNull);
    });

    test('cronName returns value when set', () {
      testEnv['CRON_NAME'] = 'test-cron';
      expect(GlobeEnv.cronName, equals('test-cron'));
    });

    test('cronSchedule returns null when not set', () {
      expect(GlobeEnv.cronSchedule, isNull);
    });

    test('cronSchedule returns value when set', () {
      testEnv['CRON_SCHEDULE'] = '* * * * *';
      expect(GlobeEnv.cronSchedule, equals('* * * * *'));
    });

    test('cronId returns null when not set', () {
      expect(GlobeEnv.cronId, isNull);
    });

    test('cronId returns value when set', () {
      testEnv['CRON_ID'] = 'test-id';
      expect(GlobeEnv.cronId, equals('test-id'));
    });

    test('cronEventId returns null when not set', () {
      expect(GlobeEnv.cronEventId, isNull);
    });

    test('cronEventId returns value when set', () {
      testEnv['CRON_EVENT_ID'] = 'test-event-id';
      expect(GlobeEnv.cronEventId, equals('test-event-id'));
    });

    test('datasource returns null when not set', () {
      expect(GlobeEnv.datasource, isNull);
    });

    test('datasource returns Uri when set', () {
      testEnv['GLOBE_DS_API'] = 'https://test.example.com';
      expect(
        GlobeEnv.datasource,
        equals(Uri.parse('https://test.example.com')),
      );
    });
  });
}
