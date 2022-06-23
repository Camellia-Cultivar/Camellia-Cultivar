import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong/latlong.dart';
import '../api/api_service.dart';
import 'specimen_popup.dart';

class ShowFullMap extends StatefulWidget {
  final List<dynamic>? specimens;
  const ShowFullMap(this.specimens, {Key? key}) : super(key: key);
  @override
  _ShowFullMapState createState() => _ShowFullMapState();
}

class _ShowFullMapState extends State<ShowFullMap> {
  late Map<LatLng, bool> _openPopUp = {};
  final api = APIService();

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  List<LatLng> _latLngList = [];
  List<Marker> _markers = [];

  Map<LatLng, bool> initOpenPopUp() {
    Map<LatLng, bool> pop = {};

    for (var latlng in _latLngList) {
      pop[latlng] = false;
    }
    return pop;
  }

  @override
  void initState() {
    super.initState();
    _latLngList = widget.specimens!
        .map((specimen) => specimen!["coords"] as LatLng)
        .toList();

    // _openPopUp = initOpenPopUp();
    // if (_latLngList.isEmpty) {
    //   _latLngList.add(LatLng(40, -8));
    // }
    _openPopUp = initOpenPopUp();
  }

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    double _zoom = 12;
    MapController _mapController = MapController();

    setState(() {
      _markers = _latLngList
          .map((point) => Marker(
                point: point,
                width: 200,
                height: 220,
                builder: (context) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _openPopUp[point] = !_openPopUp[point]!;
                      });
                    },
                    child: _buildCustomMarker(
                        point, getSpecimenByLatLong(point, widget.specimens!))),
              ))
          .toList();
    });

    return _buildMap(context);
  }

  Widget _buildMap(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    double _zoom = 12;
    MapController _mapController = MapController();

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
                // center: _latLngList.isNotEmpty ? _latLngList[0] : LatLng(0, 0),
                bounds: _latLngList.isNotEmpty
                    ? LatLngBounds.fromPoints(_latLngList)
                    : LatLngBounds.fromPoints([LatLng(20, -8), LatLng(50, -8)]),
                zoom: _zoom,
                plugins: [
                  MarkerClusterPlugin(),
                ],
                onTap: (_) => setState(() {
                  // infoWindowVisible = false;
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

  Stack _buildCustomMarker(LatLng point, Map<String, dynamic>? specimen) {
    return Stack(
      children: <Widget>[popup(point, specimen), marker(point)],
    );
  }

  var infoWindowVisible = false;

  Opacity popup(LatLng point, Map<String, dynamic>? specimen) {
    return Opacity(
      opacity: _openPopUp[point]! ? 1.0 : 0.0,
      child: Container(
        alignment: Alignment.bottomCenter,
        width: 200,
        height: 250,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: _openPopUp[point]! ? SpecimenPopup(specimen: specimen) : null,
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

Map<String, dynamic>? getSpecimenByLatLong(LatLng point, List specimens) {
  for (Map<String, dynamic> specimen in specimens) {
    if (point == specimen["coords"]) {
      return specimen;
    }
  }
  return null;
}
