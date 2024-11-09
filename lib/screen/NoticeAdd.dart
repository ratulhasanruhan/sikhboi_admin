import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NoticeAdd extends StatefulWidget {
  const NoticeAdd({super.key});

  @override
  State<NoticeAdd> createState() => _NoticeAddState();
}

class _NoticeAddState extends State<NoticeAdd> {
  final _key = GlobalKey<FormState>();

  TextEditingController headingController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Notice'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _key,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: headingController,
                  decoration: const InputDecoration(
                    labelText: 'Headline',
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Please enter headline';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: detailsController,
                  minLines: 3,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Details',
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Please enter details';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: linkController,
                  decoration: const InputDecoration(
                    labelText: 'Link',
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 10,),
                TextFormField(
                  controller: imageController,
                  decoration: const InputDecoration(
                    labelText: 'Image',
                    border: OutlineInputBorder(),
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 16,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  onPressed: (){
                    if(_key.currentState!.validate()){
                      FirebaseFirestore.instance.collection('notice').add({
                        'heading': headingController.text,
                        'details': detailsController.text,
                        'link': linkController.text ?? '',
                        'image': imageController.text ?? '',
                        'date': Timestamp.now(),
                      }).then((value){
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added')));
                      });
                    }
                  },
                  child: const Text(
                      'ADD',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
