import 'package:core_domain/core_domain.dart';
import 'package:core_state/src/features/locale/repositories/locale_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeLocalStorage implements ILocalStorage {
  final Map<String, Object?> _store = {};

  @override
  Future<void> clear() async => _store.clear();

  @override
  bool containsKey({required String key}) => _store.containsKey(key);

  @override
  Future<void> delete({required String key}) async => _store.remove(key);

  @override
  T? read<T>({required String key}) => _store[key] as T?;

  @override
  Future<void> write<T>({required String key, required T value}) async {
    _store[key] = value;
  }
}

void main() {
  group('LocaleRepositoryImpl', () {
    late _FakeLocalStorage storage;
    late LocaleRepositoryImpl repository;

    setUp(() {
      storage = _FakeLocalStorage();
      repository = LocaleRepositoryImpl(localStorage: storage);
    });

    test('hasPreference is false before first save', () async {
      expect(await repository.hasPreference(), isFalse);
    });

    test('hasPreference is true after save', () async {
      await repository.save(const Locale('en'));
      expect(await repository.hasPreference(), isTrue);
    });

    test('read returns null when no value is stored', () async {
      expect(await repository.read(), isNull);
    });

    test('save and read English locale', () async {
      await repository.save(const Locale('en'));
      expect(await repository.read(), const Locale('en'));
      expect(storage.read<String>(key: 'locale_code'), 'en');
    });

    test('save and read Indonesian locale', () async {
      await repository.save(const Locale('id'));
      expect(await repository.read(), const Locale('id'));
      expect(storage.read<String>(key: 'locale_code'), 'id');
    });

    test('save null persists system preference', () async {
      await repository.save(const Locale('en'));
      await repository.save(null);
      expect(await repository.read(), isNull);
      expect(storage.read<String>(key: 'locale_code'), 'system');
    });

    test('read returns null for unknown stored code', () async {
      await storage.write(key: 'locale_code', value: 'fr');
      expect(await repository.read(), isNull);
    });
  });
}
