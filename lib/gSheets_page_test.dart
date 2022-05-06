import 'package:gsheets/gsheets.dart';

/// Your google auth credentials
///
/// how to get credentials - https://medium.com/@a.marenkov/how-to-get-credentials-for-google-sheets-456b7e88c430
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

/// Your spreadsheet id
///
/// It can be found in the link to your spreadsheet -
/// link looks like so https://docs.google.com/spreadsheets/d/YOUR_SPREADSHEET_ID/edit#gid=0
/// [YOUR_SPREADSHEET_ID] in the path is the id your need
const _spreadsheetId = '1QNa5AgbZLvs1SAcDwrPTEyQbvffdX-1-jjg_1D7w9Rc';

void main() async {
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);

  print(ss.data.namedRanges.byName.values
      .map((e) => {
            'name': e.name,
            'start':
                '${String.fromCharCode((e.range?.startColumnIndex ?? 0) + 97)}${(e.range?.startRowIndex ?? 0) + 1}',
            'end':
                '${String.fromCharCode((e.range?.endColumnIndex ?? 0) + 97)}${(e.range?.endRowIndex ?? 0) + 1}'
          })
      .join('\n'));

  // get worksheet by its title
  var sheet = ss.worksheetByTitle('example');
  // create worksheet if it does not exist yet
  sheet ??= await ss.addWorksheet('example');

  // update cell at 'B2' by inserting string 'new'
  await sheet.values.insertValue('new', column: 2, row: 2);
  // prints 'new'
  print(await sheet.values.value(column: 2, row: 2));
  // get cell at 'B2' as Cell object
  final cell = await sheet.cells.cell(column: 2, row: 2);
  // prints 'new'
  print(cell.value);
  // update cell at 'B2' by inserting 'new2'
  await cell.post('new2');
  // prints 'new2'
  print(cell.value);
  // also prints 'new2'
  print(await sheet.values.value(column: 2, row: 2));

  // insert list in row #1
  final firstRow = ['index', 'letter', 'number', 'label'];
  await sheet.values.insertRow(1, firstRow);
  // prints [index, letter, number, label]
  print(await sheet.values.row(1));

  // insert list in column 'A', starting from row #2
  final firstColumn = ['0', '1', '2', '3', '4'];
  await sheet.values.insertColumn(1, firstColumn, fromRow: 2);
  // prints [0, 1, 2, 3, 4, 5]
  print(await sheet.values.column(1, fromRow: 2));

  // insert list into column named 'letter'
  final secondColumn = ['a', 'b', 'c', 'd', 'e'];
  await sheet.values.insertColumnByKey('letter', secondColumn);
  // prints [a, b, c, d, e, f]
  print(await sheet.values.columnByKey('letter'));

  // insert map values into column 'C' mapping their keys to column 'A'
  // order of map entries does not matter
  final thirdColumn = {
    '0': '1',
    '1': '2',
    '2': '3',
    '3': '4',
    '4': '5',
  };
  await sheet.values.map.insertColumn(3, thirdColumn, mapTo: 1);
  // prints {index: number, 0: 1, 1: 2, 2: 3, 3: 4, 4: 5, 5: 6}
  print(await sheet.values.map.column(3));

  // insert map values into column named 'label' mapping their keys to column
  // named 'letter'
  // order of map entries does not matter
  final fourthColumn = {
    'a': 'a1',
    'b': 'b2',
    'c': 'c3',
    'd': 'd4',
    'e': 'e5',
  };
  await sheet.values.map.insertColumnByKey(
    'label',
    fourthColumn,
    mapTo: 'letter',
  );
  // prints {a: a1, b: b2, c: c3, d: d4, e: e5, f: f6}
  print(await sheet.values.map.columnByKey('label', mapTo: 'letter'));

  // appends map values as new row at the end mapping their keys to row #1
  // order of map entries does not matter
  final secondRow = {
    'index': '5',
    'letter': 'f',
    'number': '6',
    'label': 'f6',
  };
  await sheet.values.map.appendRow(secondRow);
  // prints {index: 5, letter: f, number: 6, label: f6}
  print(await sheet.values.map.lastRow());

  // get first row as List of Cell objects
  final cellsRow = await sheet.cells.row(1);
  // update each cell's value by adding char '_' at the beginning
  cellsRow.forEach((cell) => cell.value = '_${cell.value}');
  // actually updating sheets cells
  await sheet.cells.insert(cellsRow);
  // prints [_index, _letter, _number, _label]
  print(await sheet.values.row(1));
}
