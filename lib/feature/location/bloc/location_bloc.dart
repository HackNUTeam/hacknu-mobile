import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacknu_mobile/feature/auth/model/user_data.dart';
import 'package:location/location.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  UserData? user;
  final Location location = new Location();
  WebSocketChannel? channel;

  LocationBloc() : super(LocationInactiveState()) {
    on<StartSendingLocation>((event, emit) async {
      emit(LoadingLocationState());
      user = event.user;
      await _initLocation();
      try {
        print("CONNECTION TO WS");
        channel = IOWebSocketChannel.connect('ws://3.70.126.190:4000/user',
            protocols: []);
        channel!.stream.listen(
          (dynamic message) {
            print('message $message');
          },
          onDone: () {
            print('ws channel closed');
          },
          onError: (error) {
            print('ws error $error');
          },
        );
        print("FINISHED CONNECTIONG");
      } catch (e) {
        print("ERROR CONNECTION $e");
      }
      emit(LocationActiveState());
    });
    on<StopSendingLocation>((event, emit) {
      channel!.sink.close();
      emit(LocationInactiveState());
    });
  }

  Future<void> _initLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    print(_locationData);
    double step = 0.00001;
    location.onLocationChanged.listen((LocationData currentLocation) {
      // Use current location
      print("Location changed");
      if (channel == null) return;
      try {
        channel!.sink.add(
          jsonEncode(
            {
              "lat": currentLocation.latitude! + step,
              "lng": currentLocation.longitude! + step,
              "altitude": (currentLocation.altitude! / 1000).round(),
              "userID": user!.id,
              "timestamp": DateTime.now().toIso8601String(),
              "floor": "green hall",
              "horizontalAccuracy": currentLocation.accuracy,
              "verticalAccuracy": currentLocation.verticalAccuracy,
              "activity": user!.work,
              "identifier": user!.username,
            },
          ),
        );
      } catch (e) {
        print("SENDING EXCEPTION $e");
        return;
      }
      step += 0.00001;
    });
  }
}
