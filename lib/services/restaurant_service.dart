import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantService{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference rest = FirebaseFirestore.instance.collection('restaurants');
  RestaurantService();

  Future<void> addRestaurant(Restaurant r){
    return rest.add(r.toJson()).then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}

class Restaurant {
  String title;
  String description;
  String image_url;
  GeoPoint point;

  Restaurant({this.title, this.description, this.image_url, this.point});

  Restaurant.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    description = json['Description'];
    image_url = json['URL'];
    point=json['Point'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.title;
    data['Description'] = this.description;
    data['URL'] = this.image_url;
    data['Point']=this.point;
    return data;
  }
}