import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:intl/intl.dart';
import 'package:gsheets/gsheets.dart';

bool visible_state = false;
double total_lectures = 100;
double total_attended = 0;
double overall_percent = 0;
String user_roll = "";
String user_cprn = "";

List<String>? attendance_dsa = [];
List<String>? attendance_ml = [];
List<String>? attendance_ads = [];
List<String>? attendance_cc = [];

const _credentials = r'''
{
  "type": "service_account",
  "project_id": "gsheets-349313",
  "private_key_id": "5030fc4c469f073f9404f6c658c9f3c91b0444ec",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDSLd+XTxgv0UXs\nIN+PbEZ7nApb06LqGkMVjaLZwWpY2y8M14/uOD1lkAcxvll5lH5y9RiogzfABh+N\n9KlV+KUBGQXRAd+qSuB0SgoGU8yFxu2OsHXkIhSCpln5DFMwOzOoWUKFk2p0itRf\nru/WzTRr916LCeU5VjGUCR7U3eyPo2M2qB1gk8XZfSvGcTuxWd8iRMD1TiVmC6jR\nYp1y/Sl5jP0lZ7kbUlSpZu7GRfb151KyCs2HoK9IyG3bbqa4Z8L1gDn92Lp7ytzt\nRk+v3bgOj/jGNlTD9F752ouUtW9Wv1+g0n2z8rVTodtO5U8I/diC4cf+zOX8y7bw\n8C6pZqkHAgMBAAECggEAU6vjeS8Jp++d8HTdyxEFtivWi9vi3WN7FVd/X0T6e0k2\nn9wo9mL5PjdqRclLgXU2KbmdCWjDhvRpF3AxAYKs3ZUClcQzMG4CkQjwmLg/kXoy\nFD33kMxoceKbquPXMjo/RGPUcazQEnk6NqVD4bVrixe9UYis8nh34EEJPyDiDgP6\ndO/ryH2Goxmg/mJ6NuypaY+oZ6y5HOd5GXs0PYv7+J+NFgxeUNMJIY55OuHBHar5\nD73sY3sIzYvHAPnONXO00rB52wSyCzVkWgm18yNRCwdMLLJ2ViJ9T79grhPEzur7\nQtBSyUwTujgASNfhHNx9qxTnpRO156TEjb3lYEUykQKBgQD2OK/V1ATavj0sw17U\n8/oI+VEXxJqFmFfx5F8uVfndtF/AgYcy8qwP44G0R1ZbCicBmkrbMQBm2iMNuSD0\nUq66iBMv8evrMg/HFs4BGC2bHasmfW45+qinL0QWsGts0yzG5n+fjnYM8LbRCi1J\n53McWoXcS/hMMeEN/pRmR5aMOwKBgQDahr9/xNQBN4u0wNM+hADzC3wwIk5QwpvF\n1LwuP1VtwPFJiYvmcaOPmE/XC7sxP5r25GIU+zOowzirszi59cQ8WYOaGC9TcIOc\ni4sgfI38Bwvhuo67gQzi2Exj1/DjB5uGIDy3PCoMd8MKasnb6Z3I+gAra0lMGyd0\nTyNfDnFlpQKBgD1Gwkve5g5iRes7+//XcCSHl6zomuQgk9J5WU64yuRoHWRVWAZP\n6o5RulfZYR5rGmYFthdyzHzMUOj7Z74mTaHSd6P4+xOfc9nCTSZsk/0ElzGPCb2Y\nKhzhYHqdET8WFxCxEJXu6GY0CetgMwEvfrBRvvqiVXrw9ud6sgf6TPc9AoGBAJ0o\nIzikOUPWyqZntoRTMsuYCuwi/+eczaJs6Bjqe2m/RMf6H57PQy3WADVLvoggkjXU\n8aTdM72/CFaTQcybL1GnnrmHgyGi3UQMJzZp3ULPXoAsRtIacUYDAI0dk6PyqKrB\nLGkq36KvzpkDS8DYNh1/jfer5L7TGIDRGUMXg/3xAoGBAOVSnaQ8N6aL1grN8SHx\ncrEy+wv9JL8R/8ZBClB9qZ2yhuP5U76mkTIXcy7XtSrSYL9dyx2P4BnhCKOLu0Y5\npu7FLGxaDxFuRI8VxSgnnBA3+H1zEyBaDJyeigOQOJ6OjvtKZgjbxLxa5YHLUi75\nwNCsptNJzJzPWWav+t2aUpdE\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@gsheets-349313.iam.gserviceaccount.com",
  "client_id": "114132320196099456816",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gsheets-349313.iam.gserviceaccount.com"
}
''';

const _spreadsheetId = '1QNa5AgbZLvs1SAcDwrPTEyQbvffdX-1-jjg_1D7w9Rc';

void getSheetgetInfo(String x, String y) async {
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);
  // get worksheet by its title
  var sheet = ss.worksheetByTitle("DSA");
  attendance_dsa = await sheet!.values.rowByKey(x);
  sheet = ss.worksheetByTitle("ADS");
  attendance_ads = await sheet!.values.rowByKey(x);
  sheet = ss.worksheetByTitle("ML");
  attendance_ml = await sheet!.values.rowByKey(x);
  sheet = ss.worksheetByTitle("CC");
  attendance_cc = await sheet!.values.rowByKey(x);

  total_lectures = double.parse(attendance_ads![0]) +
      double.parse(attendance_dsa![0]) +
      double.parse(attendance_ml![0]) +
      double.parse(attendance_cc![0]);

  total_attended = double.parse(attendance_ads![1]) +
      double.parse(attendance_dsa![1]) +
      double.parse(attendance_ml![1]) +
      double.parse(attendance_cc![1]);

  visible_state = true;
}

class CustomPicker extends CommonPickerModel {
  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  CustomPicker({DateTime? currentTime, LocaleType? locale})
      : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();
    setLeftIndex(this.currentTime.hour);
    setMiddleIndex(this.currentTime.minute);
    setRightIndex(this.currentTime.second);
  }

  @override
  String? leftStringAtIndex(int index) {
    if (index >= 0 && index < 24) {
      return digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String? middleStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String? rightStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String leftDivider() {
    return "|";
  }

  @override
  String rightDivider() {
    return "|";
  }

  @override
  List<int> layoutProportions() {
    return [1, 2, 1];
  }

  @override
  DateTime finalTime() {
    return currentTime.isUtc
        ? DateTime.utc(currentTime.year, currentTime.month, currentTime.day,
            currentLeftIndex(), currentMiddleIndex(), currentRightIndex())
        : DateTime(currentTime.year, currentTime.month, currentTime.day,
            currentLeftIndex(), currentMiddleIndex(), currentRightIndex());
  }
}

String? selectedSub = "DSA";
String? selectedDiv = "TE1";

class HomeScreen extends StatefulWidget {
  final String userRoll;
  final String userName;
  const HomeScreen({Key? key, required this.userRoll, required this.userName})
      : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var myFormat = DateFormat('yyyy:MM:dd');
  DateTime _lectureDate = DateTime.now();

  List<String> subject_list = [
    'DSA',
    'ADS',
    'ML',
    'CC',
  ];

  List<String> div_list = [
    'TE1',
    'TE2',
    'BE1',
    'BE2',
    'SE1',
    'SE2',
  ];

  @override
  void initState() {
    visible_state = false;
    super.initState();
    //getSheetgetInfo();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Attendance Portal",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              elevation: 12,
              margin: EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Material(
                      elevation: 4.0,
                      shape: CircleBorder(),
                      clipBehavior: Clip.hardEdge,
                      color: Colors.transparent,
                      child: Ink.image(
                        image: const AssetImage(
                            'assets/images/login_background.png'),
                        fit: BoxFit.cover,
                        width: 80.0,
                        height: 80.0,
                        child: InkWell(
                          onTap: () {},
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.userName,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.userRoll,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Card(
              elevation: 12,
              margin: EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        child: Text(subject_list[0],
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 18,
                                fontWeight: FontWeight.w700)),
                      ),
                      Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          child: visible_state
                              ? Text(
                                  attendance_dsa![1] + '/' + attendance_dsa![0],
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700))
                              : Text("---/---",
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700))),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        child: Text(subject_list[1],
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 18,
                                fontWeight: FontWeight.w700)),
                      ),
                      Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          child: visible_state
                              ? Text(
                                  attendance_ads![1] + '/' + attendance_ads![0],
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700))
                              : Text("---/---",
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700))),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        child: Text(subject_list[2],
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 18,
                                fontWeight: FontWeight.w700)),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        child: visible_state
                            ? Text(attendance_ml![1] + '/' + attendance_ml![0],
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700))
                            : Text("---/---",
                                style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        child: Text(subject_list[3],
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 18,
                                fontWeight: FontWeight.w700)),
                      ),
                      Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(10),
                          child: visible_state
                              ? Text(
                                  attendance_cc![1] + '/' + attendance_cc![0],
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700))
                              : Text("---/---",
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700))),
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     Text(
                  //       "Select Subject : ",
                  //       style: TextStyle(
                  //           fontSize: 14,
                  //           fontWeight: FontWeight.bold,
                  //           color: Color(0xFF5367ff)),
                  //     ),
                  //     DropdownButtonHideUnderline(
                  //       child: DropdownButton2(
                  //         isExpanded: true,
                  //         hint: Row(
                  //           children: [
                  //             Expanded(
                  //               child: Text(
                  //                 subject_list[0],
                  //                 style: TextStyle(
                  //                   fontSize: 14,
                  //                   fontWeight: FontWeight.bold,
                  //                   color: Color(0xFF5367ff),
                  //                 ),
                  //                 overflow: TextOverflow.ellipsis,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         items: subject_list
                  //             .map(
                  //               (item) => DropdownMenuItem<String>(
                  //                 value: item,
                  //                 child: Text(
                  //                   item,
                  //                   style: const TextStyle(
                  //                     fontSize: 14,
                  //                     fontWeight: FontWeight.bold,
                  //                     color: Color(0xFF5367ff),
                  //                   ),
                  //                   overflow: TextOverflow.ellipsis,
                  //                 ),
                  //               ),
                  //             )
                  //             .toList(),
                  //         value: selectedSub,
                  //         onChanged: (value) {
                  //           setState(
                  //             () {
                  //               selectedSub = value as String;
                  //             },
                  //           );
                  //         },
                  //         icon: const Icon(
                  //           Icons.keyboard_arrow_down_sharp,
                  //         ),
                  //         iconSize: 18,
                  //         iconEnabledColor: Color(0xFF5367ff),
                  //         iconDisabledColor: Colors.grey,
                  //         buttonHeight: 50,
                  //         buttonWidth: 160,
                  //         buttonPadding:
                  //             const EdgeInsets.only(left: 14, right: 14),
                  //         buttonElevation: 2,
                  //         itemHeight: 40,
                  //         itemPadding:
                  //             const EdgeInsets.only(left: 14, right: 14),
                  //         dropdownMaxHeight: 200,
                  //         dropdownWidth: 200,
                  //         dropdownPadding: null,
                  //         dropdownDecoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(14),
                  //           color: Colors.white,
                  //         ),
                  //         dropdownElevation: 8,
                  //         scrollbarRadius: const Radius.circular(40),
                  //         scrollbarThickness: 6,
                  //         scrollbarAlwaysShow: true,
                  //         offset: const Offset(-20, 0),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     Text(
                  //       "Select Class : ",
                  //       style: TextStyle(
                  //           fontSize: 14,
                  //           fontWeight: FontWeight.bold,
                  //           color: Color(0xFF5367ff)),
                  //     ),
                  //     DropdownButtonHideUnderline(
                  //       child: DropdownButton2(
                  //         isExpanded: true,
                  //         hint: Row(
                  //           children: [
                  //             Expanded(
                  //               child: Text(
                  //                 div_list[0],
                  //                 style: TextStyle(
                  //                   fontSize: 14,
                  //                   fontWeight: FontWeight.bold,
                  //                   color: Color(0xFF5367ff),
                  //                 ),
                  //                 overflow: TextOverflow.ellipsis,
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //         items: div_list
                  //             .map(
                  //               (item) => DropdownMenuItem<String>(
                  //                 value: item,
                  //                 child: Text(
                  //                   item,
                  //                   style: const TextStyle(
                  //                     fontSize: 14,
                  //                     fontWeight: FontWeight.bold,
                  //                     color: Color(0xFF5367ff),
                  //                   ),
                  //                   overflow: TextOverflow.ellipsis,
                  //                 ),
                  //               ),
                  //             )
                  //             .toList(),
                  //         value: selectedDiv,
                  //         onChanged: (value) {
                  //           setState(
                  //             () {
                  //               selectedDiv = value as String;
                  //             },
                  //           );
                  //         },
                  //         icon: const Icon(
                  //           Icons.keyboard_arrow_down_sharp,
                  //         ),
                  //         iconSize: 18,
                  //         iconEnabledColor: Color(0xFF5367ff),
                  //         iconDisabledColor: Colors.grey,
                  //         buttonHeight: 50,
                  //         buttonWidth: 160,
                  //         buttonPadding:
                  //             const EdgeInsets.only(left: 14, right: 14),
                  //         buttonElevation: 2,
                  //         itemHeight: 40,
                  //         itemPadding:
                  //             const EdgeInsets.only(left: 14, right: 14),
                  //         dropdownMaxHeight: 200,
                  //         dropdownWidth: 200,
                  //         dropdownPadding: null,
                  //         dropdownDecoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(14),
                  //           color: Colors.white,
                  //         ),
                  //         dropdownElevation: 8,
                  //         scrollbarRadius: const Radius.circular(40),
                  //         scrollbarThickness: 6,
                  //         scrollbarAlwaysShow: true,
                  //         offset: const Offset(-20, 0),
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     Text(
                  //       "Lecture Date:",
                  //       style: TextStyle(
                  //           fontSize: 14,
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.blue),
                  //     ),
                  //     Container(
                  //       margin: const EdgeInsets.all(15),
                  //       child: FlatButton.icon(
                  //         onPressed: () {
                  //           DatePicker.showDatePicker(context,
                  //               showTitleActions: true,
                  //               minTime: DateTime(2018, 3, 5),
                  //               maxTime: DateTime.now(),
                  //               theme: const DatePickerTheme(
                  //                   headerColor: Colors.blue,
                  //                   backgroundColor: Colors.white,
                  //                   itemStyle: TextStyle(
                  //                       color: Colors.blue,
                  //                       fontWeight: FontWeight.bold,
                  //                       fontSize: 18),
                  //                   doneStyle: TextStyle(
                  //                       color: Colors.white,
                  //                       fontSize: 16)), onChanged: (date) {
                  //             print('change $date in time zone ' +
                  //                 date.timeZoneOffset.inHours.toString());
                  //           }, onConfirm: (date) {
                  //             _lectureDate = date;
                  //             setState(() {});
                  //             print('confirm $_lectureDate');
                  //           },
                  //               currentTime: DateTime.now(),
                  //               locale: LocaleType.en);
                  //         },
                  //         label: Text(
                  //           "${myFormat.format(_lectureDate)}",
                  //           style: TextStyle(
                  //               fontSize: 14,
                  //               fontWeight: FontWeight.bold,
                  //               color: Colors.blue),
                  //         ),
                  //         icon: const Icon(
                  //           Icons.calendar_today_rounded,
                  //           color: Colors.blue,
                  //           size: 30,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  //),
                  Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 10, bottom: 10),

                    decoration: BoxDecoration(
                        color: Color(0xFF5367ff),
                        borderRadius: BorderRadius.circular(30)),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      onPressed: () {
                        setState(
                          () {
                            getSheetgetInfo(widget.userRoll, widget.userName);
                          },
                        );
                      },
                      child: const Text(
                        'View Attendance',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),

                  Visibility(
                    visible: visible_state,
                    child: Stack(
                      children: [
                        SfRadialGauge(
                          axes: <RadialAxis>[
                            RadialAxis(
                              minimum: 0,
                              maximum: total_lectures,
                              useRangeColorForAxis: true,
                              startAngle: 270,
                              endAngle: 270,
                              showLabels: false,
                              showTicks: false,
                              axisLineStyle: const AxisLineStyle(
                                thicknessUnit: GaugeSizeUnit.factor,
                                thickness: 0.35,
                                color: Color(0xFF98a4ff),
                              ),
                              ranges: <GaugeRange>[
                                GaugeRange(
                                  startValue: 0,
                                  endValue: total_lectures,
                                  color: const Color(0xFF98a4ff),
                                  sizeUnit: GaugeSizeUnit.factor,
                                  startWidth: 0.35,
                                  endWidth: 0.35,
                                ),
                                GaugeRange(
                                  // This will update the gauge based on returns.
                                  startValue: 0,
                                  endValue: total_attended,
                                  sizeUnit: GaugeSizeUnit.factor,
                                  color: const Color(0xFF5367ff),
                                  startWidth: 0.35,
                                  endWidth: 0.35,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Transform.translate(
                          offset: Offset(95.0, 160.0),
                          child: Container(
                            child: Text(
                              "$total_attended / $total_lectures",
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Your google auth credentials
///
/// how to get credentials - https://medium.com/@a.marenkov/how-to-get-credentials-for-google-sheets-456b7e88c430

/// Your spreadsheet id
///
/// It can be found in the link to your spreadsheet -
/// link looks like so https://docs.google.com/spreadsheets/d/YOUR_SPREADSHEET_ID/edit#gid=0
/// [YOUR_SPREADSHEET_ID] in the path is the id your need



