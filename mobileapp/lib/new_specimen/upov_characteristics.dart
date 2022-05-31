import 'dart:io';
import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import 'upov.dart';

var json = [
  {
    "id": "1",
    "category": "Plant",
    "characteristics": [
      {
        "name": "growth habit",
        "id": 1,
        "options": [
          {"value": 1, "descriptor": "upright", "id": 1},
          {"value": 2, "descriptor": "semi-upright", "id": 2},
          {"value": 3, "descriptor": "spreading", "id": 3},
          {"value": 4, "descriptor": "drooping", "id": 4},
          {"value": 5, "descriptor": "horizontal", "id": 5}
        ]
      },
      {
        "name": "density of foliage",
        "id": 3,
        "options": [
          {"value": 7, "descriptor": "dense", "id": 10},
          {"value": 3, "descriptor": "sparse", "id": 8},
          {"value": 5, "descriptor": "medium", "id": 9}
        ]
      }
    ]
  },
  {
    "id": "2",
    "category": "Branch",
    "characteristics": [
      {
        "name": "zigzagging",
        "id": 2,
        "options": [
          {"value": 9, "descriptor": "present", "id": 7},
          {"value": 1, "descriptor": "absent", "id": 6}
        ]
      }
    ]
  },
  {
    "id": "3",
    "category": "Vegetative Bud",
    "characteristics": [
      {
        "name": "color",
        "id": 4,
        "options": [
          {"value": 2, "descriptor": "green", "id": 12},
          {"value": 5, "descriptor": "purple red", "id": 15},
          {"value": 3, "descriptor": "purple green", "id": 13},
          {"value": 6, "descriptor": "dark red", "id": 16},
          {"value": 4, "descriptor": "light pink ", "id": 14},
          {"value": 1, "descriptor": "yellowish green", "id": 11}
        ]
      }
    ]
  },
  {
    "id": "4",
    "category": "Terminal Vegetative Bud",
    "characteristics": [
      {
        "name": "number",
        "id": 5,
        "options": [
          {"value": 2, "descriptor": "two", "id": 18},
          {"value": 3, "descriptor": "more than two", "id": 19},
          {"value": 1, "descriptor": "one", "id": 17}
        ]
      }
    ]
  },
  {
    "id": "5",
    "category": "Young Shoot",
    "characteristics": [
      {
        "name": "color",
        "id": 6,
        "options": [
          {"value": 3, "descriptor": "pink", "id": 22},
          {"value": 1, "descriptor": "yellowish green", "id": 20},
          {"value": 4, "descriptor": "yellowish brown", "id": 23},
          {"value": 5, "descriptor": "reddish brown", "id": 24},
          {"value": 2, "descriptor": "green", "id": 21}
        ]
      }
    ]
  },
  {
    "id": "6",
    "category": "Leaf",
    "characteristics": [
      {
        "name": "arrangement",
        "id": 8,
        "options": [
          {"value": 1, "descriptor": "alternate", "id": 28},
          {"value": 3, "descriptor": "spiral", "id": 30},
          {"value": 2, "descriptor": "perpendicular", "id": 29}
        ]
      },
      {
        "name": "attitude",
        "id": 7,
        "options": [
          {"value": 3, "descriptor": "downwards", "id": 27},
          {"value": 2, "descriptor": "outwards", "id": 26},
          {"value": 1, "descriptor": "upwards", "id": 25}
        ]
      }
    ]
  },
  {
    "id": "7",
    "category": "Leaf Blade",
    "characteristics": [
      {
        "name": "shape of apex",
        "id": 13,
        "options": [
          {"value": 3, "descriptor": "short acuminate ", "id": 48},
          {"value": 4, "descriptor": "medium acuminate", "id": 49},
          {"value": 1, "descriptor": "retuse", "id": 46},
          {"value": 2, "descriptor": "rounded", "id": 47},
          {"value": 5, "descriptor": "long acuminate ", "id": 50},
          {"value": 6, "descriptor": "divided", "id": 51}
        ]
      },
      {
        "name": "glossiness of upper side",
        "id": 17,
        "options": [
          {"value": 7, "descriptor": "strong", "id": 62},
          {"value": 3, "descriptor": "weak", "id": 60},
          {"value": 5, "descriptor": "medium", "id": 61}
        ]
      },
      {
        "name": "distribution of variegation",
        "id": 21,
        "options": [
          {"value": 2, "descriptor": "central zone only", "id": 74},
          {"value": 1, "descriptor": "marginal only", "id": 73},
          {"value": 3, "descriptor": "irregular", "id": 75}
        ]
      },
      {
        "name": "color of variegation",
        "id": 20,
        "options": [
          {"value": 2, "descriptor": "light yellow", "id": 71},
          {"value": 3, "descriptor": "medium yellow", "id": 72},
          {"value": 1, "descriptor": "white", "id": 70}
        ]
      },
      {
        "name": "position of broadest part",
        "id": 11,
        "options": [
          {"value": 2, "descriptor": "in middle third ", "id": 40},
          {"value": 1, "descriptor": "below middle third", "id": 39},
          {"value": 3, "descriptor": "above middle third", "id": 41}
        ]
      },
      {
        "name": "length",
        "id": 9,
        "options": [
          {"value": 5, "descriptor": "medium", "id": 32},
          {"value": 7, "descriptor": "long", "id": 33},
          {"value": 3, "descriptor": "short", "id": 31}
        ]
      },
      {
        "name": "width",
        "id": 10,
        "options": [
          {"value": 9, "descriptor": "very broad", "id": 38},
          {"value": 3, "descriptor": "narrow", "id": 35},
          {"value": 7, "descriptor": "broad", "id": 37},
          {"value": 5, "descriptor": "medium", "id": 36},
          {"value": 1, "descriptor": "very narrow", "id": 34}
        ]
      },
      {
        "name": "venation on upper side",
        "id": 16,
        "options": [
          {"value": 1, "descriptor": "weak", "id": 57},
          {"value": 2, "descriptor": "medium", "id": 58},
          {"value": 3, "descriptor": "strong", "id": 59}
        ]
      },
      {
        "name": "thickness",
        "id": 15,
        "options": [
          {"value": 2, "descriptor": "medium", "id": 55},
          {"value": 1, "descriptor": "thin", "id": 54},
          {"value": 3, "descriptor": "thick", "id": 56}
        ]
      },
      {
        "name": "shape in cross section",
        "id": 22,
        "options": [
          {"value": 1, "descriptor": "concave", "id": 76},
          {"value": 2, "descriptor": "flat", "id": 77},
          {"value": 3, "descriptor": "convex", "id": 78}
        ]
      },
      {
        "name": "pubescence on upper side",
        "id": 14,
        "options": [
          {"value": 1, "descriptor": "absent", "id": 52},
          {"value": 9, "descriptor": "present", "id": 53}
        ]
      },
      {
        "name": "margin",
        "id": 23,
        "options": [
          {"value": 3, "descriptor": "serrate", "id": 81},
          {"value": 2, "descriptor": "serrulate", "id": 80},
          {"value": 1, "descriptor": "entire", "id": 79},
          {"value": 4, "descriptor": "bidentate", "id": 82}
        ]
      },
      {
        "name": "variegation",
        "id": 18,
        "options": [
          {"value": 9, "descriptor": "present", "id": 64},
          {"value": 1, "descriptor": "absent", "id": 63}
        ]
      },
      {
        "name": "color of upper side (excluding variegation)",
        "id": 19,
        "options": [
          {"value": 2, "descriptor": "light green", "id": 66},
          {"value": 1, "descriptor": "yellowish green", "id": 65},
          {"value": 4, "descriptor": "dark green", "id": 68},
          {"value": 5, "descriptor": "grey green", "id": 69},
          {"value": 3, "descriptor": "medium green ", "id": 67}
        ]
      },
      {
        "name": "shape of base",
        "id": 12,
        "options": [
          {"value": 1, "descriptor": "acute", "id": 42},
          {"value": 3, "descriptor": "rounded", "id": 44},
          {"value": 4, "descriptor": "cordate", "id": 45},
          {"value": 2, "descriptor": "obtuse", "id": 43}
        ]
      }
    ]
  },
  {
    "id": "8",
    "category": "Petiole",
    "characteristics": [
      {
        "name": "length",
        "id": 24,
        "options": [
          {"value": 7, "descriptor": "long", "id": 86},
          {"value": 5, "descriptor": "medium", "id": 85},
          {"value": 1, "descriptor": "very short", "id": 83},
          {"value": 3, "descriptor": "short", "id": 84}
        ]
      }
    ]
  },
  {
    "id": "9",
    "category": "Sepal",
    "characteristics": [
      {
        "name": "position of broadest part",
        "id": 25,
        "options": [
          {"value": 3, "descriptor": "above middle third", "id": 89},
          {"value": 2, "descriptor": "in middle third", "id": 88},
          {"value": 1, "descriptor": "below middle third", "id": 87}
        ]
      },
      {
        "name": "shape of apex",
        "id": 27,
        "options": [
          {"value": 1, "descriptor": "obtuse", "id": 94},
          {"value": 2, "descriptor": "rounded", "id": 95},
          {"value": 3, "descriptor": "retuse", "id": 96}
        ]
      },
      {
        "name": "color of outer side",
        "id": 26,
        "options": [
          {"value": 4, "descriptor": "purple red ", "id": 93},
          {"value": 2, "descriptor": "yellowish green", "id": 91},
          {"value": 3, "descriptor": "brown", "id": 92},
          {"value": 1, "descriptor": "yellow", "id": 90}
        ]
      }
    ]
  },
  {
    "id": "10",
    "category": "Flower Bud",
    "characteristics": [
      {
        "name": "arrangement",
        "id": 28,
        "options": [
          {"value": 1, "descriptor": "terminal only", "id": 97},
          {"value": 3, "descriptor": "axillary only", "id": 99},
          {"value": 2, "descriptor": "terminal and axillary", "id": 98}
        ]
      }
    ]
  },
  {
    "id": "11",
    "category": "Flower",
    "characteristics": [
      {
        "name": "petaloid organs",
        "id": 33,
        "options": [
          {"value": 1, "descriptor": "some stamens petaloid", "id": 116},
          {
            "value": 3,
            "descriptor": "all stamens and pistil petaloids",
            "id": 118
          },
          {"value": 2, "descriptor": "all stamens petaloid", "id": 117}
        ]
      },
      {
        "name": "diameter",
        "id": 29,
        "options": [
          {"value": 7, "descriptor": "large", "id": 103},
          {"value": 1, "descriptor": "very small", "id": 100},
          {"value": 3, "descriptor": "small", "id": 101},
          {"value": 5, "descriptor": "medium", "id": 102},
          {"value": 9, "descriptor": "very large", "id": 104}
        ]
      },
      {
        "name": "form",
        "id": 30,
        "options": [
          {"value": 2, "descriptor": "semi-double", "id": 106},
          {"value": 5, "descriptor": "rose form double ", "id": 109},
          {"value": 4, "descriptor": "peony form", "id": 108},
          {"value": 1, "descriptor": "single", "id": 105},
          {"value": 6, "descriptor": "formal double", "id": 110},
          {"value": 3, "descriptor": "anemone form", "id": 107}
        ]
      },
      {
        "name": "shape of petals of first outer row",
        "id": 38,
        "options": [
          {"value": 3, "descriptor": "circular", "id": 133},
          {"value": 2, "descriptor": "oblong", "id": 132},
          {"value": 5, "descriptor": "obovate", "id": 135},
          {"value": 1, "descriptor": "ovate", "id": 131},
          {"value": 4, "descriptor": "oblate", "id": 134},
          {"value": 6, "descriptor": "obcordate", "id": 136}
        ]
      },
      {
        "name": "number of petaloids",
        "id": 32,
        "options": [
          {"value": 3, "descriptor": "few", "id": 113},
          {"value": 7, "descriptor": "many", "id": 115},
          {"value": 5, "descriptor": "medium", "id": 114}
        ]
      },
      {
        "name": "presence of petaloids",
        "id": 31,
        "options": [
          {"value": 1, "descriptor": "absent", "id": 111},
          {"value": 9, "descriptor": "present", "id": 112}
        ]
      }
    ]
  },
  {
    "id": "12",
    "category": "Petal",
    "characteristics": [
      {"name": "main color", "id": 41, "options": []},
      {
        "name": "curvature of longidutinal axis",
        "id": 37,
        "options": [
          {"value": 1, "descriptor": "incurved", "id": 128},
          {"value": 2, "descriptor": "flat", "id": 129},
          {"value": 3, "descriptor": "recurved", "id": 130}
        ]
      },
      {"name": "secondary color", "id": 43, "options": []},
      {
        "name": "number of incisions of margin",
        "id": 36,
        "options": [
          {"value": 1, "descriptor": "absent or few", "id": 125},
          {"value": 2, "descriptor": "medium", "id": 126},
          {"value": 3, "descriptor": "many ", "id": 127}
        ]
      },
      {
        "name": "undulation of margin",
        "id": 39,
        "options": [
          {"value": 2, "descriptor": "medium ", "id": 138},
          {"value": 3, "descriptor": "strong ", "id": 139},
          {"value": 1, "descriptor": "absent or weak", "id": 137}
        ]
      },
      {
        "name": "thickness",
        "id": 34,
        "options": [
          {"value": 2, "descriptor": "medium", "id": 120},
          {"value": 3, "descriptor": "thick", "id": 121},
          {"value": 1, "descriptor": "thin", "id": 119}
        ]
      },
      {
        "name": "distribution of shading of main color (excluding variegation)",
        "id": 42,
        "options": [
          {"value": 3, "descriptor": "darkest in the marginal zone", "id": 145},
          {"value": 4, "descriptor": "darkest towards the base", "id": 146},
          {"value": 1, "descriptor": "evenly shaded ", "id": 143},
          {"value": 2, "descriptor": "darkest in the central zone", "id": 144}
        ]
      },
      {
        "name": "shape of apex",
        "id": 35,
        "options": [
          {"value": 1, "descriptor": "obtuse", "id": 122},
          {"value": 3, "descriptor": "retuse", "id": 124},
          {"value": 2, "descriptor": "rounded", "id": 123}
        ]
      },
      {
        "name": "conspicuousness of veins",
        "id": 40,
        "options": [
          {"value": 2, "descriptor": "medium", "id": 141},
          {"value": 3, "descriptor": "strong", "id": 142},
          {"value": 1, "descriptor": "weak", "id": 140}
        ]
      },
      {
        "name": "distribution of secondary color",
        "id": 44,
        "options": [
          {"value": 4, "descriptor": "marginal", "id": 150},
          {"value": 6, "descriptor": "basal zone", "id": 152},
          {"value": 1, "descriptor": "blotched", "id": 147},
          {"value": 2, "descriptor": "central bar", "id": 148},
          {"value": 5, "descriptor": "striped and blotched", "id": 151},
          {"value": 3, "descriptor": "striated ", "id": 149}
        ]
      }
    ]
  },
  {
    "id": "13",
    "category": "Stamens",
    "characteristics": [
      {
        "name": "arrangement",
        "id": 45,
        "options": [
          {"value": 5, "descriptor": "pinched", "id": 157},
          {"value": 7, "descriptor": "split", "id": 159},
          {"value": 8, "descriptor": "dispersed", "id": 160},
          {"value": 3, "descriptor": "apricot", "id": 155},
          {"value": 1, "descriptor": "sasanqua", "id": 153},
          {"value": 4, "descriptor": "tea whisk", "id": 156},
          {"value": 2, "descriptor": "circular", "id": 154},
          {"value": 6, "descriptor": "tubular", "id": 158}
        ]
      }
    ]
  },
  {
    "id": "14",
    "category": "Style",
    "characteristics": [
      {
        "name": "number of splits",
        "id": 46,
        "options": [
          {"value": 5, "descriptor": "five", "id": 165},
          {"value": 2, "descriptor": "two", "id": 162},
          {"value": 4, "descriptor": "four", "id": 164},
          {"value": 3, "descriptor": "three", "id": 163},
          {"value": 1, "descriptor": "one", "id": 161}
        ]
      },
      {
        "name": "position of splitting",
        "id": 47,
        "options": [
          {"value": 3, "descriptor": "high", "id": 168},
          {"value": 1, "descriptor": "low", "id": 166},
          {"value": 2, "descriptor": "medium", "id": 167}
        ]
      }
    ]
  },
  {
    "id": "15",
    "category": "Stigma",
    "characteristics": [
      {
        "name": "position in relation to stamens",
        "id": 48,
        "options": [
          {"value": 2, "descriptor": "same level", "id": 170},
          {"value": 3, "descriptor": "above", "id": 171},
          {"value": 1, "descriptor": "below", "id": 169}
        ]
      }
    ]
  },
  {
    "id": "16",
    "category": "Ovary",
    "characteristics": [
      {
        "name": "hairs",
        "id": 49,
        "options": [
          {"value": 1, "descriptor": "absent", "id": 172},
          {"value": 9, "descriptor": "present", "id": 173}
        ]
      }
    ]
  },
  {
    "id": "17",
    "category": "Time of Flowering",
    "characteristics": [
      {
        "name": "time of flowering",
        "id": 50,
        "options": [
          {"value": 7, "descriptor": "late", "id": 177},
          {"value": 1, "descriptor": "very early", "id": 174},
          {"value": 5, "descriptor": "medium", "id": 176},
          {"value": 9, "descriptor": "very late", "id": 178},
          {"value": 3, "descriptor": "early", "id": 175}
        ]
      }
    ]
  }
];

class UpovCharacteristics extends StatefulWidget {
  const UpovCharacteristics({Key? key}) : super(key: key);

  @override
  Upov createState() => Upov();
}

class Upov extends State<UpovCharacteristics> {
  List<String> selectedValues = List.filled(50, 'idk');

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    return Column(children: [
      for (Map<String, dynamic> category in json)
        ExpansionTile(
            collapsedIconColor: primaryColor,
            collapsedTextColor: primaryColor,
            title: Text(
              category["category"],
              style: const TextStyle(fontSize: 18.0),
            ),
            children: [
              for (Map<String, dynamic> characteristic
                  in category["characteristics"])
                SmartSelect<String>.single(
                  title: characteristic["name"],
                  choiceItems: [
                    for (Map<String, dynamic> option
                        in characteristic["options"])
                      S2Choice<String>(
                          value: option["value"].toString(),
                          title: option["descriptor"])
                  ],
                  value: selectedValues[int.parse(category["id"]) - 1],
                  onChange: (selected) => setState(() =>
                      selectedValues[int.parse(category["id"]) - 1] =
                          selected.value),
                  modalType: S2ModalType.popupDialog,
                ),
            ])
    ]);
  }
}
