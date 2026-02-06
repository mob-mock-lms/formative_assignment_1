import 'package:assignments/models/user_profile.dart';
import 'package:assignments/services/storage_service.dart';

class UserRepository {
  static const _key = 'user_profile_v1';
  final StorageService _storage = StorageService.instance;

  Future<UserProfile?> load() async {
    await _storage.init();
    return _storage.getJson<UserProfile>(_key, (m) => UserProfile.fromMap(m));
  }

  Future<void> save(UserProfile profile) async {
    await _storage.setJson(_key, profile.toMap());
  }

  Future<void> clear() async {
    await _storage.remove(_key);
  }
}
