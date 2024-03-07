// ignore_for_file: avoid_unnecessary_containers, use_build_context_synchronously, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:sqlflite_crud/classes/dbsql.dart';
import 'package:sqlflite_crud/classes/home.dart';

class Addnote extends StatefulWidget {
  const Addnote({super.key});

  @override
  State<Addnote> createState() => _AddnoteState();
}

class _AddnoteState extends State<Addnote> {
  GlobalKey<FormState> myform = GlobalKey();
  TextEditingController cnote = TextEditingController();
  TextEditingController ctitle = TextEditingController();
  TextEditingController ccolor = TextEditingController();
  Dbsql dbsql = Dbsql();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
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
                      ////////////////////////////////////////////
                      
                      // SQL طريقة اكواد الـ

                      // int res = await dbsql.insertdata(
                      // '''
                      // INSERT INTO notes(`note`,`title`,`color`)
                      // VALUES ("${cnote.text}","${ctitle.text}","${ccolor.text}")
                      // '''
                      // );

                      //طريقة الاكواد الجاهزة

                      int res = await dbsql.insert(
                        'notes',
                        {
                          'note': '${cnote.text}',
                          'title': '${ctitle.text}',
                          'color': '${ccolor.text}'
                        },
                      );

                      ///////////////////////////////////////////

                      if (res > 0) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const Home(),
                            ),
                            (route) => false);
                      }
                    },
                    child: const Text('Add Note'),
                  ),
                ],
              ))),
    );
  }
}
