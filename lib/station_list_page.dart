import 'package:flutter/material.dart';

class StationListPage extends StatefulWidget {
  String title;
  Map<String, String?> stationInfo;

  StationListPage(this.title, this.stationInfo);

  @override
  State<StationListPage> createState() => _StationListPageState();
}

class _StationListPageState extends State<StationListPage> {
  List<String> stationList = [
    '수서',
    '동탄',
    '평택지제',
    '천안아산',
    '오송',
    '대전',
    '김천구미',
    '동대구',
    '경주',
    '울산',
    '부산',
  ];

  @override
  Widget build(BuildContext context) {
    final islightMode = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      backgroundColor:
          islightMode
              ? Colors.white
              : Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: List.generate(
            stationList.length,
            (index) => GestureDetector(
              onTap: () {
                if (widget.stationInfo.containsValue(stationList[index])) {
                  // print('선택된 역이므로 onTap 동작x');
                  return;
                }

                setState(() {
                  if (widget.title == '출발역') {
                    widget.stationInfo['start'] = stationList[index];
                  } else {
                    widget.stationInfo['end'] = stationList[index];
                  }
                });

                Navigator.pop(context, widget.stationInfo);
              },
              child: Container(
                width: double.infinity,
                height: 50,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
                ),
                child: Text(
                  stationList[index],
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color:
                        widget.stationInfo.containsValue(stationList[index])
                            ? Theme.of(context).highlightColor
                            : Theme.of(context).dividerColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
