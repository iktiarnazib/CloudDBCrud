import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudcrud/services/firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textController = TextEditingController();

  TextEditingController textController2 = TextEditingController();

  void floatingActionPressed() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: TextFormField(controller: textController),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (mounted) {
                  Navigator.pop(context);
                }
                textController.clear();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                FirestoreService().addNotes(textController.text);
                textController.clear();
                if (mounted) {
                  Navigator.pop(context);
                }
              },
              child: Text('save'),
            ),
          ],
        );
      },
    );
  }

  onSettingsPressed(String? id, String oldText) {
    textController2.text = oldText;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: TextFormField(controller: textController2),
          actions: [
            //cancel button
            ElevatedButton(
              onPressed: () {
                //close the window
                if (mounted) {
                  Navigator.pop(context);
                }
              },
              child: Text('Cancel'),
            ),
            //save button
            ElevatedButton(
              onPressed: () {
                if (id == null) {
                  FirestoreService().addNotes(textController.text);
                } else {
                  FirestoreService().updateNote(id, textController2.text);
                }

                Navigator.pop(context);
                setState(() {});
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  //on delete button pressed
  onDeletePressed(String? id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Do you want to delete this note?'),
          actions: [
            MaterialButton(
              onPressed: () {
                if (mounted) {
                  Navigator.pop(context);
                }
              },
              child: Text('Cancel'),
            ),
            MaterialButton(
              onPressed: () {
                if (id == null) {
                  FirestoreService().addNotes(textController.text);
                } else {
                  //delete note
                  FirestoreService().deleteNote(id);
                  //poping alert dialogue
                  Navigator.pop(context);
                }
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CloudDB'),
        backgroundColor: Colors.grey.shade300,
      ),
      backgroundColor: Colors.grey[300],
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: FloatingActionButton(
          onPressed: () => floatingActionPressed(),
          child: Icon(Icons.add),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirestoreService().getNoteStream(),
        builder: (context, snapshot) {
          //if we have data, get all the docs
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;

            //display as a list
            return ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (BuildContext context, int index) {
                //get each individual docs
                DocumentSnapshot document = notesList[index];
                String docID = document.id;

                //get note for each note
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;

                String noteText = data['note'];

                //display as a list tile
                return Container(
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  child: ListTile(
                    title: Text(noteText),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () =>
                              onSettingsPressed(docID, textController.text),
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            return onDeletePressed(docID);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No Notes'));
          }
        },
      ),
    );
  }
}
