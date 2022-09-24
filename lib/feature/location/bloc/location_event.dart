part of 'location_bloc.dart';

abstract class LocationEvent {}

class StartSendingLocation extends LocationEvent {
  final UserData user;

  StartSendingLocation(this.user);
}

class StopSendingLocation extends LocationEvent {}
