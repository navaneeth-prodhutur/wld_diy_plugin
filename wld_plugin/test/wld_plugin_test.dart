import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wld_plugin/wld_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('wld_plugin');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

}
