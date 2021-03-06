import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:jagajarak/core/utils/systemSettings.dart';
import 'package:provider/provider.dart';
import 'package:jagajarak/core/provider/DeviceProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  final BuildContext context;
  final SharedPreferences shared;

  DeviceProvider _provider;

  Preferences(this.context, this.shared) {
    _provider = Provider.of(context, listen: false);
  }

  Future saveMacBluetooth(String mac) async {
    _provider.mac = mac;
    await shared.setString("mac_address", mac);
    await SystemSettings().setupOS();
  }

  Future saveHealthStatus(String status) async {
    _provider.health = status;
    await shared.setString("health", status);
  }

  Future saveUserName(String username) async {
    _provider.userName = username;
    await shared.setString("username", username);
  }

  Future saveServiceOnStart(bool value) async {
    _provider.startServiceOnStart = value;
    await shared.setBool("service_on_start", value);
  }

  Future saveMyLastLocation(double lat, double lng) async {
    await shared.setDouble("last_lat", lat);
    await shared.setDouble("last_lng", lat);
  }

  Future deleteKondisi() async {
    await shared.remove("kondisi");
  }

  Future clear() async {
    await shared.clear();
    _provider.init(context);
  }

  String getMacBluetooth() => shared.getString("mac_address");

  String getHealth() => shared.getString("health");

  String getUserName() => shared.getString("username");

  String getNoHp() => shared.getString("nohp");

  String getKondisi() => shared.getString("kondisi");

  bool getServiceOnStart() => shared.getBool("service_on_start") ?? false;

  Position getMyLastLocation() => Position(
        latitude: shared.getDouble("last_lat"),
        longitude: shared.getDouble("last_lng"),
      );

  static Future<Preferences> init(BuildContext context) async {
    return Preferences(context, await SharedPreferences.getInstance());
  }
}
