import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudcrud/services/firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController addNoteController = TextEditingController();

  // //open a dialog box to open a note
  // openNoteBox() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text('Add a note'),
  //         content: Padding(
  //           padding: const EdgeInsets.symmetric(horizontal: 15.0),
  //           child: TextFormField(controller: addNoteController),
  //         ),
  //         actions: [
  //           //cancel button
  //           MaterialButton(
  //             onPressed: () {
  //               //close the alertdialog
  //               Navigator.pop(context);
  //             },
  //             child: Text('Cancel;'),
  //           ),
  //           //save button
  //           MaterialButton(
  //             onPressed: () {
  //               //firestore note adding
  //               FirestoreService().addNote(addNoteController.text);
  //               //clear the note controller
  //               addNoteController.clear();
  //               //close the box
  //               if (mounted) {
  //                 Navigator.pop(context);
  //               }
  //             },
  //             child: Text('Save'),
  //           ),
  //         ],
  //         //cancel button
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CloudDB'),
        backgroundColor: Colors.grey.shade300,
      ),
      backgroundColor: Colors.grey[300],
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)),
      ),
    );
  }
}
