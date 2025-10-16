import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pro_mobile/constants/app_colors.dart';
import 'package:pro_mobile/ui/widgets/action_button.dart';
import 'package:pro_mobile/ui/widgets/custom_app_bar.dart';
import 'package:pro_mobile/ui/widgets/padded_container.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({super.key});

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
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
    _monday = now.subtract(Duration(days: now.weekday - 1));
    _friday = _monday.add(const Duration(days: 4));
  }

  void _generateSlotsFor(DateTime date) {
    final random = Random();
    final slots = <Map<String, dynamic>>[];

    // Mock hourly slots between 9AM–5PM
    for (int hour = 10; hour < 20; hour++) {
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
      appBar: customAppBer("Schedule Accountability Call"),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDay,
            firstDay: _monday,
            lastDay: _friday,
            calendarFormat: CalendarFormat.week,
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              leftChevronVisible: false,
              rightChevronVisible: false,
            ),
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: AppColors.secondary,
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
                      onTap:
                          available
                              ? () {
                                setState(() {
                                  _selectedSlot = slot;
                                });
                              }
                              : null,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        decoration: BoxDecoration(
                          color:
                              available
                                  ? (isSelected
                                      ? Colors.orangeAccent
                                      : Colors.greenAccent.shade100)
                                  : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color:
                                isSelected
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
            PaddedContainer(
              child: ActionButton(
                title: "Schedule",
                onTap: () {
                  final start = _selectedSlot!['start'];
                  final end = _selectedSlot!['end'];

                  print(" selected start ======================> $start");
                  print(" selected end ======================> $end");

                  // Navigator.pushNamed(context, AppRouter.successPage);
                },
              ),
            ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
