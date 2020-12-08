import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
class Address{
  double latitude;
  double longitude;
  String currentAddress;
  //Position _currentPosition;
  Address(double latitude,double longitude){
    this.longitude=longitude;
    this.latitude=latitude;
  }
  getAddressFromLatLng() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(latitude, longitude);
      Placemark place = p[0];
      currentAddress="${place.locality}, ${place.postalCode}, ${place.country}, ${place.administrativeArea}";
    } catch (e) {
      print(e);
    }
  }
}
