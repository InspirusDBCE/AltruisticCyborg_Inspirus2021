Container(padding: EdgeInsets.fromLTRB(40,
10
,
40
,
10
)
,
child: TextFormField
(
validator: (
input) {
if (input!.isEmpty) {
return 'Provide an name';
}
return null;
},
decoration: InputDecoration
(
labelText: '

Full name
'
,
labelStyle: TextStyle
(
color: Colors.black,fontSize: 17
,
fontWeight: FontWeight.w700,)
,
focusedBorder: OutlineInputBorder
(
borderSide:BorderSide
(
color: Colors.black, width: 1.0
)
,
)
,
enabledBorder: OutlineInputBorder
(
borderSide:BorderSide
(
color: Colors.black, width: 1.0
)
,
)
,
)
,
onSaved: (
input) =>
_name = input!,
obscureText: false
,
)
,
)
,
SizedBox
(
height: 10
,
)
,

Container
(
padding: EdgeInsets.fromLTRB(40
,
10
,
40
,
10
)
,
child: TextFormField
(
validator: (
input) {
if (input!.isEmpty) {
return 'Provide an name';
}
return null;
},
decoration: InputDecoration
(
labelText: '
Contact',
labelStyle: TextStyle
(
color: Colors.black,fontSize: 17
,
fontWeight: FontWeight.w700,)
,
focusedBorder: OutlineInputBorder
(
borderSide:BorderSide
(
color: Colors.black, width: 1.0
)
,
)
,
enabledBorder: OutlineInputBorder
(
borderSide:BorderSide
(
color: Colors.black, width: 1.0
)
,
)
,
)
,
onSaved: (
input) =>
_contact = input!,
obscureText: false
,
)
,
)
,
SizedBox
(
height: 10
,
)
,
Container
(
padding: EdgeInsets.fromLTRB(40
,
10
,
40
,
10
)
,
child: TextFormField
(
validator: (
input) {
if (input!.isEmpty) {
return 'Provide an name';
}
return null;
},
decoration: InputDecoration
(
labelText: '
Github',
labelStyle: TextStyle
(
color: Colors.black,fontSize: 17
,
fontWeight: FontWeight.w700,)
,
focusedBorder: OutlineInputBorder
(
borderSide:BorderSide
(
color: Colors.black, width: 1.0
)
,
)
,
enabledBorder: OutlineInputBorder
(
borderSide:BorderSide
(
color: Colors.black, width: 1.0
)
,
)
,
)
,
onSaved: (
input) =>
_github = input!,
obscureText: false
,
)
,
)
,
SizedBox
(
height: 10
,
)
,
Container
(
padding: EdgeInsets.fromLTRB(40
,
10
,
40
,
10
)
,
child: TextFormField
(
validator: (
input) {
if (input!.isEmpty) {
return 'Provide an name';
}
return null;
},
decoration: InputDecoration
(
labelText: '
LinkedIn',
labelStyle: TextStyle
(
color: Colors.black,fontSize: 17
,
fontWeight: FontWeight.w700,)
,
focusedBorder: OutlineInputBorder
(
borderSide:BorderSide
(
color: Colors.black, width: 1.0
)
,
)
,
enabledBorder: OutlineInputBorder
(
borderSide:BorderSide
(
color: Colors.black, width: 1.0
)
,
)
,
)
,
onSaved: (
input) =>
_linked = input!,
obscureText: false
,
)
,
)
,

Container
(
padding: EdgeInsets.only(right: 40.0
,
left: 40.0
)
,
child: MultiSelectFormField
(
border: OutlineInputBorder
(
borderSide: BorderSide
(
color: Colors.black, width: 1.0
)
,
)
,
autovalidate: false
,
chipBackGroundColor: Colors.blue,chipLabelStyle: TextStyle
(
fontWeight: FontWeight.bold, color: Colors.white),
dialogTextStyle: TextStyle
(
fontWeight: FontWeight.bold),
checkBoxActiveColor: Colors.amber,checkBoxCheckColor: Colors
    .white,dialogShapeBorder: RoundedRectangleBorder
(
borderRadius:BorderRadius.all(Radius.circular(12.0
)
)
)
,
title: Text
("Skills
"
,
style: TextStyle
(
fontSize: 17
,
fontWeight: FontWeight.bold),
)
,
validator: (
value) {
if (value == null || value.length == 0) {
return 'Please select one or more options';
}
return null;
},
dataSource: [
{
"display": "AI",
"value": "AI",
},
{
"display": "IOT",
"value": "IOT",
},
{
"display": "Web Development",
"value": "Web Development",
},
{
"display": "Mobile app development",
"value": "Mobile app development",
},
]
,
textField: '
display',
valueField: '
value',
okButtonLabel: '
OK',
cancelButtonLabel: '
CANCEL',
hintWidget: Text
('Please choose one or more
'
)
,
initialValue: _myActivities,onSaved: (
value) {
if (value == null) return;
setState(() {
_myActivities = value;
});
},
)
,
)
,
// Container(
//   padding: EdgeInsets.all(8),
//   child: ElevatedButton(
//     child: Text('Save'),
//     onPressed: _saveForm,
//   ),
// ),
//
SizedBox
(
height: 10
,
)
,

Container
(
padding: EdgeInsets.fromLTRB(40
,
10
,
40
,
30
)
,
child: TextFormField
(
validator: (
input) {
if (input!.isEmpty) {
return 'Provide an Password';
}
return null;
},
decoration: InputDecoration
(
labelText: '
Password',
labelStyle: TextStyle
(
color: Colors.black,fontSize: 17
,
fontWeight: FontWeight.w700,)
,
focusedBorder: OutlineInputBorder
(
borderSide:BorderSide
(
color: Colors.black, width: 1.0
)
,
)
,
enabledBorder: OutlineInputBorder
(
borderSide:BorderSide
(
color: Colors.black, width: 1.0
)
,
)
,
)
,
onSaved: (
input) =>
_password = input!,
obscureText: true,
),
),
],
),
)
,
SizedBox
(
height: 10
)
,
ElevatedButton
(
onPressed: () {
// _saveForm();
signup();
},
child: Text
('SIGN UP
'
,
style: TextStyle
(
fontSize: 20
,
fontWeight: FontWeight.w800,)
,
)
,
style: ButtonStyle
(
backgroundColor:MaterialStateProperty.all<Color>(Colors.red.shade400),
padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets
    .fromLTRB(70, 10, 70, 10),
),
)
,
)
,
SizedBox
(
height: 20
,
)
,
ElevatedButton
(
onPressed: () {
Navigator.push(
context,
PageTransition(
type: PageTransitionType.bottomToTop, child: rlogin()));
},
child: Text
('SIGN IN
'
,
style: TextStyle
(
fontSize: 20
,
fontWeight: FontWeight.w800,color: Colors.red.shade300,)
,
)
,
style: ButtonStyle
(
backgroundColor:MaterialStateProperty.all<Color>(Colors.white),
padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets
    .fromLTRB(70, 10, 70, 10),
),
shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder
(
side: BorderSide
(
color: Colors.red.shade300,width: 2
,
)
)
)
)
,
)
,