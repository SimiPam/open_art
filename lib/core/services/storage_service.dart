import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  SharedPreferences _storage;
  final Map<String, BehaviorSubject<String>> _store =
      <String, BehaviorSubject<String>>{};

  Future<void> initStorage() async {
    _storage = await SharedPreferences.getInstance();
    return;
  }

  void _initItem(String key) {
    if (_store[key] == null) {
      _store[key] = BehaviorSubject<String>();
    }

    final String val = getItemSync(key);
    if (val != null) {
      _store[key].add(val);
    }
  }

  String getItemSync(String key) {
    final String val = (_storage.get(key) ?? '').toString();

    return val;
  }

  Stream<String> getItem(String key) {
    _initItem(key);
    return _store[key];
  }

  Stream<List<String>> getItems(List<String> keys) {
    final List<Stream<String>> subjs =
        keys.map((String e) => getItem(e)).toList();
    return CombineLatestStream<String, List<String>>(
        subjs, (List<String> res) => res);
  }

  Future<bool> setItem(String key, String value) {
    _initItem(key);
    _store[key].add(value);

    return _storage.setString(key, value);
  }

  Future<bool> setItems(Map<String, String> data) async {
    final List<Future<bool>> futures = <Future<bool>>[];

    data.forEach((String key, String value) {
      futures.add(setItem(key, value));
    });

    await Future.wait(futures);
    return true;
  }

  Future<bool> removeItem(String key) {
    _initItem(key);
    _store[key].add(null);

    return _storage.remove(key);
  }

  Future<bool> removeItems(List<String> keys) async {
    final List<Future<bool>> futures = <Future<bool>>[];

    for (int a = 0; a < keys.length; a++) {
      futures.add(removeItem(keys.elementAt(a)));
    }

    await Future.wait(futures);

    return true;
  }
}
