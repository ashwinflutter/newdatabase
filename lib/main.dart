import 'package:flutter/material.dart';
import 'package:newdatabase/dbhelper.dart';
import 'package:newdatabase/editpage.dart';
import 'package:newdatabase/insertpage.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MaterialApp(
    home: firstpage(),
  ));
}

class firstpage extends StatefulWidget {
  const firstpage({Key? key}) : super(key: key);

  @override
  _firstpageState createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {
  Database? db;
  List<Map> userdta = [];
  List<Map> searchlist = [];


  bool status = false;
  bool search = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAlldata();
  }

  void getAlldata() {
    dbhelper().Forintializedataabase().then((value) {
      db = value;
      setState(() {});
      dbhelper().viewdata(db!).then((listofmap) {
        userdta = listofmap;
        searchlist = listofmap;

        setState(() {
          status = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: status
          ? ListView.builder(
              itemCount: search ? searchlist.length : userdta.length,
              itemBuilder: (context, index) {
                Map mm = search ? searchlist[index] : userdta[index];
                return ListTile(onTap: (){

                  String name = "${mm['name']}";
                  String number = "${mm['number']}";
                  int id = mm['id'];
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return   AlertDialog(
                        title: Text("Do You Want To EDIT or DELETE"),actions: [FlatButton(onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                          return editpage(name, number, id);
                        },));

                      }, child:Text("EDIT") ),
                        FlatButton(onPressed: () {
                          Navigator.pop(context);



                        }, child: Text("DELETE"))
                      ],
                      );
                    },
                  ));

                },
                  subtitle: Text("${mm['number']}"),
                  textColor: Colors.brown,
                  title: Text("${mm['name']}"),
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_box),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return insertpage();
            },
          ));
        },
          ),
      appBar: search
          ? AppBar(
              title: TextField(
                autofocus: true,
                onChanged: (value) {
                  setState(() {
                    if (value != "")  {
                      searchlist = [];
                      for (int i = 0; i < userdta.length; i++) {
                        String name = "${userdta[i]['name']}";
                        if (name
                            .toLowerCase()
                            .toString()
                            .contains(value.toLowerCase().toString())) {
                          // searchlist = userdta[i]['name'];
                          searchlist.add(userdta[i]);
                          print(searchlist);
                        }
                      }
                    } else {
                      searchlist = userdta;
                      setState(() {});
                    }
                  });
                },
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        search = false;
                      });
                    },
                    icon: Icon(Icons.close))
              ],
            )
          : AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        search = true;
                      });
                    },
                    icon: Icon(Icons.search))
              ],
              title: Text("Contactbook"),
            ),
    );
  }
}
