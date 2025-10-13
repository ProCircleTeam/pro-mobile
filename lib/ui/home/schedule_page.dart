import 'dart:math';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class WeeklySchedulePage extends StatefulWidget {
  const WeeklySchedulePage({super.key});

  @override
  State<WeeklySchedulePage> createState() => _WeeklySchedulePageState();
}

class _WeeklySchedulePageState extends State<WeeklySchedulePage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late DateTime _monday;
  late DateTime _friday;

  List<Map<String, dynamic>> _slots = [];
  Map<String, dynamic>? _selectedSlot;

  @override
  void initState() {
    super.initState();
    _calculateWeekRange();
    _generateSlotsFor(DateTime.now());
  }

  void _calculateWeekRange() {
    final now = DateTime.now();
    _monday = now.subtract(Duration(days: now.weekday - 1)); // Monday
    _friday = _monday.add(const Duration(days: 4)); // Friday
  }

  void _generateSlotsFor(DateTime date) {
    final random = Random();
    final slots = <Map<String, dynamic>>[];

    // Mock hourly slots between 9AM–5PM
    for (int hour = 9; hour < 17; hour++) {
      bool isAvailable = random.nextBool();
      slots.add({
        'start': DateTime(date.year, date.month, date.day, hour, 0),
        'end': DateTime(date.year, date.month, date.day, hour + 1, 0),
        'available': isAvailable,
      });
    }

    setState(() {
      _slots = slots;
      _selectedSlot = null;
    });
  }

  String _formatTimeRange(DateTime start, DateTime end) {
    String formatTime(DateTime t) =>
        "${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}";
    return "${formatTime(start)} - ${formatTime(end)}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Schedule Meeting"),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: _monday,
            lastDay: _friday,
            calendarFormat: CalendarFormat.week, // Show only week view
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.indigoAccent,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
            selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              _generateSlotsFor(selectedDay);
            },
          ),
          const SizedBox(height: 16),
          if (_selectedDay == null)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Select a day (Mon–Fri) to view available slots",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          else
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  itemCount: _slots.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.8,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    final slot = _slots[index];
                    final available = slot['available'] as bool;
                    final isSelected = _selectedSlot == slot;

                    return GestureDetector(
                      onTap: available
                          ? () {
                              setState(() {
                                _selectedSlot = slot;
                              });
                            }
                          : null,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        decoration: BoxDecoration(
                          color: available
                              ? (isSelected
                                  ? Colors.orangeAccent
                                  : Colors.greenAccent.shade100)
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? Colors.deepOrange
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            _formatTimeRange(slot['start'], slot['end']),
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: available ? Colors.black87 : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          if (_selectedSlot != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  final start = _selectedSlot!['start'];
                  final end = _selectedSlot!['end'];
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        "Meeting scheduled from ${_formatTimeRange(start, end)} on ${_selectedDay!.toLocal().toString().split(' ')[0]}"),
                  ));
                },
                icon: const Icon(Icons.calendar_today),
                label: const Text("Confirm Meeting"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigoAccent,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
