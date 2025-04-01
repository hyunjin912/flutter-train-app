import 'package:flutter/material.dart';
import 'package:flutter_train_app/seat_page.dart';
import 'package:flutter_train_app/station_list_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, String?> stationInfo = {'start': null, 'end': null};

  void onChangeStation({String? start, String? end}) {
    setState(() {
      if (start != null) {
        stationInfo['start'] = start;
      }

      if (end != null) {
        stationInfo['end'] = end;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('기차 예매')),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Row(
                    children: [
                      selectButton(context, '출발역', stationInfo['start']),
                      Container(
                        width: 2,
                        height: 50,
                        decoration: BoxDecoration(color: Colors.grey[400]),
                      ),
                      selectButton(context, '도착역', stationInfo['end']),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed:
                        stationInfo.containsValue(null)
                            ? null
                            : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    // 페이지 이동 시 데이터를 넘기는 방법2
                                    // 클래스의 인자로 데이터를 넘길 수 있다.
                                    return SeatPage(stationInfo);
                                  },
                                  // 페이지 이동 시 데이터를 넘기는 방법1
                                  // settings: RouteSettings(arguments: 데이터),
                                ),
                              );
                            },
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: Theme.of(context).disabledColor,
                      disabledForegroundColor: Theme.of(context).highlightColor,
                    ),
                    child: Text(
                      '좌석 선택',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded selectButton(BuildContext context, String title, String? station) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () async {
              var data = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    // 페이지 이동 시 데이터를 넘기는 방법2
                    // 클래스의 인자로 데이터를 넘길 수 있다.
                    return StationListPage(title, stationInfo);
                  },
                  // 페이지 이동 시 데이터를 넘기는 방법1
                  // settings: RouteSettings(arguments: 데이터),
                ),
              );

              // appBar의 뒤로가기 버튼 또는 앞페이지에서 Navigator.pop을 했을 경우 동작
              if (data != null) {
                onChangeStation(start: data['start'], end: data['end']);
              }
            },
            child: Text(
              station ?? '선택',
              style: TextStyle(
                fontSize: 40,
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
