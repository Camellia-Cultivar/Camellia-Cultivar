// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:smart_select/smart_select.dart';
// import '../api/api_service.dart';
// import '../model/upov_category.dart';
// import '../model/upov_subcategory.dart';
// import '../model/upov_subcategory_option.dart';
// import 'upov.dart';

// class UpovCharacteristics extends StatefulWidget {
//   const UpovCharacteristics(Map<int, dynamic> upovs, {Key? key})
//       : super(key: key);

//   get upovs => upovs;

//   @override
//   Upov createState() => Upov();
// }

// class Upov extends State<UpovCharacteristics> {
//   // List<String> selectedValues = List.filled(50, 'idk');
//   Map<int, UpovSubcategoryOption> selectedValues = {};
//   //id subcat, id option
//   // Map<int, dynamic> selectedValues = {};

//   // List<UpovCategory> categories = [];

//   Map controllers = {
//     'main color': TextEditingController(),
//     'secondary color': TextEditingController()
//   };
//   final api = APIService();

//   late final Future? upovFuture;

//   @override
//   void initState() {
//     super.initState();
//     upovFuture = api.getUpovCharacteristics();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // widget.upovs;
//     // for (Map<String, dynamic> category in categories) {
//     //   print(category["characteristics"]["options"]);
//     //   for (Map<String, dynamic> characteristic in category[""]) {}
//     //   // print(category["characteristics"].toString());
//     //   //   print("Characteristic main color:\t" +
//     //   //       category["characteristics"]["options"].runtimeType.toString());
//     // }
//     // for (UpovCategory category in categories) {
//     //   for (UpovSubcategory subCategory in category.characteristics) {
//     //     if (subCategory.id == 41 || subCategory.id == 43) {
//     //       print("checking the options\n");
//     //       print(subCategory.options!.length);
//     //       print(subCategory.options!.isNotEmpty);
//     //       print(subCategory.options.runtimeType);
//     //     }
//     //   }
//     // }
//     // Map controllers = {
//     //   'main color': TextEditingController(),
//     //   'secondary color': TextEditingController()
//     // };

//     return FutureBuilder(
//       future: upovFuture,
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Column(
//             children: [
//               Text(
//                 snapshot.error.toString(),
//               ),
//             ],
//           );
//         }

//         if (snapshot.hasData) {
//           var upovs = snapshot.data! as List;
//           print("length of upovs\t" + upovs.length.toString());
//           return _buildUpovs(context, upovs);
//         }
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: const [Text('Something went wrong!')],
//         );
//       },
//     );
//     // return Column(children: [
//     //   for (UpovCategory category in categories)
//     //     ExpansionTile(
//     //         collapsedIconColor: primaryColor,
//     //         collapsedTextColor: primaryColor,
//     //         title: Text(
//     //           category.category,
//     //           style: const TextStyle(fontSize: 18.0),
//     //         ),
//     //         children: [
//     //           for (UpovSubcategory subCategory in category.characteristics)
//     //             subCategory.options!.isNotEmpty
//     //                 ? SmartSelect<String>.single(
//     //                     title: subCategory.name,
//     //                     choiceItems: [
//     //                       S2Choice<String>(
//     //                           value: 0.toString(), title: "i don't know"),
//     //                       for (UpovSubcategoryOption option
//     //                           in subCategory.options!)
//     //                         S2Choice<String>(
//     //                             value: option.value.toString(),
//     //                             title: option.descriptor)
//     //                     ],
//     //                     value: selectedValues[subCategory.id - 1],
//     //                     onChange: (selected) => setState(() =>
//     //                         selectedValues[subCategory.id - 1] =
//     //                             selected.value),
//     //                     modalType: S2ModalType.popupDialog,
//     //                   )
//     //                 : _buildColorTextInput(context, subCategory.name)
//     //         ])
//     // ]);
//   }

//   Widget _buildUpovs(BuildContext context, List upovs) {
//     Color primaryColor = Theme.of(context).primaryColor;
//     // Map<int, UpovSubcategoryOption> temp = {};
//     // for (UpovCategory category in upovs) {
//     //   for (UpovSubcategory subCategory in category.characteristics) {
//     //     //   temp[subCategory.id] = UpovSubcategoryOption(
//     //     //       value: 0, descriptor: "i don't know", id: 0);

//     //     // for (UpovSubcategoryOption option in subCategory.options!) {
//     //     //     temp[subCategory.id] = option;
//     //     // }
//     //     selectedValues[subCategory.id] =
//     //         UpovSubcategoryOption(value: 0, descriptor: "i don't know", id: 0);
//     //   }
//     // }

//     // for (int i = 0; i < upovs.length; i++) {
//     //   var category = upovs[i];
//     //   for (int j = 0; j < category.characteristics; j++) {
//     //     var options = category.characteristics[j];
//     //     for (int l = 0; j < options.options; l++) {
//     //       var option = options.options[l];
//     //       temp[i + j + l] = option;
//     //     }
//     //   }
//     // }
//     // setState(() {
//     //   possibleValues = temp;
//     // });
//     return Column(children: [
//       for (UpovCategory category in upovs)
//         ExpansionTile(
//             collapsedIconColor: primaryColor,
//             collapsedTextColor: primaryColor,
//             title: Text(
//               category.category,
//               style: const TextStyle(fontSize: 18.0),
//             ),
//             children: [
//               for (UpovSubcategory subCategory in category.characteristics)
//                 subCategory.options!.isNotEmpty
//                     ? SmartSelect<String>.single(
//                         title: subCategory.name,
//                         choiceItems: [
//                           S2Choice<String>(
//                               value: 0.toString(), title: "i don't know"),
//                           for (UpovSubcategoryOption option
//                               in subCategory.options!)
//                             S2Choice<String>(
//                                 value: option.value.toString(),
//                                 title: option.descriptor)
//                         ],
//                         value: selectedValues[subCategory.id].toString(),
//                         onChange: (selected) => setState(() =>
//                             selectedValues[subCategory.id] =
//                                 int.parse(selected.value)),
//                         modalType: S2ModalType.popupDialog,
//                       )
//                     : _buildColorTextInput(context, subCategory.name)
//             ])
//     ]);
//   }

//   Widget _buildColorTextInput(BuildContext context, String title) {
//     setState(() {
//       widget.se = selectedValues;
//     });
//     Color primaryColor = Theme.of(context).primaryColor;
//     FocusNode myFocusNode = FocusNode();
//     return (Padding(
//         padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
//         child: TextFormField(
//           focusNode: myFocusNode,
//           cursorColor: primaryColor,
//           decoration: InputDecoration(
//             //primaryColor
//             labelStyle: TextStyle(color: primaryColor),
//             enabledBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: primaryColor),
//             ),
//             focusedBorder: UnderlineInputBorder(
//               borderSide: BorderSide(color: primaryColor),
//             ),
//             border: UnderlineInputBorder(
//               borderSide: BorderSide(color: primaryColor),
//             ),
//             labelText: title,
//           ),
//           controller: controllers[title],
//         )));
//   }
// }
