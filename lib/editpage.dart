import 'package:flutter/material.dart';
import 'package:newdatabase/dbhelper.dart';
import 'package:newdatabase/main.dart';
import 'package:sqflite/sqflite.dart';

class editpage extends StatefulWidget {


  String name; String number; int id;
  editpage(this.name, this.number, this.id);


  @override
  _editpageState createState() => _editpageState();
}

class _editpageState extends State<editpage> {
  Database? db;

  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  List<Map> userdata = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    String namee = widget.name;
    String numberr = widget.number;
    name.text = namee;
    number.text = numberr;
    getalldata();
  }

  void getalldata() {
    dbhelper().Forintializedataabase().then((value) {
      db = value;

     setState(() {

     });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit data"),
      ),
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

                String newname = name.text;
                String newnumber = number.text;

                dbhelper().editdata(db!,newnumber,newname,widget.id).then((value) {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return firstpage();
                    },
                  ));
                });
              },
              child: Text(
                "UPDATE",
                style: TextStyle(fontSize: 26, color: Colors.brown),
              )),
        ],
      ),
    );
  }
}
