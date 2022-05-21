import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong/latlong.dart';
import 'specimen_popup.dart';

class ShowFullMap extends StatefulWidget {
  const ShowFullMap({Key? key}) : super(key: key);
  @override
  _ShowFullMapState createState() => _ShowFullMapState();
}

class _ShowFullMapState extends State<ShowFullMap> {
  int _current = 0;

  List<LatLng> _latLngList = [];
  List<Marker> _markers = [];

  late Map<LatLng, bool> _openPopUp;

  Map<LatLng, bool> initOpenPopUp() {
    Map<LatLng, bool> pop = {};
    for (var latlng in _latLngList) {
      pop[latlng] = false;
    }
    return pop;
  }

  @override
  void initState() {
    _latLngList = [
      LatLng(40.6384943, -8.6540832),
      LatLng(40.6391863, -8.6563771),
      LatLng(40.6364017, -8.6532305),
      LatLng(40.6335806, -8.6519005),
      LatLng(40, -8),
      LatLng(41.6335806, -7.6519005),
      LatLng(40.6335806, -8.6419005),
      LatLng(39.6335806, -9.0419005)
    ];
    _openPopUp = initOpenPopUp();
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

    final PopupController _popupController = PopupController();
    MapController _mapController = MapController();
    double _zoom = 12;

    _markers = _latLngList
        .map((point) => Marker(
              point: point,
              width: 200,
              height: 220,
              builder: (context) => GestureDetector(
                  onTap: () {
                    setState(() {
                      // infoWindowVisible = !infoWindowVisible;
                      _openPopUp[point] = !_openPopUp[point]!;
                      // print("changed to " + _openPopUp[point].toString());
                    });
                  },
                  child: _buildCustomMarker(point)),
              // Icon(
              //   Icons.location_on,
              //   size: 60,
              //   color: primaryColor,
              // ),
            ))
        .toList();

    return Container(
        color: Colors.transparent,
        child: Scaffold(
          backgroundColor: primaryColor,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: primaryColor,
            ),
            backgroundColor: Colors.white,
            title: const Text(
              'Camellia Map',
              style: TextStyle(color: Color(0xFF064E3B)),
            ),
            centerTitle: true,
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: _latLngList[0],
                bounds: LatLngBounds.fromPoints(_latLngList),
                zoom: _zoom,
                plugins: [
                  MarkerClusterPlugin(),
                ],
                onTap: (_) => setState(() {
                  infoWindowVisible = false;
                  for (LatLng b in _openPopUp.keys) {
                    _openPopUp[b] = false;
                  }
                }),
              ),
              layers: [
                TileLayerOptions(
                  minZoom: 1,
                  maxZoom: 18,
                  backgroundColor: primaryColor,
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerClusterLayerOptions(
                  // maxClusterRadius: 190,
                  disableClusteringAtZoom: 16,
                  size: const Size(50, 50),
                  fitBoundsOptions: const FitBoundsOptions(
                    padding: EdgeInsets.all(50),
                  ),
                  markers: _markers,
                  polygonOptions: PolygonOptions(
                      borderColor: primaryColor,
                      color: Colors.black12,
                      borderStrokeWidth: 3),
                  builder: (context, markers) {
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: primaryColor, shape: BoxShape.circle),
                      child: Text(
                        '${markers.length}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }

  Stack _buildCustomMarker(LatLng point) {
    return Stack(
      children: <Widget>[popup(point), marker(point)],
    );
  }

  var infoWindowVisible = false;

  Opacity popup(LatLng point) {
    // print(_latLngList);
    // print(_openPopUp[point]);
    return Opacity(
      opacity: _openPopUp[point]! ? 1.0 : 0.0,
      child: Container(
        alignment: Alignment.bottomCenter,
        width: 200,
        height: 250,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: _openPopUp[point]! ? CustomPopup() : null,
      ),
    );
  }

  Opacity marker(LatLng point) {
    return Opacity(
      child: Container(
        alignment: Alignment.center,
        child: const Icon(
          Icons.location_on_outlined,
          size: 30,
          color: Color(0xFF064E3B),
        ),
      ),
      opacity: _openPopUp[point]! ? 0.0 : 1.0,
    );
  }
}