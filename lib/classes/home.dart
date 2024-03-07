// ignore_for_file: avoid_print, unused_local_variable, use_build_context_synchronously, unnecessary_this

import 'package:flutter/material.dart';
import 'package:sqlflite_crud/classes/dbsql.dart';
import 'package:sqlflite_crud/classes/edit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Dbsql sqldb = Dbsql();
  bool isloading = true;
  List notess = [];
  Future readdata() async {
    List<Map> response = await sqldb.readdata("SELECT * FROM notes");
    notess.addAll(response);
    isloading = false;
    if (this.mounted) {
       setState(() {});
    }
  }

  @override
  void initState() {
    readdata();
    super.initState();
  }

  // String? data;
  // TextEditingController? tnum;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('add');
        },
        child: const Icon(Icons.add),
      ),
      body: isloading
          ? const Center(child: CircularProgressIndicator())
          : ListView(children: [
              ListView.builder(
                itemCount: notess.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.blue[100],
                    child: ListTile(
                      title: Text('${notess[index]["note"]}'),
                      subtitle: Text('${notess[index]["title"]}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () async {
                                // SQL طريقة اكواد الـ

                                // int resdelet = await sqldb.deletedata(
                                // '''
                                // DELETE FROM notes WHERE id = ${notess[index]['id']}
                                // '''
                                // );

                                // طريقة الاكواد الجاهزة

                                int resdelet = await sqldb.delete(
                                    'notes', 'id = ${notess[index]['id']}');

                                ////////////////////////////////////////////////

                                if (resdelet > 0) {
                                  notess.removeWhere((element) =>
                                      element['id'] == notess[index]['id']);
                                  setState(() {});
                                }
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                          IconButton(
                              onPressed: () async {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => Editnots(
                                        id: notess[index]['id'],
                                        note: notess[index]['note'],
                                        title: notess[index]['title'],
                                        color: notess[index]['color']),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blueAccent,
                              )),
                        ],
                      ),
                      isThreeLine: true,
                    ),
                  );
                },
              ),
            ]),
    );
  }
}
