import 'dart:io';
import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import 'upov.dart';

class UpovCharacteristics extends StatefulWidget {
  const UpovCharacteristics({Key? key}) : super(key: key);

  @override
  Upov createState() => Upov();
}

class Upov extends State<UpovCharacteristics> {
  List<String> selected_values = List.filled(50, 'idk');
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;

    return Column(children: [
      ExpansionTile(
        collapsedIconColor: primaryColor,
        collapsedTextColor: primaryColor,
        title: const Text(
          "Plant",
          style: TextStyle(fontSize: 18.0),
        ),
        children: <Widget>[
          SmartSelect<String>.single(
            title: 'Growth Habit',
            choiceItems: plant_growth,
            value: selected_values[0],
            onChange: (selected) =>
                setState(() => selected_values[0] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Density of Foliage',
            choiceItems: plant_density,
            value: selected_values[1],
            onChange: (selected) =>
                setState(() => selected_values[1] = selected.value),
            modalType: S2ModalType.popupDialog,
          )
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      ExpansionTile(
        collapsedIconColor: primaryColor,
        collapsedTextColor: primaryColor,
        title: const Text(
          "Branch",
          style: TextStyle(fontSize: 18.0),
        ),
        children: <Widget>[
          SmartSelect<String>.single(
            title: 'Zigzagging',
            choiceItems: branch_zigzagging,
            value: selected_values[2],
            onChange: (selected) =>
                setState(() => selected_values[2] = selected.value),
            modalType: S2ModalType.popupDialog,
          )
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      ExpansionTile(
        collapsedIconColor: primaryColor,
        collapsedTextColor: primaryColor,
        title: const Text(
          "Vegetative Bud",
          style: TextStyle(fontSize: 18.0),
        ),
        children: <Widget>[
          SmartSelect<String>.single(
            title: 'Color',
            choiceItems: vegetativeBud_color,
            value: selected_values[3],
            onChange: (selected) =>
                setState(() => selected_values[3] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      ExpansionTile(
        collapsedIconColor: primaryColor,
        collapsedTextColor: primaryColor,
        title: const Text(
          "Terminal Vegetative Bud",
          style: TextStyle(fontSize: 18.0),
        ),
        children: <Widget>[
          SmartSelect<String>.single(
            title: 'Number',
            choiceItems: terminalVegetativeBud_number,
            value: selected_values[4],
            onChange: (selected) =>
                setState(() => selected_values[4] = selected.value),
            modalType: S2ModalType.popupDialog,
          )
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      ExpansionTile(
        collapsedIconColor: primaryColor,
        collapsedTextColor: primaryColor,
        title: const Text(
          "Young Shoot",
          style: TextStyle(fontSize: 18.0),
        ),
        children: <Widget>[
          SmartSelect<String>.single(
            title: 'Color',
            choiceItems: youngShoot_color,
            value: selected_values[5],
            onChange: (selected) =>
                setState(() => selected_values[5] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      ExpansionTile(
        collapsedIconColor: primaryColor,
        collapsedTextColor: primaryColor,
        title: const Text(
          "Leaf",
          style: TextStyle(fontSize: 18.0),
        ),
        children: <Widget>[
          SmartSelect<String>.single(
            title: 'Attitude',
            choiceItems: leaf_attitude,
            value: selected_values[6],
            onChange: (selected) =>
                setState(() => selected_values[6] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Arrangement',
            choiceItems: leaf_arrangement,
            value: selected_values[7],
            onChange: (selected) =>
                setState(() => selected_values[7] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      ExpansionTile(
        collapsedIconColor: primaryColor,
        collapsedTextColor: primaryColor,
        title: const Text(
          "Leaf Blade",
          style: TextStyle(fontSize: 18.0),
        ),
        children: <Widget>[
          SmartSelect<String>.single(
            title: 'Length',
            choiceItems: leafBlade_length,
            value: selected_values[8],
            onChange: (selected) =>
                setState(() => selected_values[8] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Width',
            choiceItems: leafBlade_width,
            value: selected_values[9],
            onChange: (selected) =>
                setState(() => selected_values[9] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Position of Broadest Part',
            choiceItems: leafBlade_positionOfBroadestPart,
            value: selected_values[10],
            onChange: (selected) =>
                setState(() => selected_values[10] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Shape of Base',
            choiceItems: leafBlade_shapeOfBase,
            value: selected_values[11],
            onChange: (selected) =>
                setState(() => selected_values[11] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Shape of Apex',
            choiceItems: leafBlade_shapeOfApex,
            value: selected_values[12],
            onChange: (selected) =>
                setState(() => selected_values[12] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Pubescence on Upper Side',
            choiceItems: leafBlade_pubescenceOnUpperSide,
            value: selected_values[13],
            onChange: (selected) =>
                setState(() => selected_values[13] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Thickness',
            choiceItems: leafBlade_thickness,
            value: selected_values[14],
            onChange: (selected) =>
                setState(() => selected_values[14] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Venation on Upper Side',
            choiceItems: leafBlade_venationOnUpperSide,
            value: selected_values[15],
            onChange: (selected) =>
                setState(() => selected_values[15] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Glossiness of Upper Side',
            choiceItems: leafBlade_glossinessOfUpperSide,
            value: selected_values[16],
            onChange: (selected) =>
                setState(() => selected_values[16] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Variegation',
            choiceItems: leafBlade_variegation,
            value: selected_values[17],
            onChange: (selected) =>
                setState(() => selected_values[17] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Color of Upper Side',
            choiceItems: leafBlade_colorOfUpperSide,
            value: selected_values[18],
            onChange: (selected) =>
                setState(() => selected_values[18] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Color of Variegation',
            choiceItems: leafBlade_colorOfVariegation,
            value: selected_values[19],
            onChange: (selected) =>
                setState(() => selected_values[19] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Distribution of Variegation',
            choiceItems: leafBlade_distributionOfVariegation,
            value: selected_values[20],
            onChange: (selected) =>
                setState(() => selected_values[20] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Shape in Cross Section',
            choiceItems: leafBlade_shapeInCrossSection,
            value: selected_values[21],
            onChange: (selected) =>
                setState(() => selected_values[21] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Margin',
            choiceItems: leafBlade_margin,
            value: selected_values[22],
            onChange: (selected) =>
                setState(() => selected_values[22] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      ExpansionTile(
        collapsedIconColor: primaryColor,
        collapsedTextColor: primaryColor,
        title: const Text(
          "Petiole",
          style: TextStyle(fontSize: 18.0),
        ),
        children: <Widget>[
          SmartSelect<String>.single(
            title: 'Length',
            choiceItems: petiole_length,
            value: selected_values[23],
            onChange: (selected) =>
                setState(() => selected_values[23] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      ExpansionTile(
        collapsedIconColor: primaryColor,
        collapsedTextColor: primaryColor,
        title: const Text(
          "Sepal",
          style: TextStyle(fontSize: 18.0),
        ),
        children: <Widget>[
          SmartSelect<String>.single(
            title: 'Position of Broadest Part',
            choiceItems: sepal_positionOfBroadestPart,
            value: selected_values[24],
            onChange: (selected) =>
                setState(() => selected_values[24] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Color of Outer Side',
            choiceItems: sepal_colorOfOuterSide,
            value: selected_values[25],
            onChange: (selected) =>
                setState(() => selected_values[25] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Shape of Apex',
            choiceItems: sepal_shapeOfApex,
            value: selected_values[26],
            onChange: (selected) =>
                setState(() => selected_values[26] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      ExpansionTile(
        collapsedIconColor: primaryColor,
        collapsedTextColor: primaryColor,
        title: const Text(
          "Flower Bud",
          style: TextStyle(fontSize: 18.0),
        ),
        children: <Widget>[
          SmartSelect<String>.single(
            title: 'Arrangement',
            choiceItems: flowerBud_arrangement,
            value: selected_values[27],
            onChange: (selected) =>
                setState(() => selected_values[27] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      ExpansionTile(
        collapsedIconColor: primaryColor,
        collapsedTextColor: primaryColor,
        title: const Text(
          "Flower",
          style: TextStyle(fontSize: 18.0),
        ),
        children: <Widget>[
          SmartSelect<String>.single(
            title: 'Diameter',
            choiceItems: flower_diameter,
            value: selected_values[28],
            onChange: (selected) =>
                setState(() => selected_values[28] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Form',
            choiceItems: flower_form,
            value: selected_values[29],
            onChange: (selected) =>
                setState(() => selected_values[29] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Presence of Petaloids',
            choiceItems: flower_presenceOfPetaloids,
            value: selected_values[30],
            onChange: (selected) =>
                setState(() => selected_values[30] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Number of Petaloids',
            choiceItems: flower_numberOfPetaloids,
            value: selected_values[31],
            onChange: (selected) =>
                setState(() => selected_values[31] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Petaloid Organs',
            choiceItems: flower_petaloidOrgans,
            value: selected_values[32],
            onChange: (selected) =>
                setState(() => selected_values[32] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Shape of Petals of First Outer Row',
            choiceItems: flower_shapeOfPetalsOfFirstOuterRow,
            value: selected_values[33],
            onChange: (selected) =>
                setState(() => selected_values[33] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      ExpansionTile(
        collapsedIconColor: primaryColor,
        collapsedTextColor: primaryColor,
        title: const Text(
          "Petal",
          style: TextStyle(fontSize: 18.0),
        ),
        children: <Widget>[
          SmartSelect<String>.single(
            title: 'Thickness',
            choiceItems: petal_thickness,
            value: selected_values[34],
            onChange: (selected) =>
                setState(() => selected_values[34] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Shape of Apex',
            choiceItems: petal_shapeOfApex,
            value: selected_values[35],
            onChange: (selected) =>
                setState(() => selected_values[35] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Number of Incisions of Margin',
            choiceItems: petal_numberOfIncisionsOfMargin,
            value: selected_values[36],
            onChange: (selected) =>
                setState(() => selected_values[36] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Curvature of Longitudinal Axis',
            choiceItems: petal_curvatureOfLongitudinalAxis,
            value: selected_values[37],
            onChange: (selected) =>
                setState(() => selected_values[37] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Ondulation of Margin',
            choiceItems: petal_ondulationOfMargin,
            value: selected_values[38],
            onChange: (selected) =>
                setState(() => selected_values[38] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Conspicuousness of Veins',
            choiceItems: petal_conspicuousnessOfVeins,
            value: selected_values[39],
            onChange: (selected) =>
                setState(() => selected_values[39] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Main Color',
            choiceItems: petal_mainColor,
            value: selected_values[40],
            onChange: (selected) =>
                setState(() => selected_values[40] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Distribution of Shading of Main Color',
            choiceItems: petal_distributionOfShadingOfMainColor,
            value: selected_values[41],
            onChange: (selected) =>
                setState(() => selected_values[41] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Secondary Color',
            choiceItems: petal_secondaryColor,
            value: selected_values[42],
            onChange: (selected) =>
                setState(() => selected_values[42] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Distribution of Secondary Color',
            choiceItems: petal_distributionOfSecondaryColor,
            value: selected_values[43],
            onChange: (selected) =>
                setState(() => selected_values[43] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      ExpansionTile(
        collapsedIconColor: primaryColor,
        collapsedTextColor: primaryColor,
        title: const Text(
          "Stamens",
          style: TextStyle(fontSize: 18.0),
        ),
        children: <Widget>[
          SmartSelect<String>.single(
            title: 'Arrangement',
            choiceItems: stamens_arrangement,
            value: selected_values[44],
            onChange: (selected) =>
                setState(() => selected_values[44] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      ExpansionTile(
        collapsedIconColor: primaryColor,
        collapsedTextColor: primaryColor,
        title: const Text(
          "Style",
          style: TextStyle(fontSize: 18.0),
        ),
        children: <Widget>[
          SmartSelect<String>.single(
            title: 'Number of Splits',
            choiceItems: style_numberOfSplits,
            value: selected_values[45],
            onChange: (selected) =>
                setState(() => selected_values[45] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
          SmartSelect<String>.single(
            title: 'Position of Splitting',
            choiceItems: style_positionOfSplitting,
            value: selected_values[46],
            onChange: (selected) =>
                setState(() => selected_values[46] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      ExpansionTile(
        collapsedIconColor: primaryColor,
        collapsedTextColor: primaryColor,
        title: const Text(
          "Stigma",
          style: TextStyle(fontSize: 18.0),
        ),
        children: <Widget>[
          SmartSelect<String>.single(
            title: 'Position in Relation to Stamens',
            choiceItems: stigma_positionInRelationToStamens,
            value: selected_values[47],
            onChange: (selected) =>
                setState(() => selected_values[47] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      ExpansionTile(
        collapsedIconColor: primaryColor,
        collapsedTextColor: primaryColor,
        title: const Text(
          "Ovary",
          style: TextStyle(fontSize: 18.0),
        ),
        children: <Widget>[
          SmartSelect<String>.single(
            title: 'Hairs',
            choiceItems: ovary_hairs,
            value: selected_values[48],
            onChange: (selected) =>
                setState(() => selected_values[48] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      ExpansionTile(
        collapsedIconColor: primaryColor,
        collapsedTextColor: primaryColor,
        title: const Text(
          "Time of Flowering",
          style: TextStyle(fontSize: 18.0),
        ),
        children: <Widget>[
          SmartSelect<String>.single(
            title: 'Time of Flowering',
            choiceItems: timeOfFlowering,
            value: selected_values[49],
            onChange: (selected) =>
                setState(() => selected_values[49] = selected.value),
            modalType: S2ModalType.popupDialog,
          ),
        ],
      ),
    ]);
  }
}
