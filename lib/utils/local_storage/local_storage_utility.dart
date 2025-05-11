import 'package:get_storage/get_storage.dart';

class LocalStorageUtility {
  late final GetStorage _storage;
  static LocalStorageUtility? _instance;
  LocalStorageUtility._internal();
  factory LocalStorageUtility.instance() {
    return _instance ??= LocalStorageUtility._internal();
  }
  static Future<void> init(String bucketName) async {
    await GetStorage.init(bucketName);
    _instance = LocalStorageUtility._internal();
    _instance!._storage=GetStorage(bucketName);
  }

  //Generic Method to save data
  void saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  //Generic Method to remove data
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  Future<void> clearAll() async {
    await _storage.erase();
  }
}
