import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EnglishChat extends StatefulWidget {
  const EnglishChat({super.key});

  @override
  State<EnglishChat> createState() => _EnglishChatState();
}

class _EnglishChatState extends State<EnglishChat> {

  String question = '';
  String ansewer = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('English Chat'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
            context: context,
            builder: (context){
              return AlertDialog(
                title: const Text('Add'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Question:'),
                    TextFormField(
                      onChanged: (value){
                        setState(() {
                          question = value;
                        });
                      },
                    ),
                    const SizedBox(height: 10,),
                    Text('Ansewer:'),
                    TextFormField(
                      onChanged: (value){
                        setState(() {
                          ansewer = value;
                        });
                      },
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                      question = '';
                      ansewer = '';
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: (){
                      if(question.isNotEmpty && ansewer.isNotEmpty){
                        FirebaseFirestore.instance.collection('english').add({
                          'q': question,
                          'a': ansewer,
                        }).then((value){
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added')));
                        });
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
                      }

                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            }
          );
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('english').snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if(snapshot.hasData){
            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index){
                return Card(
                  child: ListTile(
                    title: Text('Q: ' + snapshot.data.docs[index]['q']),
                    subtitle: Text('A: '+snapshot.data.docs[index]['a']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: (){
                            showDialog(
                              context: context,
                              builder: (context){
                                return AlertDialog(
                                  title: const Text('Edit'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('Question:'),
                                      TextFormField(
                                        initialValue: snapshot.data.docs[index]['q'],
                                        onChanged: (value){
                                          FirebaseFirestore.instance.collection('english').doc(snapshot.data.docs[index].id).update({
                                            'q': value,
                                          });
                                        },
                                      ),
                                      const SizedBox(height: 10,),
                                      Text('Ansewer:'),
                                      TextFormField(
                                        initialValue: snapshot.data.docs[index]['a'],
                                        onChanged: (value){
                                          FirebaseFirestore.instance.collection('english').doc(snapshot.data.docs[index].id).update({
                                            'a': value,
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: (){
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Update'),
                                    ),
                                  ],
                                );
                              }
                            );
                            },
                            child: Icon(Icons.edit)
                        ),
                        const SizedBox(width: 10,),
                        InkWell(
                          onTap: (){
                            FirebaseFirestore.instance.collection('english').doc(snapshot.data.docs[index].id).delete()
                                .then((value) => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Deleted'))));
                          },
                          child: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
