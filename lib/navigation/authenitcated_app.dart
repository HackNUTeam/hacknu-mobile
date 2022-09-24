import 'package:awesome_ripple_animation/awesome_ripple_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacknu_mobile/core/animated_button.dart';
import 'package:hacknu_mobile/core/image_config.dart';
import 'package:hacknu_mobile/feature/auth/bloc/auth_bloc.dart';
import 'package:hacknu_mobile/feature/auth/model/user_data.dart';
import 'package:hacknu_mobile/feature/location/bloc/location_bloc.dart';

class AuthenticatedApp extends StatefulWidget {
  const AuthenticatedApp({super.key});

  @override
  State<AuthenticatedApp> createState() => _AuthenticatedAppState();
}

class _AuthenticatedAppState extends State<AuthenticatedApp> {
  final LocationBloc locationBloc = LocationBloc();

  void startSos() {
    var state =
        BlocProvider.of<AuthBloc>(context).state as AuthenticatedAuthState;
    locationBloc.add(StartSendingLocation(state.user));
  }

  void stopSos() {
    locationBloc.add(StopSendingLocation());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocationBloc>(
      create: (context) => locationBloc,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              _buildHeader(),
              const SizedBox(height: 100.0),
              _buildText(),
              const SizedBox(height: 100.0),
              BlocBuilder<LocationBloc, LocationState>(
                  builder: (context, state) {
                if (state is LocationActiveState) {
                  return Center(child: _buildStopButton());
                }
                if (state is LocationInactiveState) {
                  return _buildEmergencyButton();
                }
                if (state is LoadingLocationState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Container();
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText() {
    return Column(
      children: const [
        Text(
          "Emergency help\nneeded?",
          style: TextStyle(
            color: Colors.black,
            fontSize: 35.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 30),
        Text(
          "Just press the button",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 25.0,
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildStopButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200.0,
      color: Colors.red,
      margin: const EdgeInsets.only(left: 100),
      child: RippleAnimation(
        color: Colors.red.withOpacity(0.4),
        delay: const Duration(milliseconds: 100),
        repeat: true,
        minRadius: 90,
        child: AnimatedButton(
          onPressed: () {
            stopSos();
          },
          shape: BoxShape.circle,
          width: 200.0,
          height: 200.0,
          color: Colors.red,
          child: const Center(
            child: Text(
              "Stop",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 50.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmergencyButton() {
    return AnimatedButton(
      onPressed: () {
        startSos();
      },
      shape: BoxShape.circle,
      width: 200.0,
      height: 200.0,
      color: Colors.red,
      child: const Center(
        child: Text(
          "SOS",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 50.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is AuthenticatedAuthState) {
        return _buildUserCard(state.user);
      }
      return Container();
    });
  }

  Widget _buildUserCard(UserData user) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 3,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  ImageConfig.main,
                  width: 50.0,
                  height: 50.0,
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.username,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      user.email,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
              },
              child: const Text(
                "logout",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
