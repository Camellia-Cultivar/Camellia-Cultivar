import 'package:flutter/material.dart';

class ShowFullMap extends StatefulWidget {
  const ShowFullMap({Key? key}) : super(key: key);
  @override
  _ShowFullMapState createState() => _ShowFullMapState();
}

class _ShowFullMapState extends State<ShowFullMap> {
  int _current = 0;
  bool _stateChange = false;
  @override
  void initState() {
    super.initState();
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    _current = (_stateChange == false) ? widget.current : _current;
    return Container(
        color: Colors.transparent,
        child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: const Color(0xFF064E3B),
              //title: const Text('Transaction Detail'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: map<Widget>(widget.listImagesModel, (index, url) {
                    return Container(
                      width: 10.0,
                      height: 9.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 5.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (_current == index)
                            ? const Color(0xFF064E3B)
                            : Colors.grey,
                      ),
                    );
                  }),
                ),
              ],
            )));
  }
}
