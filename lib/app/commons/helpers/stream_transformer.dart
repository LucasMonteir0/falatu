import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class Teste {
  static StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<T>>
      transformer<T>(T Function(Map<String, dynamic> json) fromJson) =>
          StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
              List<T>>.fromHandlers(
            handleData: (QuerySnapshot<Map<String, dynamic>> data,
                EventSink<List<T>> sink) {
              final snaps = data.docs.map((doc) => doc.data()).toList();
              final dataModel = snaps.map((json) => fromJson(json)).toList();
              sink.add(dataModel);
            },
          );
}
