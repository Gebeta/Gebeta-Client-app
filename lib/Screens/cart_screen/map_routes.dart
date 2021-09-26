import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:gebeta_food/Screens/cart_screen/cart_final.dart';
import 'package:gebeta_food/constants.dart';
import 'package:gebeta_food/models/direction_detail.dart';
import 'package:gebeta_food/models/profile.dart';
import 'package:gebeta_food/scoped-models/main.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapRoutesScreen extends StatefulWidget {
  final String restaurantId;
  final MainModel model;
  final double totalAmount;
  MapRoutesScreen(this.restaurantId, this.model,this.totalAmount);

  @override
  _MapRoutesScreenState createState() => _MapRoutesScreenState();
}

class _MapRoutesScreenState extends State<MapRoutesScreen> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;
  DirectionDetails directionDetails = DirectionDetails(distanceValue: 0, durationValue: 0, distanceText: "", durationText: "", encodedPoints: "");

  List<LatLng> plineCoordinates = [];
  Set<Polyline> polyLineSet = {};

  static final CameraPosition _addisAbaba = CameraPosition(
    target: LatLng(8.9806, 38.7578),
    zoom: 14.4746,
  );

  late Position currrentPosition;
  late Profile userProfile;

  Set<Marker> markerSet = {};
  Set<Circle> circleSet = {};

  var geoLocator = Geolocator();
  void getCurrentUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currrentPosition = position;
    LatLng latLngPos = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition = new CameraPosition(
      target: latLngPos,
      zoom: 15,
    );
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    print(
        "your location ${latLngPos.latitude.toString()}, ${latLngPos.longitude.toString()}");
  }

  @override
  void initState() {
    userProfile = widget.model.getUserProfile;
    double latitude = userProfile.locationLatitude;
    double longtidue = userProfile.locationLongtiude;
    getPlaceDirection(widget.model);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("See Route"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _addisAbaba,
            polylines: polyLineSet,
            markers: markerSet,
            circles: circleSet,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
              getCurrentUserLocation();
            },
          ),
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60), color: Colors.white),
              child: IconButton(
                icon: Icon(Icons.my_location),
                onPressed: () {
                  getCurrentUserLocation();
                },
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              height: 150,
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    )
                  ]),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        (directionDetails!=null)? '${directionDetails.durationText}' :"",
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w500,
                          color: gPrimaryColor
                        ),
                      ),
                      Text(
                        (directionDetails!=null)? " (${directionDetails.distanceText})": "",
                        style: TextStyle(
                          fontSize:17,
                          fontWeight: FontWeight.w400
                        ),
                      )
                    ],
                  ),
                  Text(
                    ((directionDetails!=null)? '${widget.model.calculateFare(directionDetails).toStringAsFixed(2)} ETB': ""),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FinalCart(widget.model.calculateFare(directionDetails),widget.model, widget.totalAmount)));
                  }, child: Text("Go to Next Step"))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> getPlaceDirection(MainModel model) async {
    print("Print");
    print(await model.getRestaurantLocation(widget.restaurantId));
    var details = await model.obtainPlacesDirectionDetails(
        await model.getRestaurantLocation(widget.restaurantId), await model.getUserLocation(model.getUser.id));

    directionDetails = details;
    print("object");
    print(details.encodedPoints);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolyLinePoints =
        polylinePoints.decodePolyline(details.encodedPoints);

    plineCoordinates.clear();
    if (decodedPolyLinePoints.isNotEmpty) {
      decodedPolyLinePoints.forEach((PointLatLng pointLatLng) {
        plineCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });

      polyLineSet.clear();

      setState(() {
        Polyline polyline = Polyline(
          color: gPrimaryColor,
          polylineId: PolylineId("polylineID"),
          jointType: JointType.round,
          points: plineCoordinates,
          width: 5,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
        );
        polyLineSet.add(polyline);
      });
    }

    var pickUpLatLng = LatLng(9.034806, 38.759693);
    var dropOffLatLng = LatLng(9.040294, 38.761715);
    Marker pickUpMarker = Marker(
      markerId: MarkerId("pickUpId"),
      infoWindow:
          InfoWindow(title: "Restaurant Location", snippet: "pick up Location"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      position: pickUpLatLng,
    );
    Marker dropOffMarker = Marker(
      markerId: MarkerId("dropoffId"),
      infoWindow:
          InfoWindow(title: "User Location", snippet: "drop off Location"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      position: dropOffLatLng,
    );

    setState(() {
      markerSet.add(pickUpMarker);
      markerSet.add(dropOffMarker);
    });

    Circle pickUpCircle = Circle(
        fillColor: Colors.blue,
        circleId: CircleId("pickup"),
        center: pickUpLatLng,
        radius: 12,
        strokeWidth: 4,
        strokeColor: Colors.blueAccent);
    Circle dropOffCircle = Circle(
        fillColor: Colors.deepPurple,
        circleId: CircleId("dropOff"),
        center: dropOffLatLng,
        radius: 12,
        strokeWidth: 4,
        strokeColor: Colors.deepPurple);

    setState(() {
      circleSet.add(pickUpCircle);
      circleSet.add(dropOffCircle);
    });
  }
}
