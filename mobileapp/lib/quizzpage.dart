import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


class QuizzPage extends StatelessWidget {

  int _currentIndex=0;


  List ids = [0, 1, 2, 3, 4, 5];

  Map<int, List> json = {
    34:["data:image/png;base64,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"], 
    60:["data:image/png;base64,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", "data:image/png;base64,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"]
  };

  void setState() {
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
    return Scaffold(
      backgroundColor: const Color(0xFFA4A4A4),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0)
          ),
          height: 770,
          width: 350,
          child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(ids, (index, url) {
                return Container(
                  width: 10.0,
                  height: 60.0,
                  margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index ? Colors.grey : Colors.white,
                    border: Border.all(color: Colors.black),
                    ),
                );
              }),
            ),
            // Column(
            //   children: [
            //     Text("Name the cultivar", style: TextStyle(color: Color(0xFF064E3B), fontSize: 30)),
            //     ListView.builder(
            //       itemCount: json[0]?.length,
            //       itemBuilder: (BuildContext context, int index){
            //         String img = json[0]![index];
            //         return Image.network(img);
            //       },
            //     )
            //   ]
            // )

            Column(
              children: [
                const Text("Name the cultivar", style: TextStyle(color: Color(0xFF064E3B), fontSize: 30)),
                SizedBox(
                  width: 300,
                  height: 300,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Image.network("data:image/png;base64,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"),
                      Image.network("data:image/png;base64,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"),
                      Image.network("data:image/png;base64,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"),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 40),
                  width: 220,
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'Name',
                    ),
                  )
                ),
                Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height:60,
                      width: 120,
                      child: TextButton(
                        onPressed: ()=>{},
                        style:  ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(const Color(0xFF064E3B)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: const BorderSide(color: Colors.white)
                            )
                          ),
                        ),
                        child: Text("Back".toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300))
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      width: 120,
                      child: TextButton(
                        onPressed: () => {}, 
                        style:  ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: const BorderSide(color: Color(0xFF064E3B))
                            )
                          ),
                        ),
                        child: Text("Next".toUpperCase(), style: const TextStyle(color: Color(0xFF064E3B), fontSize: 18, fontWeight: FontWeight.w300))
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: SizedBox(
                  height: 69,
                  width: 260,
                    child: TextButton(
                      onPressed: ()=>{}, 
                      style:  ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(const Color(0xFF064E3B)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: const BorderSide(color: Colors.white)
                          )
                        ),
                      ),
                      child: Text("Submit Quizz".toUpperCase(), style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300))
                    ),
                  ),
                )
              ],
            )
          ],
        )
      ),
    )
    );
  }

}
