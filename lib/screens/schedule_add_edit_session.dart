import 'package:flutter/material.dart';
import '../models/schedule_data.dart';

// this screen is used to add or edit a session
class AddEditSessionScreen extends StatefulWidget {
  final AcademicSession? session;

  const AddEditSessionScreen({super.key, this.session});

  @override
  State<AddEditSessionScreen> createState() => _AddEditSessionScreenState();
}

class _AddEditSessionScreenState extends State<AddEditSessionScreen> {
  final titleController = TextEditingController();
  final locationController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  String sessionType = 'class';

  @override
  void initState() {
    super.initState();

    if (widget.session != null) {
      titleController.text = widget.session!.title;
      locationController.text = widget.session!.location;
      selectedDate = widget.session!.date;
      startTime = widget.session!.startTime;
      endTime = widget.session!.endTime;
      sessionType = widget.session!.type;
    }
  }

  String formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0a1a33),
      appBar: AppBar(
        backgroundColor: const Color(0xff0a1a33),
        title: const Text('session', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'session title',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white54),
                ),
              ),
            ),

            TextField(
              controller: locationController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: 'location',
                labelStyle: TextStyle(color: Colors.white70),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white54),
                ),
              ),
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2030),
                );

                if (date != null) {
                  setState(() {
                    selectedDate = date;
                  });
                }
              },
              child: const Text('select date'),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'selected date: ${formatDate(selectedDate)}',
                style: const TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: startTime,
                );

                if (time != null) {
                  setState(() {
                    startTime = time;
                  });
                }
              },
              child: const Text('start time'),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'start time: ${startTime.format(context)}',
                style: const TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () async {
                final time = await showTimePicker(
                  context: context,
                  initialTime: endTime,
                );

                if (time != null) {
                  setState(() {
                    endTime = time;
                  });
                }
              },
              child: const Text('end time'),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'end time: ${endTime.format(context)}',
                style: const TextStyle(color: Colors.white),
              ),
            ),

            const SizedBox(height: 15),

            DropdownButton<String>(
              value: sessionType,
              dropdownColor: const Color(0xff0a1a33),
              style: const TextStyle(color: Colors.white),
              items: const [
                DropdownMenuItem(value: 'class', child: Text('class')),
                DropdownMenuItem(
                  value: 'study group',
                  child: Text('study group'),
                ),
                DropdownMenuItem(
                  value: 'mastery session',
                  child: Text('mastery session'),
                ),
                DropdownMenuItem(
                  value: 'psl meeting',
                  child: Text('psl meeting'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  sessionType = value!;
                });
              },
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (titleController.text.isEmpty) return;

                  Navigator.pop(
                    context,
                    AcademicSession(
                      title: titleController.text,
                      date: selectedDate,
                      startTime: startTime,
                      endTime: endTime,
                      type: sessionType,
                      location: locationController.text,
                    ),
                  );
                },
                child: const Text('save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
