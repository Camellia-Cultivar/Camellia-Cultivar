import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliderShowFullmages extends StatefulWidget {
  final List listImagesModel;
  final int current;
  final bool isNetworkImg;
  const SliderShowFullmages(
      {Key? key,
      required this.listImagesModel,
      required this.current,
      required this.isNetworkImg})
      : super(key: key);
  @override
  _SliderShowFullmagesState createState() => _SliderShowFullmagesState();
}

class _SliderShowFullmagesState extends State<SliderShowFullmages> {
  int _current = 0;
  bool _stateChange = false;
  bool _isNetworkImg = false;
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
    Color primaryColor = Theme.of(context).primaryColor;
    _current = (_stateChange == false) ? widget.current : _current;
    _isNetworkImg = widget.isNetworkImg;

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
                CarouselSlider(
                  options: CarouselOptions(
                      enableInfiniteScroll: false,
                      autoPlay: false,
                      height: MediaQuery.of(context).size.height / 1.3,
                      viewportFraction: 1.0,
                      onPageChanged: (index, data) {
                        setState(() {
                          _stateChange = true;
                          _current = index;
                        });
                      },
                      initialPage: widget.current),
                  items: map<Widget>(widget.listImagesModel, (index, url) {
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(0.0)),
                            child: _isNetworkImg
                                ? Image.network(
                                    url,
                                    fit: BoxFit.fill,
                                  )
                                : Image.file(
                                    url,
                                    fit: BoxFit.fill,
                                  ),
                          )
                        ]);
                  }),
                ),
                Flexible(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: map<Widget>(widget.listImagesModel, (index, url) {
                      return Container(
                        width: 10.0,
                        height: 9.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 5.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              (_current == index) ? primaryColor : Colors.grey,
                        ),
                      );
                    }),
                  ),
                )
              ],
            )));
  }
}
