import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Id extends ChangeNotifier {
  String id = '';
  String refreshToken = '';
  String contactId = '';
  String lastId = '';

  List<dynamic> leadResult = [];
  void transferId(String newId) {
    id = newId;
    notifyListeners();
  }

  void transferId1(String newRefreshToken) {
    refreshToken = newRefreshToken;

    notifyListeners();
  }

  void transferId2(String newContactId) {
    contactId = newContactId;

    notifyListeners();
  }

  void transferId3(List newLeadResult) {
    leadResult = newLeadResult;

    notifyListeners();
  }

  void transferId4(String newLastId) {
    lastId = newLastId;

    notifyListeners();
  }
}
