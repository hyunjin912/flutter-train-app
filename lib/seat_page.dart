import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

int sortCallback(a, b) {
  // 숫자와 문자를 분리
  var aSplit = a.split('-');
  var bSplit = b.split('-');

  // 숫자로 비교
  int numA = int.parse(aSplit[0]);
  int numB = int.parse(bSplit[0]);

  if (numA == numB) {
    // 숫자가 같으면 문자 비교
    return aSplit[1].compareTo(bSplit[1]);
  }

  // 숫자 비교
  return numA.compareTo(numB);
}

class SeatPage extends StatefulWidget {
  Map<String, String?> stationInfo;
  SeatPage(this.stationInfo);

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  int seatLength = 20;
  Set<String> selectedSeats = {};

  void onSelected({required String row, required String col}) {
    setState(() {
      String seatKey = '$row-$col';

      if (selectedSeats.contains(seatKey)) {
        selectedSeats.remove(seatKey);
      } else {
        selectedSeats.add(seatKey);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final islightMode = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      appBar: AppBar(title: Text('좌석 선택')),
      backgroundColor:
          islightMode
              ? Colors.white
              : Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              stationBox(),
              seatStateBox(),
              Expanded(
                // 이게 없으면 에러가 뜨네??? 칼럼위젯이랑 리스트뷰위젯이랑 겹쳐서 그런거같은데...
                child: ListView(
                  children: [
                    Align(
                      // 리스트뷰위젯의 너비는 가로로 꽉 차기 때문에 컨테이너위젯이 자식이 되면 너비의 크기 조절이 안됨. 그래서 얼라인위젯으로 래핑함
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          seatCol(number: 'A'),
                          SizedBox(width: 4),
                          seatCol(number: 'B'),
                          SizedBox(width: 4),
                          seatNumCol(),
                          SizedBox(width: 4),
                          seatCol(number: 'C'),
                          SizedBox(width: 4),
                          seatCol(number: 'D'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              reservationBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget seatCol({required String number}) {
    return Column(
      children: [
        seatNumberBox(type: "col", number: number),
        SizedBox(height: 4),
        ...List.generate(
          seatLength,
          (idx) => seat(col: number, row: (idx + 1).toString()),
        ),
      ],
    );
  }

  Widget seatNumCol() {
    return Column(
      children: [
        SizedBox(width: 50, height: 50),
        ...List.generate(
          seatLength,
          (idx) => seatNumberBox(type: 'row', number: (idx + 1).toString()),
        ),
      ],
    );
  }

  Widget seat({required String col, required String row}) {
    String seatNumber = '$row-$col';

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            // print('$row$col');
            onSelected(row: row, col: col);
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color:
                  selectedSeats.contains(seatNumber)
                      ? Colors.purple
                      : Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget seatNumberBox({required String type, required String number}) {
    if (type == 'col') {
      return Container(
        width: 50,
        height: 50,
        alignment: Alignment.bottomCenter,
        child: Text(number, style: TextStyle(fontSize: 18)),
      );
    }

    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          alignment: Alignment.center,
          child: Text(number, style: TextStyle(fontSize: 18)),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  SizedBox reservationBox() {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed:
            selectedSeats.isEmpty
                ? null
                : () {
                  var currentSeats = selectedSeats.toList()..sort(sortCallback);
                  // print(currentSeats);
                  showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: Text('예매 하시겠습니까?'),
                        content: Text('좌석 : ${currentSeats.join(', ')}'),
                        actions: [
                          CupertinoDialogAction(
                            isDefaultAction: true,
                            onPressed: () {
                              // 이게 있어야 팝업 창이 사라짐
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              '취소',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          CupertinoDialogAction(
                            isDestructiveAction: true,
                            onPressed: () {},
                            child: Text(
                              '확인',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: Theme.of(context).disabledColor,
          disabledForegroundColor: Theme.of(context).highlightColor,
        ),
        child: Text(
          '예매 하기',
          style: TextStyle(
            // color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget seatStateBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(width: 4),
              Text('선택됨'),
            ],
          ),
          SizedBox(width: 20),
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(width: 4),
              Text('선택안됨'),
            ],
          ),
        ],
      ),
    );
  }

  Row stationBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          widget.stationInfo['start']!,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
        Icon(
          Icons.arrow_circle_right_outlined,
          size: 30,
          color: Theme.of(context).dividerColor,
        ),
        Text(
          widget.stationInfo['end']!,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
          ),
        ),
      ],
    );
  }
}
