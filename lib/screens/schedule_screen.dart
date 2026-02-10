import 'package:flutter/material.dart';
import '../models/assignment_session.dart';
import '../utils/storage_service.dart';
import 'schedule_add_edit_session.dart';

// this screen shows schedule in list and calendar view
class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with SingleTickerProviderStateMixin {
  List<AcademicSession> sessions = [];
  bool _isLoading = true;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    _loadSessions();
  }

  // Load sessions from storage
  Future<void> _loadSessions() async {
    final loadedSessions = await StorageService.getSessions();
    setState(() {
      sessions = loadedSessions;
      _isLoading = false;
    });
  }

  // Save sessions to storage
  Future<void> _saveSessions() async {
    await StorageService.saveSessions(sessions);
  }

  // this finds the first day of the current week
  DateTime getWeekStart(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  // this checks if a session is in the current week
  bool isInCurrentWeek(DateTime date) {
    final start = getWeekStart(DateTime.now());
    final end = start.add(const Duration(days: 7));
    return date.isAfter(start.subtract(const Duration(days: 1))) &&
        date.isBefore(end);
  }

  bool isPast(DateTime date) {
    return date.isBefore(DateTime.now());
  }

  bool isUpcoming(DateTime date) {
    return date.isAfter(DateTime.now());
  }

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final weeklySessions = sessions
        .where((s) => isInCurrentWeek(s.date))
        .toList();

    final pastSessions = sessions
        .where((s) => isPast(s.date) && !isInCurrentWeek(s.date))
        .toList();

    final upcomingSessions = sessions
        .where((s) => isUpcoming(s.date) && !isInCurrentWeek(s.date))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xff0a1a33),
      appBar: AppBar(
        backgroundColor: const Color(0xff0a1a33),
        title: const Text(
          "Schedule",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        toolbarHeight: 48,
        bottom: TabBar(
          controller: tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white54,
          indicator: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color.fromARGB(255, 67, 168, 252),
                width: 3,
              ),
            ),
          ),
          dividerColor: Color.fromARGB(73, 104, 133, 165),
          tabs: const [
            Tab(text: 'This Week'),
            Tab(text: 'Calendar'),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xfff5c542),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditSessionScreen(),
            ),
          );

          if (result == null) return;

          if (result['type'] == SessionResultType.save) {
            setState(() {
              sessions.add(result['session']);
            });
            _saveSessions();
          }
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),

      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : TabBarView(
              controller: tabController,
              children: [
                // list tab shows only current week
                weeklySessions.isEmpty
                    ? const Center(
                        child: Text(
                          'No sessions this week',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        itemCount: weeklySessions.length,
                        itemBuilder: (context, index) {
                          final session = weeklySessions[index];

                          return Card(
                            margin: const EdgeInsets.all(10),
                            child: ListTile(
                              title: Text(session.title),
                              subtitle: Text(
                                '${session.sessionType} | ${session.startTime.format(context)} - ${session.endTime.format(context)}',
                              ),
                              trailing: SizedBox(
                                width: 70,
                                child: FittedBox(
                                  child: Column(
                                    children: [
                                      Text(
                                        (session.attended ?? true)
                                            ? 'present'
                                            : 'absent',
                                        style: TextStyle(
                                          color: (session.attended ?? true)
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                      Switch(
                                        value: session.attended ?? true,
                                        onChanged: (value) {
                                          setState(() {
                                            session.attended = value;
                                          });
                                          _saveSessions();
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AddEditSessionScreen(session: session),
                                  ),
                                );

                                if (result == null) return;

                                if (result['type'] ==
                                    SessionResultType.delete) {
                                  setState(() {
                                    sessions.remove(session);
                                  });
                                  _saveSessions();
                                }

                                if (result['type'] == SessionResultType.save) {
                                  setState(() {
                                    final i = sessions.indexOf(session);
                                    sessions[i] = result['session'];
                                  });
                                  _saveSessions();
                                }
                              },
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('cancel session'),
                                    content: const Text(
                                      'do you want to remove this session',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('no'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            sessions.remove(session);
                                          });
                                          _saveSessions();
                                          Navigator.pop(context);
                                        },
                                        child: const Text('yes'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),

                // calendar tab
                sessions.isEmpty
                    ? const Center(
                        child: Text(
                          'You have no sessions',
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      )
                    : ListView(
                        children: [
                          buildCalendarSection('this week', weeklySessions, 1),
                          buildCalendarSection('upcoming', upcomingSessions, 1),
                          buildCalendarSection('past', pastSessions, 0.4),
                        ],
                      ),
              ],
            ),
    );
  }

  // this builds a calendar section with heading outside cards
  Widget buildCalendarSection(
    String title,
    List<AcademicSession> list,
    double opacity,
  ) {
    if (list.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...list.map(
          (s) => Opacity(
            opacity: opacity,
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: ListTile(
                title: Text(s.title),
                subtitle: Text(
                  '${formatDate(s.date)} | ${s.startTime.format(context)} - ${s.endTime.format(context)}',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
