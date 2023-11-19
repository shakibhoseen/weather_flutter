import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_flutter/data/my_data.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        WeatherFactory wf =
            WeatherFactory(API_KEY, language: Language.ENGLISH);

        
        Weather weather = await wf.currentWeatherByLocation(
            event.position.latitude, event.position.longitude);
            print('hey ');
            print(weather);
        emit(WeatherBlocSuccess(weather));
      } catch (e) {
        print('hey ${e}');
        emit(WeatherBlocFailure());
      }
    });
  }
}
