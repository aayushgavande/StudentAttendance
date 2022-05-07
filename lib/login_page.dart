import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'package:gsheets/gsheets.dart';
import 'package:teacher_attendance/home_screen.dart';

List<String> allRoll = [];
List<String> allPass = [];
List<String> allName = [];

bool _showProgress = false;
bool _emailError = false;
bool _passwordError = false;

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

const _loginsheetId = '1j--AiJqFkPEgm_oEfEkVz7ufH4KuvCheIpmko-SW4s0';

void getLoginSheet() async {
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_loginsheetId);

  var sheet = ss.worksheetByTitle("LoginData");

  allRoll = await sheet!.values.column(1);
  allPass = await sheet!.values.column(3);
  allName = await sheet!.values.column(4);

  print(allRoll[2] + allPass[2]);

  // print("Here" +
  //     ss.data.namedRanges.byName.values
  //         .map((e) => {
  //               'name': e.name,
  //               'start':
  //                   '${String.fromCharCode((e.range?.startColumnIndex ?? 0) + 97)}${(e.range?.startRowIndex ?? 0) + 1}',
  //               'end':
  //                   '${String.fromCharCode((e.range?.endColumnIndex ?? 0) + 97)}${(e.range?.endRowIndex ?? 0) + 1}'
  //             })
  //         .join('\n'));

  // // get worksheet by its title
  // var sheet = ss.worksheetByTitle(selectedSub!);
  // print(await sheet!.values.row(2));

  // // prints - [Product A, Product B, Product C, Product D, Product F, Product G]
  // // we use 'fromRow' to skip first row
  // print(await sheet.values.column(2, fromRow: 2));

  // // prints - Product A
  // print(await sheet.values.value(row: 2, column: 2));
}

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  late bool _loadingInProgress;

  @override
  void initState() {
    super.initState();
    _loadingInProgress = true;
    getLoginSheet();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _rollController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final _rollController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Center(
                child: SizedBox(
                    width: 650,
                    height: 300,
                    child: Image.asset('assets/images/login_background.png')),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(
                  left: 15, right: 15, top: 15, bottom: 8),
              child: TextField(
                controller: _rollController,
                enabled: !_showProgress,
                cursorColor: Colors.black,
                onTap: () {
                  setState(() {
                    _emailError = false;
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange)),
                  floatingLabelStyle: const TextStyle(color: Colors.orange),
                  labelText: 'Email',
                  errorText: _emailError ? "Invalid Email Address" : null,
                ),
              ),
            ),

            //Password Text Field
            Container(
              margin:
                  const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 5),
              child: TextField(
                controller: _passwordController,
                enabled: !_showProgress,
                obscureText: true,
                cursorColor: Colors.black,
                onTap: () {
                  setState(() {
                    _passwordError = false;
                  });
                },
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange)),
                  floatingLabelStyle: const TextStyle(color: Colors.orange),
                  labelText: 'Password',
                  errorText: _passwordError ? "Password can't be empty" : null,
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(
                  left: 15, right: 15, top: 15, bottom: 5),
              height: 60,
              width: double.infinity,
              child: ElevatedButton(
                //Button styling for enabled & disabled button
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      return (states.contains(MaterialState.pressed) ||
                              states.contains(MaterialState.disabled))
                          ? const Color(0x7F022539)
                          : const Color(
                              0xFF022539); // Use the component's default.
                    },
                  ),
                ),

                //if already loading, disable click
                onPressed: _showProgress
                    ? null
                    : () {
                        performLogin();
                      },

                //show text or progress
                child: _showProgress
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'LOGIN',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.normal),
                      ),
              ),
            ),

            //Sign up button
            Container(
              margin: const EdgeInsets.only(
                  left: 15, right: 15, top: 5, bottom: 15),
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(width: 0.8, color: Colors.black),
                    elevation: 2,
                    backgroundColor: Colors.white),
                onPressed: _showProgress
                    ? null
                    : () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Signup()));
                      },
                child: const Text(
                  'SIGN UP',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            // // ignore: deprecated_member_use
            // FlatButton(
            //   onPressed: () {
            //     //TODO FORGOT PASSWORD SCREEN GOES HERE
            //   },
            //   child: const Text(
            //     'Forgot Password',
            //     style: TextStyle(color: Colors.blue, fontSize: 15),
            //   ),
            // ),
            // const SizedBox(height: 30),
            // Container(
            //   padding:
            //       EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 0),
            //   height: 60,
            //   width: 325,
            //   decoration: BoxDecoration(
            //       color: Color(0xFF5367ff),
            //       borderRadius: BorderRadius.circular(30)),
            //   // ignore: deprecated_member_use
            //   child: FlatButton(
            //     onPressed: () {
            //       performLogin();
            //       Navigator.push(
            //           context, MaterialPageRoute(builder: (_) => HomeScreen()));
            //     },
            //     child: const Text(
            //       'LOGIN',
            //       style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 18,
            //           fontWeight: FontWeight.normal),
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // Container(
            //   padding:
            //       EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 0),
            //   height: 60,
            //   width: 325,
            //   decoration: BoxDecoration(
            //       color: Color(0xFF5367ff),
            //       borderRadius: BorderRadius.circular(30)),
            //   // ignore: deprecated_member_use
            //   child: FlatButton(
            //     onPressed: () {
            //       Navigator.push(
            //           context, MaterialPageRoute(builder: (_) => Signup()));
            //     },
            //     child: const Text(
            //       'SIGNUP',
            //       style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 18,
            //           fontWeight: FontWeight.normal),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void performLogin() {
    if (_rollController.text.isEmpty) {
      setState(() {
        _emailError = true;
      });
      return;
    } else if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordError = true;
      });
      return;
    } else {
      int i = 0;
      while (true) {
        if (allRoll[i] == _rollController.text) {
          print("Roll Number Found");
          break;
        } else {
          i++;
        }
        if (i >= allRoll.length) {
          setState(() {
            _emailError = true;
            _passwordError = true;
          });
          return;
        }
      }

      if (allPass[i] == _passwordController.text) {
        print("Login Successful");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    HomeScreen(userRoll: allRoll[i], userName: allName[i])));
      }
    }
    //update button state
    setState(() {
      _showProgress = false;
    });

    try {} on Error {
      setState(() {
        _showProgress = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please check your internet connection.")),
      );
    }
  }
}
