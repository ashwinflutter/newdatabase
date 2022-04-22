import 'package:flutter/material.dart';
import 'package:newdatabase/dbhelper.dart';
import 'package:newdatabase/main.dart';
import 'package:sqflite/sqflite.dart';

class insertpage extends StatefulWidget {
  const insertpage({Key? key}) : super(key: key);


  @override
  _insertpageState createState() => _insertpageState();
}

class _insertpageState extends State<insertpage> {
  Database? db;
  TextEditingController name=TextEditingController();
  TextEditingController number=TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbhelper().Forintializedataabase().then((value) {
      db=value;
      setState(() {

      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: name,
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
              hintText: "Enter name",
              labelText: "Name",
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: number,
            style: TextStyle(fontSize: 20),
            keyboardType: TextInputType.number,
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Enter number",
              labelText: "Password",
              prefixIcon: Icon(Icons.content_paste),
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FlatButton(
              color: Colors.lightGreen,
              onPressed: () {
        String ename=name.text;
        String enumber=number.text;
        dbhelper().insertdata(db!, ename, enumber).then((value) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return firstpage();
          },));
        });
              },
              child: Text(
                "submit",
                style: TextStyle(fontSize: 26, color: Colors.brown),
              )),
        ],
      ),
    );
  }
}
