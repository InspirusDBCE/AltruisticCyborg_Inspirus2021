import 'package:firebase_database/firebase_database.dart';
class Message {
  late String _msg;
  late String _suserid;
  late String _ruserid;
  late String _cr;
  late String _date;
 Message(this._msg, this._suserid, this._ruserid, this._date,this._cr);
  Message.withId(this._msg, this._suserid, this._ruserid, this._date,this._cr);

    String get msg => this._msg;
  String get suserid => this._suserid;
  String get ruserid => this._ruserid;
  String get date => this._date;
  String get cr => this._cr;
    set msg(String msg) {
    this._msg = msg;
  }

  set suserid(String suserid) {
    this._suserid = suserid;
  }

  set ruserid(String ruserid) {
    this._ruserid = ruserid;
  }

  set date(String date) {
    this._date = date;
  }
  set cr(String cr){
    this._cr = cr;
  }

    Message.fromSnapshot(DataSnapshot snapshot) {
    this._suserid = snapshot.key!;
    this._ruserid = snapshot.value['ruserid'];
    this._msg = snapshot.value['msg'];
    this._date = snapshot.value['date'];
    this._cr  = snapshot.value['cr'];
  }

  Map<String, dynamic> toJson() {
    return {
      "ruserid": _ruserid,
      "suserid": _suserid,
      "msg": _msg,
      "date": _date,
      "cr": _cr
    };
  }
  
}
