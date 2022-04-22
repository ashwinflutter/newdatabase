  import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class dbhelper{

  Future<Database> Forintializedataabase() async {
     // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
     String path = join(databasesPath, 'demo.db');



    Database database = await openDatabase(path, version: 1,
         onCreate: (Database db, int version) async {
       // When creating the db, create the table
       await db.execute(
           'create table Contactbook (id integer primary key autoincrement , name Text , number Text)');
     });
     return database;
   }
   
   Future<void>insertdata(Database database,String ename,String enumber)async {
    String insert="insert into  Contactbook(name,number) values ('$ename','$enumber')";
    int cnt=await database.rawInsert(insert);
    print(cnt);
    
   }
    Future<List<Map>>viewdata(Database database)async{
    String select="select * from Contactbook";
    List<Map> list=await database.rawQuery(select);
    print(list);
    return list;
    }

  Future<void>editdata(Database database, String newnumber, String newname, int id) async {
    String update="UPDATE Contactbook SET name='$newname', number='$newnumber' WHERE id='$id'";
    int cnnt=await database.rawUpdate(update);
    print(cnnt);

  }
// Future<void>deletedata(Database database,String ename,int id)async{
//     String delete="DELETE FROM Contactbook WHERE name='$ename',['id']";
//     int cnnt=await database.delete(delete);
//     print(cnnt);
// }

}