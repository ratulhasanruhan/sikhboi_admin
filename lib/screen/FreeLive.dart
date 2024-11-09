import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sikhboi_admin/util/constants.dart';

class FreeLive extends StatefulWidget {
  const FreeLive({super.key});

  @override
  State<FreeLive> createState() => _FreeLiveState();
}

class _FreeLiveState extends State<FreeLive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Free Live'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(12.r),
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('admin').doc('live').snapshots(),
            builder: (context,AsyncSnapshot snapshot) {
              if(snapshot.hasData){
                return Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: lowRed,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: redish.withOpacity(0.3),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'পরের ক্লাসের সময়সূচি সেট করুন:',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(DateTime.now().year + 1)
                                  ).then((value) {
                                    if(value != null){
                                      FirebaseFirestore.instance.collection('admin').doc('live').update({
                                        'time': Timestamp.fromDate(
                                            DateTime(
                                                value.year,
                                                value.month,
                                                value.day,
                                                snapshot.data['time'].toDate().hour,
                                                snapshot.data['time'].toDate().minute
                                            ))
                                      });
                                    }
                                  });
                                },
                                icon: Icon(
                                  Icons.edit_calendar_outlined,
                                  color: redish,
                                )
                            ),
                            Text(
                              DateFormat('dd/MMM/yyyy -- hh:mm:a').format(snapshot.data['time'].toDate()),
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            ),
                            IconButton(
                                onPressed: () {
                                  showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now()
                                  ).then((value) {
                                    if(value != null){
                                      FirebaseFirestore.instance.collection('admin').doc('live').update({
                                        'time': Timestamp.fromDate(
                                            DateTime(
                                                DateTime.now().year,
                                                DateTime.now().month,
                                                DateTime.now().day,
                                                value.hour,
                                                value.minute
                                            ))
                                      });
                                    }
                                  });
                                },
                                icon: Icon(
                                  Icons.more_time_rounded,
                                  color: redish,
                                )
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'মিটিং আইডি : ${snapshot.data['meeting_id']}',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Edit Meeting ID'),
                                          content: TextField(
                                            controller: TextEditingController(text: snapshot.data['meeting_id']),
                                            onChanged: (value) {
                                              FirebaseFirestore.instance.collection('admin').doc('live').update({
                                                'meeting_id': value
                                              });
                                            },
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Cancel')
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Save')
                                            )
                                          ],
                                        );
                                      }
                                  );
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: redish,
                                )
                            )
                          ],
                        ),
                        Divider(),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Edit Class Title'),
                                    content: TextField(
                                      controller: TextEditingController(text: snapshot.data['free_promo']),
                                      onChanged: (value) {
                                        FirebaseFirestore.instance.collection('admin').doc('live').update({
                                          'free_promo': value
                                        });
                                      },
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Cancel')
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Save')
                                      )
                                    ],
                                  );
                                }
                            );
                          },
                          child: Text(
                            'Promo Video: ${snapshot.data['free_promo']}  📝' ,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    )
                );
              }
              return Container();
            }
          ),
          const SizedBox(height: 10,),
          Text(
            'ফ্রি লাইভ অংশগ্রহণকারী:',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8,),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('free_live').snapshots(),
            builder: (context,AsyncSnapshot snapshot) {
              if(snapshot.hasData){
                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      primary: false,
                      itemBuilder: (context, index){
                        return Card(
                          child: ListTile(
                            title: Text(snapshot.data.docs[index]['name']),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text( 'E-mail: ' +snapshot.data.docs[index]['email']),
                                Text( 'Phone: ' +snapshot.data.docs[index]['phone']),
                              ],
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text('Remove User'),
                                          content: Text('Are you sure you want to remove this user?'),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Cancel')
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  FirebaseFirestore.instance.collection('free_live').doc(snapshot.data.docs[index].id).delete();
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Remove')
                                            )
                                          ],
                                        );
                                      }
                                  );
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.grey,
                                )
                            ),
                          ),
                        );
                      }
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          )
        ],
      ),
    );
  }
}
