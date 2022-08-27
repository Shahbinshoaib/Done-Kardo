import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmhouse_app/authenticate/auth.dart';

class DatabaseService{
  final String category;
  final String title;
  final String email;


  final CollectionReference usersCollection = Firestore.instance.collection('Users Data');
  final CollectionReference farmCollection = Firestore.instance.collection('Farmhouse Data');
  final CollectionReference queryCollection = Firestore.instance.collection('Query Data');
  final CollectionReference mailCollection = Firestore.instance.collection('mail');

  DatabaseService({this.category, this.title,this.email});

  Future updateUsersData(String username, String pic, String email) async{
    return await usersCollection.document(email).setData({
      'Username' : username,
      'Pic' : pic,
      'Email': email,
    });
  }

  Future updateFarmData(String category, String pic1, String pic2, String pic3, String pic4, String pic5, String pic6, String pic7, String pic8, String pic9, String pic10, String title, String area, String price,String starting, String guest, String contact, bool wifi, bool ac, bool gym, bool pool, bool bar, bool tv, bool parking,bool dj,bool light,bool drones, String rating, String date) async{
    return await farmCollection.document(title).setData({
      'Category' : category,
      'Pic1' : pic1,
      'Pic2' : pic2,
      'Pic3' : pic3,
      'Pic4' : pic4,
      'Pic5' : pic5,
      'Pic6' : pic6,
      'Pic7' : pic7,
      'Pic8' : pic8,
      'Pic9' : pic9,
      'Pic10' : pic10,
      'Title': title,
      'Area' : area,
      'Price' : price,
      'Starting Price':starting,
      'Guest' : guest,
      'Contact' : contact,
      'Wifi' : wifi,
      'AC' : ac,
      'GYM':gym,
      'Pool':pool,
      'Bar':bar,
      'TV': tv,
      'Parking': parking,
      'DJ Music' : dj,
      'Light' : light,
      'Drones' : drones,
      'Rating': rating,
      'Date' : date,
    });
  }
  Future updateFarmPicData(String category, String pic, String title,String picCount) async{
    return await farmCollection.document(title).collection('Pics').document(picCount).setData({
      'Category' : category,
      'Pic Count' : picCount,
      'Pic' : pic,
      'Title': title,
    });
  }

  Future updateQueryData(String selectedDate, String guests, String time, String number, String date, String email, String name, String farm,String pic) async{
    return  queryCollection.document('$date-$number').setData({
      'Selected Date' : selectedDate,
      'Guests':guests,
      'Name':name,
      'Time':time,
      'Number':number,
      'FarmHouse': farm,
      'Email': email,
      'Date' : date,
      'Pic' : pic
    });
  }

  sendEmail(String sendEmailTo, String subject, String date, String guests, String time,String contact,String username,String email)async{
    await mailCollection.add(
      {
        'to':"$sendEmailTo",
        'message': {
          'subject': "DoneKardo booking for $subject",
          'text': "Dear Admin,\n\nYou received a booking for $subject.\n\nNo. of Guests: $guests\nDate: $date,\nTime: $time\nUser Name: $username\nUser Contact: $contact\nUser Email: $email",
        }
      }
    ).then(
        (value){
          print('Queued email');
        },
    );
    print('Email Done');
  }


  //del user doucment
  Future delFarmDocument(String category, String title) async{
    return await farmCollection.document(title).delete();
  }


  List<Farm> _farmListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Farm(
        category: doc.data['Category'] ?? '',
        pic1: doc.data['Pic1'] ?? null,
        pic2: doc.data['Pic2'] ?? null,
        pic3: doc.data['Pic3'] ?? null,
        pic4: doc.data['Pic4'] ?? null,
        pic5: doc.data['Pic5'] ?? null,
        pic6: doc.data['Pic6'] ?? null,
        pic7: doc.data['Pic7'] ?? null,
        pic8: doc.data['Pic8'] ?? null,
        pic9: doc.data['Pic9'] ?? null,
        pic10: doc.data['Pic10'] ?? null,
        title: doc.data['Title'] ?? '',
        area: doc.data['Area'] ?? '',
        price: doc.data['Price'] ?? '',
        starting: doc.data['Starting Price'] ?? '',
        guest: doc.data['Guest'] ?? '',
        contact: doc.data['Contact'] ?? '',
        wifi: doc.data['Wifi'] ?? false,
        ac: doc.data['AC'] ?? false,
        gym: doc.data['GYM'] ?? false,
        bar: doc.data['Bar'] ?? false,
        pool: doc.data['Pool'] ?? false,
        tv: doc.data['TV'] ?? false,
        parking: doc.data['Parking'] ?? false,
        dj: doc.data['DJ Music'] ?? false,
        light: doc.data['Light'] ?? false,
        drones: doc.data['Drones'] ?? false,
        rating: doc.data['Rating'] ?? '',
        date: doc.data['Date'] ?? '',
      );
    }).toList();
  }
  List<FarmPics> _farmPicsListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return FarmPics(
        category: doc.data['Category'] ?? '',
        pic: doc.data['Pic'] ?? '',
        title: doc.data['Title'] ?? '',
        picCount: doc.data['Pic Count'] ?? '',
      );
    }).toList();
  }
  List<QueryData> _queryListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return QueryData(
        selectedDate: doc.data['Selected Date'] ?? '',
        guests: doc.data['Guests'] ?? null,
        time: doc.data['Time'] ?? '',
        number: doc.data['Number'] ?? null,
        date: doc.data['Date'] ?? '',
        farmName: doc.data['FarmHouse'] ?? '',
        username: doc.data['Name'] ?? '',
        email: doc.data['Email'] ?? '',
        pic: doc.data['Pic'] ?? 'https://img.icons8.com/cotton/2x/farm.png'
      );
    }).toList();
  }
  User _usersDataFromSnapshot(DocumentSnapshot snapshot){
    return User(
      photo: snapshot.data['Pic'] ?? '',
      email: snapshot.data['Email'] ?? '',
      username: snapshot.data['Username'] ?? '',
    );
  }


  //get Vegitem Stream
  Stream<List<Farm>> get farmData {
    return farmCollection.snapshots()
        .map(_farmListFromSnapshot);
  }
  Stream<List<FarmPics>> get farmPicsData {
    return farmCollection.document(title).collection('Pics').snapshots()
        .map(_farmPicsListFromSnapshot);
  }

  Stream<List<QueryData>> get queryData {
    return queryCollection.orderBy('Date',descending: false).snapshots()
        .map(_queryListFromSnapshot);
  }

  Stream<User> get usersData {
    return usersCollection.document(email).snapshots()
        .map(_usersDataFromSnapshot);
  }

}

class Farm{
  final String category;
  final String pic1;
  final String pic2;
  final String pic3;
  final String pic4;
  final String pic5;
  final String pic6;
  final String pic7;
  final String pic8;
  final String pic9;
  final String pic10;
  final String title;
  final String area;
  final String price;
  final String starting;
  final String guest;
  final String contact;
  final bool wifi;
  final bool ac;
  final bool gym;
  final bool pool;
  final bool bar;
  final bool tv;
  final bool parking;
  final bool dj;
  final bool light;
  final bool drones;
  final String rating;
  final String date;

  Farm({this.category, this.pic1, this.pic2, this.pic3, this.pic4, this.pic5, this.pic6, this.pic7, this.pic8, this.pic9, this.pic10, this.title, this.area, this.price, this.starting, this.guest, this.contact, this.wifi, this.ac, this.gym, this.pool, this.bar, this.tv, this.parking, this.dj, this.light, this.drones, this.rating, this.date});

}

class QueryData{

  final String selectedDate;
  final String guests;
  final String time;
  final String number;
  final String date;
  final String farmName;
  final String username;
  final String email;
  final String pic;

  QueryData({this.selectedDate, this.guests, this.time, this.number, this.date, this.farmName, this.username, this.email,this.pic});

}
class FarmPics{
  final String category;
  final String pic;
  final String title;
  final String picCount;

  FarmPics({this.category, this.pic, this.title, this.picCount});


}