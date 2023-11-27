import 'package:fitnessapplication/local_notifications/local_noti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

DateTime scheduledTime = DateTime.now();

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  bool waterReminder = false;
  bool sleepReminder = false;
  bool workoutReminder = false;
  TimeOfDay sleepTime = TimeOfDay.now();
  TimeOfDay workoutTime = TimeOfDay.now();
  @override
  void initState() {
    super.initState();
    loadReminderStates();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminders'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 234, 232, 237),
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 214, 208, 225),
                    Color.fromARGB(255, 205, 188, 237)
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade400,
                        offset: const Offset(2.0, 2.0),
                        blurRadius: 10,
                        spreadRadius: 1),
                    BoxShadow(
                        color: Colors.grey.shade400,
                        offset: const Offset(-2.0, -2.0),
                        blurRadius: 10,
                        spreadRadius: 1),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Water Reminder',
                        style: GoogleFonts.poppins(
                            fontSize: 19, fontWeight: FontWeight.w600),
                      ),
                      Switch(
                        value: waterReminder,
                        onChanged: (value) {
                          setState(() {
                            waterReminder = value;
                            saveReminderStates();
                            if (waterReminder) {
                              NotificationService()
                                  .schedulePeriodicNotification(
                                id: 1,
                                title: 'Drink Water',
                                body: 'It\'s time to drink water!',
                                repeatInterval: RepeatInterval.everyMinute,
                              );
                            } else {
                              NotificationService().cancelNotification(1);
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * .025),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 234, 232, 237),
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 214, 208, 225),
                    Color.fromARGB(255, 205, 188, 237)
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade400,
                        offset: const Offset(2.0, 2.0),
                        blurRadius: 10,
                        spreadRadius: 1),
                    BoxShadow(
                        color: Colors.grey.shade400,
                        offset: const Offset(-2.0, -2.0),
                        blurRadius: 10,
                        spreadRadius: 1),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sleep Reminder',
                        style: GoogleFonts.poppins(
                            fontSize: 19, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        sleepReminder == true
                            ? sleepTime.format(context)
                            : 'Not Set',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Switch(
                        value: sleepReminder,
                        onChanged: (value) async {
                          setState(() {
                            sleepReminder = value;
                            saveReminderStates();
                          });
                          if (sleepReminder) {
                            TimeOfDay? selectedTime = await showTimePicker(
                              context: context,
                              initialTime: sleepTime,
                            );
                            if (selectedTime != null) {
                              setState(() {
                                sleepTime = selectedTime;
                                saveReminderStates();
                              });

                              NotificationService()
                                  .scheduleDailyNotificationAtTime(
                                id: 2,
                                title: 'Sleep Time',
                                body: 'It\'s time to sleep!',
                                notificationTime: sleepTime,
                              );
                            } else {
                              setState(() {
                                sleepReminder = false;
                              });
                            }
                          } else {
                            NotificationService().cancelNotification(2);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * .025),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 234, 232, 237),
                  borderRadius: BorderRadius.circular(10),
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 214, 208, 225),
                    Color.fromARGB(255, 205, 188, 237)
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade400,
                        offset: const Offset(2.0, 2.0),
                        blurRadius: 10,
                        spreadRadius: 1),
                    BoxShadow(
                        color: Colors.grey.shade400,
                        offset: const Offset(-2.0, -2.0),
                        blurRadius: 10,
                        spreadRadius: 1),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Workout Reminder',
                        style: GoogleFonts.poppins(
                            fontSize: 19, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        workoutReminder == true
                            ? workoutTime.format(context)
                            : 'Not Set',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Switch(
                        value: workoutReminder,
                        onChanged: (value) async {
                          setState(() {
                            workoutReminder = value;
                            saveReminderStates();
                          });
                          if (workoutReminder) {
                            TimeOfDay? selectedTime = await showTimePicker(
                              context: context,
                              initialTime: workoutTime,
                            );
                            if (selectedTime != null) {
                              setState(() {
                                workoutTime = selectedTime;
                                saveReminderStates();
                              });

                              NotificationService()
                                  .scheduleDailyNotificationAtTime(
                                id: 3,
                                title: 'Workout Time',
                                body: 'It\'s time for your workout!',
                                notificationTime: workoutTime,
                              );
                            } else {
                              setState(() {
                                workoutReminder = false;
                              });
                            }
                          } else {
                            NotificationService().cancelNotification(3);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loadReminderStates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      waterReminder = prefs.getBool('waterReminder') ?? false;
      sleepReminder = prefs.getBool('sleepReminder') ?? false;
      workoutReminder = prefs.getBool('workoutReminder') ?? false;

      if (sleepReminder) {
        sleepTime = TimeOfDay(
          hour: prefs.getInt('sleepHour') ?? TimeOfDay.now().hour,
          minute: prefs.getInt('sleepMinute') ?? TimeOfDay.now().minute,
        );
      }

      if (workoutReminder) {
        workoutTime = TimeOfDay(
          hour: prefs.getInt('workoutHour') ?? TimeOfDay.now().hour,
          minute: prefs.getInt('workoutMinute') ?? TimeOfDay.now().minute,
        );
      }
    });
  }

  Future<void> saveReminderStates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('waterReminder', waterReminder);
    prefs.setBool('sleepReminder', sleepReminder);
    prefs.setBool('workoutReminder', workoutReminder);

    if (sleepReminder) {
      prefs.setInt('sleepHour', sleepTime.hour);
      prefs.setInt('sleepMinute', sleepTime.minute);
    }
    if (workoutReminder) {
      prefs.setInt('workoutHour', workoutTime.hour);
      prefs.setInt('workoutMinute', workoutTime.minute);
    }
  }
}
