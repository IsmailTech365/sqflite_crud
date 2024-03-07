// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_typing_uninitialized_variables, unused_local_variable, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:sqlflite_crud/classes/dbsql.dart';
import 'package:sqlflite_crud/classes/home.dart';

class Editnots extends StatefulWidget {
  final note;
  final title;
  final color;
  final id;
  const Editnots({super.key, this.note, this.title, this.color, this.id});

  @override
  State<Editnots> createState() => _EditnotsState();
}

class _EditnotsState extends State<Editnots> {
  GlobalKey<FormState> myform = GlobalKey();
  TextEditingController cnote = TextEditingController();
  TextEditingController ctitle = TextEditingController();
  TextEditingController ccolor = TextEditingController();
  Dbsql dbsql = Dbsql();
  @override
  void initState() {
    cnote.text = widget.note;
    ctitle.text = widget.title;
    ccolor.text = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ُEdit Note'),
      ),
      body: Container(
          padding: const EdgeInsets.all(8),
          child: Form(
              key: myform,
              child: Column(
                children: [
                  TextField(
                    controller: cnote,
                    decoration: const InputDecoration(labelText: "Note"),
                  ),
                  TextField(
                    controller: ctitle,
                    decoration: const InputDecoration(labelText: "Title"),
                  ),
                  TextField(
                    controller: ccolor,
                    decoration: const InputDecoration(labelText: "Color"),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      // SQL طريقة اكواد الـ 
                      
                      // int res = await dbsql.updatedata('''
                      // UPDATE 'notes' SET 
                      // 'note' = '${cnote.text}',
                      // 'title' = '${ctitle.text}',
                      // 'color' = '${ccolor.text}' 
                      //  WHERE id = ${widget.id} 
                      // ''');

                      // طرقة الاكواد الجاهزة
                      int res= await dbsql.update(
                          'notes',
                          {
                            'note': '${cnote.text}',
                            'title': '${ctitle.text}',
                            'color': '${ccolor.text}'
                          },
                          'id = ${widget.id}');
                      //////////////////////////////////////
                      if (res > 0) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const Home(),
                            ),
                            (route) => false);
                      }
                    },
                    child: const Text('Edit Note'),
                  ),
                ],
              ))),
    );
  }
}

       // ElevatedButton(
            //     onPressed: () async {
            //       await sqldb.mydeletedatabase();
            //     },
            //     child: const Text('Delete DataBase')),
            // TextFormField(
            //   controller: tnum,
            // ),
            // Text(data == null ? '' : data!),
            // ElevatedButton(
            //     onPressed: () async {
            //       int respones = await sqldb.insertdata(
            //           "INSERT INTO 'notes' ('note','title','color') VALUES ('note one','Ali','Red_Green') ");
            //       print(respones);
            //     },
            //     child: const Text('Insert Data')),
            // ElevatedButton(
            //     onPressed: () async {
            //       List<Map> response =
            //           await sqldb.readdata("SELECT * FROM 'notes' ");
            //       print('$response');
            //       setState(() {
            //         data = response.toString();
            //       });
            //     },
            //     child: const Text('Read Data')),
            // ElevatedButton(
            //     onPressed: () async {
            //       int response = await sqldb.updatedata(
            //           "UPDATE 'notes' SET 'note'= 'note sex' WHERE id = 2 ");
            //       print(response);
            //     },
            //     child: const Text('Update Data')),
            // ElevatedButton(
            //     onPressed: () async {
            //       int response = await sqldb
            //           .deletedata("DELETE FROM  'notes'  WHERE id = 7");
            //       print(response);
            //     },
            //     child: const Text('Delete Data')),