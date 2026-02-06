import 'dart:async';

import 'package:assignments/models/assignment_session.dart';
import 'package:assignments/services/storage_service.dart';

class SessionRepository {
  static const _key = 'sessions_v1';

  final StorageService _storage = StorageService.instance;
  List<AcademicSession> _cache = [];
  bool _loaded = false;

  final _controller = StreamController<List<AcademicSession>>.broadcast();

  Stream<List<AcademicSession>> get stream => _controller.stream;

  Future<void> _ensureLoaded() async {
    if (_loaded) return;
    await _storage.init();
    _cache = _storage.getJsonList<AcademicSession>(
      _key,
      (m) => AcademicSession.fromMap(m),
    );
    _loaded = true;
  }

  Future<List<AcademicSession>> getAll() async {
    await _ensureLoaded();
    return List.unmodifiable(_cache);
  }

  Future<void> _persist() async {
    await _storage.setJsonList(_key, _cache.map((s) => s.toMap()).toList());
    _controller.add(List.unmodifiable(_cache));
  }

  Future<void> upsert(AcademicSession session) async {
    await _ensureLoaded();
    final idx = _cache.indexWhere((x) => x.id == session.id);
    if (idx >= 0) {
      _cache[idx] = session;
    } else {
      _cache.add(session);
    }
    await _persist();
  }

  Future<void> delete(String id) async {
    await _ensureLoaded();
    _cache.removeWhere((x) => x.id == id);
    await _persist();
  }

  Future<void> toggleAttendance(String id) async {
    await _ensureLoaded();
    final idx = _cache.indexWhere((x) => x.id == id);
    if (idx >= 0) {
      _cache[idx].attended = !(_cache[idx].attended ?? false);
      await _persist();
    }
  }

  Future<List<AcademicSession>> getToday() async {
    await _ensureLoaded();
    final now = DateTime.now();
    return _cache
        .where(
          (s) =>
              s.date.year == now.year &&
              s.date.month == now.month &&
              s.date.day == now.day,
        )
        .toList();
  }

  Future<List<AcademicSession>> getForDay(DateTime day) async {
    await _ensureLoaded();
    return _cache
        .where(
          (s) =>
              s.date.year == day.year &&
              s.date.month == day.month &&
              s.date.day == day.day,
        )
        .toList();
  }
}
