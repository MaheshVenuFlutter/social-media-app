// return a formated date as a string

import 'package:cloud_firestore/cloud_firestore.dart';

String fromateDateTime(Timestamp timestamp) {
// timestamp is the object we get from fire base
// we need to conevrt it into string

  DateTime dateTime = timestamp.toDate();

  // get yera
  String year = dateTime.year.toString();
  // get month
  String month = dateTime.month.toString();
  // get day
  String day = dateTime.day.toString();
  // final formated date is
  String formateddate = day + '/' + month + '/' + year;
  return formateddate;
}
