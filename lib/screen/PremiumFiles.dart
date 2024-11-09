import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../util/constants.dart';

class PremiumFiles extends StatefulWidget {
  const PremiumFiles({super.key});

  @override
  State<PremiumFiles> createState() => _PremiumFilesState();
}

class _PremiumFilesState extends State<PremiumFiles> {

  TextEditingController titleController = TextEditingController();
  TextEditingController urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Premium Files',
          style: TextStyle(
              color: redish,
              fontWeight: FontWeight.w600
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
              context: context,
              builder: (context){
                return AlertDialog(
                  title: Text('Add File'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          hintText: 'Title',
                        ),
                      ),
                      SizedBox(height: 10,),
                      TextField(
                        controller: urlController,
                        decoration: InputDecoration(
                          hintText: 'URL',
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text('No')
                    ),
                    TextButton(
                        onPressed: (){
                          if(titleController.text.isNotEmpty || urlController.text.isNotEmpty){
                            FirebaseFirestore.instance.collection('admin').doc('premium_live').collection('files').add({
                              'title': titleController.text,
                              'url': urlController.text,
                              'time': Timestamp.now(),
                            });
                            Navigator.pop(context);
                            showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.success(
                                message: 'File Added Successfully',
                              ),
                            );
                          }
                          else{
                            showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.error(
                                message: 'Please fill all the fields',
                              ),
                            );
                          }

                        },
                        child: Text(
                            'Yes',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )
                    ),
                  ],
                );
              }
          );
        },
        backgroundColor: redish,
        child: Icon(
            Icons.add,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('admin').doc('premium_live').collection('files').snapshots(),
        builder: (context,AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                padding: EdgeInsets.all(10),
                itemBuilder: (context, index){
                  return Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        title: Text(snapshot.data.docs[index]['title']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(DateFormat('dd-MM-yyyy - hh:mm:a').format(snapshot.data.docs[index]['time'].toDate())),
                            Text(
                                snapshot.data.docs[index]['url'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: (){
                            showDialog(
                                context: context,
                                builder: (context){
                                  return AlertDialog(
                                    title: Text('Delete File'),
                                    content: Text('Are you sure you want to delete this file?'),
                                    actions: [
                                      TextButton(
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                          child: Text('No')
                                      ),
                                      TextButton(
                                          onPressed: (){
                                            FirebaseFirestore.instance.collection('admin').doc('premium_live').collection('files').doc(snapshot.data.docs[index].id).delete();
                                            Navigator.pop(context);
                                          },
                                          child: Text('Yes')
                                      ),
                                    ],
                                  );
                                }
                            );
                          },
                          icon: Icon(Icons.delete, color: redish,),
                        ),
                      ),
                    ),
                  );
                }
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      ),
    );
  }
}
