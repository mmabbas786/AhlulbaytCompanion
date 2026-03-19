import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/prayer_times_model.dart';

class PrayerService {
  static final PrayerService _instance = PrayerService._internal();
  factory PrayerService() => _instance;
  PrayerService._internal();

  /// Fetches prayer times from Aladhan API (Method 4 = Jafari/Shia Shia Ithna-Ashari, Leva Institute, Qum)
  Future<PrayerTimesModel?> getPrayerTimes() async {
    try {
      Position position = await _determinePosition();
      
      final url = Uri.parse(
          'https://api.aladhan.com/v1/timings?latitude=${position.latitude}&longitude=${position.longitude}&method=4');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final timings = data['data']['timings'];
        
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('cached_prayer_times', jsonEncode(timings));

        return PrayerTimesModel.fromJson(timings);
      } else {
        return _getCachedPrayerTimes();
      }
    } catch (e) {
      return _getCachedPrayerTimes();
    }
  }

  Future<PrayerTimesModel?> _getCachedPrayerTimes() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString('cached_prayer_times');
    if (cachedData != null) {
      return PrayerTimesModel.fromJson(jsonDecode(cachedData));
    }
    return null;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    } 

    return await Geolocator.getCurrentPosition();
  }
}
