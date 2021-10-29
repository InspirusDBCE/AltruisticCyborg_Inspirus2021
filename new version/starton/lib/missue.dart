import 'package:firebase_database/firebase_database.dart';

class Missue {
  late String _uid;
  late String _issue;
  late String _skills;
  Missue(this._uid, this._issue, this._skills);
  Missue.withId(this._uid, this._issue, this._skills);

  String get uid => this._uid;
  String get issue => this._issue;
  String get skills => this._skills;
  set issue(String issue) {
    this._issue = issue;
  }

  set uid(String uid) {
    this._uid = uid;
  }

  set skills(String skills) {
    this._skills = skills;
  }

  Missue.fromSnapshot(DataSnapshot snapshot) {
    this._uid = snapshot.key!;
    this._uid = snapshot.value['uid'];
    this._issue = snapshot.value['issue'];
    this._skills = snapshot.value['skills'];
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": _uid,
      "issue": _issue,
      "skills": _skills,
    };
  }
}
