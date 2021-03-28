import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RestaurantService {
  CollectionReference _rest =
      FirebaseFirestore.instance.collection('restaurants');

  Future<void> addRestaurant(Restaurant r) async {
    return await _rest
        .add(r.toJson())
        .then((value) => {print("User Added")})
        .catchError((error) => {print("Failed to add user: $error")});
  }

  Future<List<Restaurant>> getAllRestaurants() async {
    List<Restaurant> listRest;
    var res = await this._rest.get();
    listRest = res.docs.map((doc) => Restaurant.fromJson(doc.data())).toList();
    return listRest;
  }

  Future<void> registerVisit(Restaurant r) async {
    return await FirebaseFirestore.instance.collection('visits').doc(r.title).collection(DateTime.now().toString()).add({
      "totalCount":FieldValue.increment(1)
    });
  }
}

class Restaurant {
  String title;
  String description;
  String image_url;
  GeoPoint point;
  String url_qr;
  Restaurant(
      {this.title, this.description, this.image_url, this.point, this.url_qr});

  Restaurant.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    description = json['Description'];
    image_url = json['URL'];
    point = json['Point'];
    url_qr = json['url_qr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.title;
    data['Description'] = this.description;
    data['URL'] = this.image_url;
    data['Point'] = this.point;
    data['url_qr'] = this.url_qr;
    return data;
  }
}
