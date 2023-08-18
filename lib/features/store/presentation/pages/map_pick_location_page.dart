// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

// import '../../../../core/extensions/routing_extensions.dart';
// import '../../../../services/location_service.dart';

// class MapPickLocationPage extends StatefulWidget {
//   const MapPickLocationPage({Key? key}) : super(key: key);

//   @override
//   State<MapPickLocationPage> createState() => _MapPickLocationPageState();
// }

// class _MapPickLocationPageState extends State<MapPickLocationPage> with WidgetsBindingObserver {
//   late CameraPosition _initialCameraPosition;
//   late Completer<GoogleMapController> _controller;
//   LatLng? currentLocation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = Completer<GoogleMapController>();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     if (state == AppLifecycleState.resumed) {
//       setState(() {
//         _controller = Completer<GoogleMapController>();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         appBar: AppBar(),
//         body: FutureBuilder<LocationData?>(
//           future: LocationService.getUserLocation(),
//           builder: (context, AsyncSnapshot<LocationData?> snapshot) {
//             if (!snapshot.hasData) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             _initialCameraPosition = CameraPosition(
//               target: LatLng(
//                 snapshot.data!.latitude!,
//                 snapshot.data!.longitude!,
//               ),
//               zoom: 16.4746,
//             );
//             currentLocation = _initialCameraPosition.target;
//             return Stack(
//               alignment: Alignment.center,
//               children: [
//                 GoogleMap(
//                   myLocationButtonEnabled: false,
//                   onMapCreated: (controller) async {
//                     String mapStyle = await DefaultAssetBundle.of(context).loadString("assets/map_style.json");
//                     controller.setMapStyle(mapStyle);
//                     _controller.complete(controller);
//                   },
//                   initialCameraPosition: _initialCameraPosition,
//                   onCameraMove: (position) {
//                     currentLocation = position.target;
//                   },
//                   zoomControlsEnabled: false,
//                 ),
//                 const SizedBox(
//                   width: 35,
//                   height: 35,
//                   child: Icon(Icons.location_on),
//                 ),
//                 Positioned(
//                   bottom: 10,
//                   left: 8,
//                   child: Column(
//                     children: [
//                       InkWell(
//                         onTap: () async {
//                           var myLocation = await LocationService.getUserLocation();
//                           if (myLocation == null) return;
//                           var googleMapController = await _controller.future;
//                           googleMapController.animateCamera(
//                             CameraUpdate.newCameraPosition(
//                               CameraPosition(
//                                 target: LatLng(
//                                   myLocation.latitude!,
//                                   myLocation.longitude!,
//                                 ),
//                                 zoom: 16.4746,
//                               ),
//                             ),
//                           );
//                         },
//                         child: Card(
//                           elevation: 12,
//                           shape: const CircleBorder(),
//                           child: Container(
//                             height: 50,
//                             width: 50,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             child: const Icon(
//                               Icons.gps_fixed,
//                             ),
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         splashColor: Colors.white24,
//                         onTap: () {
//                           context.myPop<LatLng?>(currentLocation);
//                         },
//                         child: Card(
//                           shape: const CircleBorder(),
//                           elevation: 12,
//                           child: Container(
//                             height: 70,
//                             width: 70,
//                             decoration: BoxDecoration(
//                               color: Theme.of(context).primaryColor,
//                               borderRadius: BorderRadius.circular(40),
//                             ),
//                             child: const Icon(
//                               Icons.send,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
