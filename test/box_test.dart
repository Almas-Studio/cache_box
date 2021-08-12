import 'dart:io';

import 'package:hive/hive.dart';
import 'package:cache_box/cache_box.dart';
import 'package:test/test.dart';

void main() {
  group('box tests', () {
    test('box test', () async{
        var box = await Hive.openBox('htest', path: Directory.current.path);

        final value = {'name':'ali','last':'memezade'};

        await box.put('json', value);

        final saved = box.get('json');

        expect(saved, equals(value));

        await box.deleteFromDisk();
    });
    test('writing test', () async {
      final key = 'wtest';
      final testValue = 'testValue101';
      final cacheBox = await CacheBox.open(key, path: Directory.current.path);

      await cacheBox.put(key, testValue);
      final cached = await cacheBox.get<String>(key).first;

      expect(cached, equals(testValue));
      await cacheBox.delete();
    });
    test('listening test', () async {
      final key = 'ltest';
      final cacheBox = await CacheBox.open(key, path: Directory.current.path);
      await cacheBox.put(key, 'default');

      final output = [];
      var stream = cacheBox.get<String>(key, defaultValue: 'k_default');
      stream.listen(output.add);

      await Future.delayed(Duration(milliseconds: 20));
      await cacheBox.put(key, 'v2');
      await Future.delayed(Duration(milliseconds: 20));
      await cacheBox.put(key, 'v3');

      expect(output, equals(['default', 'v2', 'v3']));
      await cacheBox.delete();
    });
  });
}
