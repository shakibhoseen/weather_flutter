import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_flutter/bloc/weather_bloc_bloc.dart';
import 'package:weather_flutter/utils/position.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: Container(
              decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.blue.shade300, Colors.blueAccent])),
              height: MediaQuery.of(context).size.height,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 300,
                      width: 600,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 124, 255, 64),
                      ),
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.transparent),
                    ),
                  ),
                  BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                    builder: (context, state) {
                      if (state is WeatherBlocSuccess) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text(
                                '${state.weather.areaName}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              const Text(
                                'Good Morning',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                              Expanded(
                                  child:
                                      Center(child:getWeatherIcon(state.weather.weatherConditionCode?? 0))),
                               Center(
                                child: Text(
                                  '${state.weather.temperature!.celsius!.round()}°C',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 55,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                               Center(
                                child: Text(
                                  state.weather.weatherMain!.toUpperCase(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                               Center(
                                child: Text(
                                  DateFormat('EEEE dd •').add_jm().format(state.weather.date!),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  currentWeather(
                                      path: 'assets/11.png',
                                      event: 'Sunrise',
                                      time: DateFormat().add_jm().format(state.weather.sunrise!)),
                                  currentWeather(
                                      path: 'assets/12.png',
                                      event: 'Sunset',
                                      time: DateFormat().add_jm().format(state.weather.sunset!)),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  currentWeather(
                                      path: 'assets/13.png',
                                      event: 'Temp Max',
                                      time: '${state.weather.tempMax!.celsius!.round()} °C'),
                                  currentWeather(
                                      path: 'assets/14.png',
                                      event: 'Temp Min',
                                      time: '${state.weather.tempMin!.celsius!.round()} °C'),
                                ],
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        
        
      ),
    );
  }
}

Widget currentWeather(
    {required String path, required String event, required String time}) {
  return Row(
    children: [
      Image.asset(
        path,
        scale: 8,
      ),
      const SizedBox(
        width: 3,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w300),
          ),
          Text(
            time,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ],
      )
    ],
  );
}
