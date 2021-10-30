import 'package:firebase_database/firebase_database.dart';

class Chatlist {
  late String _uid;
  late String _rid;

  Chatlist(this._uid, this._rid);
  Chatlist.withId(this._uid, this._rid);

  String get userid => this._uid;
  String get name => this._rid;


  setuserid(userid) => this._uid = userid;
  setname(rid) => this._rid = rid;

  Chatlist.fromSnapshot(DataSnapshot snapshot) {
    this._uid = snapshot.key!;
    this._rid = snapshot.value['rid'];
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": _uid,
      "ruid":_rid
    };
  }
}
