import 'package:firebase_database/firebase_database.dart';

class Userinfo {
  late String _photourl;
  late String _userid;
  late String _contact;
  late String _github;
  late String _linked;
  late String _name;
  late String _skills;

  Userinfo(this._userid, this._contact,this._github,this._linked, this._photourl, this._name, this._skills);
  Userinfo.withId(this._userid, this._contact,this._github,this._linked, this._photourl, this._name, this._skills);

  String get userid => this._userid;
  String get photourl => this._photourl;
  String get name => this._name;
  String get skills => this._skills;
  String get contact => this._contact;
  String get github => this._github;
  String get linked => this._linked;

  set userid(String userid) {
    this._userid = userid;
  }

  set contact(String contact) {
    this._contact = contact;
  }

  set photourl(String photourl) {
    this._photourl = photourl;
  }

  set name(String name) {
    this._name = name;
  }
  set skills(String skills) {
    this._skills = skills;
  }
  set github(String github) {
    this._github = github;
  }
  set linked(String linked) {
    this._linked = linked;
  }


  Userinfo.fromSnapshot(DataSnapshot snapshot) {
    this._userid = snapshot.key!;
    this._contact = snapshot.value['contact'];
    this._photourl = snapshot.value['photourl'];
    this._name = snapshot.value['name'];
    this._skills = snapshot.value['skills'];
    this._github = snapshot.value['github'];
    this._linked= snapshot.value['linked'];
  }

  Map<String, dynamic> toJson() {
    return {
      "userid": _userid,
      "contact": _contact,
      "photourl": _photourl,
      "name": _name,
      "skills":_skills,
      "github": _github,
      "linked":_linked,
    };
  }
}
