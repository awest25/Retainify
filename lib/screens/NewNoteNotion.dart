import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import "package:retainify/global_styles.dart";
import 'package:timezone/data/latest.dart' as tz;
import '../notifications.dart';
import '../notion_api.dart';

class NewNoteNotion extends StatefulWidget {
  const NewNoteNotion({super.key});

  @override
  _NewNoteNotion createState() => _NewNoteNotion();
}

class _NewNoteNotion extends State<NewNoteNotion> {
  String? _selectedValue = null;
  // TODO: query the notion database for a list of page titles which aren't already in our app database

  String databaseId = 'fe6780fd2f71484c97f87999290cc9d0';
  List<NotionPage> pages = <NotionPage>[];
  List<String> pageTitles = <String>[];

  Future<List<NotionPage>> getPages() async {
    pages = await fetchPagesFromNotion(databaseId);
    List<String> pageTitles = [];
    for (var page in pages) {
      pageTitles.add(page.name);
    }

    return pages;
  }

  @override
  void initState() {
    super.initState();
    getPages();
  }

  @override
  Widget build(BuildContext context) {
    final header1 = const TextStyle(fontSize: 25);
    return Scaffold(
        backgroundColor: theme.colorScheme.background,
        appBar: AppBar(),
        body: Center(
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(children: [
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("New Note from Notion", style: title),
                    padding: EdgeInsets.only(left: 15),
                  ),
                  SizedBox(height: 20),
                  Card(
                      shape: curvedShape,
                      elevation: 2,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Column(children: [
                            DropdownMenu(
                                width:
                                    MediaQuery.of(context).size.width * 0.85 -
                                        40,
                                label: Text("Select a Page"),
                                dropdownMenuEntries: [
                                  DropdownMenuEntry(
                                      value: "zero", label: "zero"),
                                  DropdownMenuEntry(value: "one", label: "one")
                                ],
                                onSelected: ((value) {
                                  _selectedValue = value;
                                })),
                            SizedBox(height: 10),
                            // TODO: PUSH to database based on selected dropdown entry
                            ElevatedButton(
                              onPressed: () async {
                                Navigator.pop(context);

                                DateTime now = DateTime.now();

                                Duration oneMinute =
                                    const Duration(minutes: 1); // For debugging

                                Duration oneDay = const Duration(days: 1);
                                Duration sevenDays = const Duration(days: 7);
                                Duration sixteenDays = const Duration(days: 16);
                                Duration thirtyFiveDays =
                                    const Duration(days: 35);

                                DateTime scheduledDate0 = now.add(oneMinute);
                                DateTime scheduledDate1 = now.add(oneDay);
                                DateTime scheduledDate2 = now.add(sevenDays);
                                DateTime scheduledDate3 = now.add(sixteenDays);
                                DateTime scheduledDate4 =
                                    now.add(thirtyFiveDays);

                                String title = 'Time to Review!';
                                String body1 =
                                    'This is your first review session for the topic!';
                                String body2 =
                                    'This is your second review session for the topic!';
                                String body3 =
                                    'This is your third review session for the topic!';
                                String body4 =
                                    'This is your final review session for the topic!';

                                // Load the timezone data
                                tz.initializeTimeZones();

                                // Get the current device's timezone
                                String deviceTimeZone;
                                try {
                                  deviceTimeZone = await FlutterNativeTimezone
                                      .getLocalTimezone();
                                } catch (e) {
                                  deviceTimeZone = 'Etc/UTC';
                                }

                                WidgetsFlutterBinding.ensureInitialized();
                                initNotifications();
                                scheduleNotification(
                                    scheduledDate0, 0, title, body1); // 1min
                                scheduleNotification(
                                    scheduledDate1, 1, title, body1); // 1day
                                scheduleNotification(
                                    scheduledDate2, 2, title, body2); // 7days
                                scheduleNotification(
                                    scheduledDate3, 3, title, body3); // 16days
                                scheduleNotification(
                                    scheduledDate4, 4, title, body4); // 35days
                              },
                              child: const Text("Import"),
                              style: elevatedButtonStyle,
                            ),
                          ])))
                  // TODO: populate titles from the results of the query
                ]))));
  }
}
