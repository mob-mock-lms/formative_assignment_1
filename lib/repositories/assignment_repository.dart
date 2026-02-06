import 'dart:async';

import 'package:assignments/models/assignment.dart';
import 'package:assignments/services/storage_service.dart';

class AssignmentRepository {
  static const _key = 'assignments_v1';

  final StorageService _storage = StorageService.instance;
  List<Assignment> _cache = [];
  bool _loaded = false;

  final _controller = StreamController<List<Assignment>>.broadcast();

  Stream<List<Assignment>> get stream => _controller.stream;

  Future<void> _ensureLoaded() async {
    if (_loaded) return;
    await _storage.init();
    _cache = _storage.getJsonList<Assignment>(
      _key,
      (m) => Assignment.fromMap(m),
    );
    _loaded = true;
  }

  Future<List<Assignment>> getAll() async {
    await _ensureLoaded();
    return List.unmodifiable(_cache);
  }

  Future<void> _persist() async {
    await _storage.setJsonList(_key, _cache.map((a) => a.toMap()).toList());
    _controller.add(List.unmodifiable(_cache));
  }

  Future<void> upsert(Assignment a) async {
    await _ensureLoaded();
    final idx = _cache.indexWhere((x) => x.id == a.id);
    if (idx >= 0) {
      _cache[idx] = a;
    } else {
      _cache.add(a);
    }
    _cache.sort((x, y) => x.dueDate.compareTo(y.dueDate));
    await _persist();
  }

  Future<void> delete(String id) async {
    await _ensureLoaded();
    _cache.removeWhere((x) => x.id == id);
    await _persist();
  }

  Future<void> toggleComplete(String id) async {
    await _ensureLoaded();
    final idx = _cache.indexWhere((x) => x.id == id);
    if (idx >= 0) {
      _cache[idx].isCompleted = !_cache[idx].isCompleted;
      await _persist();
    }
  }

  Future<List<Assignment>> getToday() async {
    await _ensureLoaded();
    final now = DateTime.now();
    return _cache
        .where(
          (a) =>
              a.dueDate.year == now.year &&
              a.dueDate.month == now.month &&
              a.dueDate.day == now.day,
        )
        .toList();
  }

  Future<List<Assignment>> getForDay(DateTime day) async {
    await _ensureLoaded();
    return _cache
        .where(
          (a) =>
              a.dueDate.year == day.year &&
              a.dueDate.month == day.month &&
              a.dueDate.day == day.day,
        )
        .toList();
  }

  Future<Map<DateTime, int>> getCountsByDayInMonth(DateTime month) async {
    await _ensureLoaded();
    final start = DateTime(month.year, month.month, 1);
    final end = DateTime(
      month.year,
      month.month + 1,
      1,
    ).subtract(const Duration(days: 1));
    final map = <DateTime, int>{};
    for (final a in _cache) {
      if (a.dueDate.isBefore(start) || a.dueDate.isAfter(end)) continue;
      final key = DateTime(a.dueDate.year, a.dueDate.month, a.dueDate.day);
      map[key] = (map[key] ?? 0) + 1;
    }
    return map;
  }
}
