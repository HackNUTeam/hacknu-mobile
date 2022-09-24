part of 'location_bloc.dart';

abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationActiveState extends LocationState {}

class LocationInactiveState extends LocationState {}

class LoadingLocationState extends LocationState {}
