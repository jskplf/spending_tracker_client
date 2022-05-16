import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// The receipt Model
/// It can be serialized to and from JSON
/// It extends value notifier, therefore all of its fields emit onChanged events
/// all setters have a call to notifyListeners() which lets any widget that is
/// using a valueListenableBuilder to watch the values of that there are changes
/// that need to be updated
/// Note that the rawText field does not have a setter
class ReceiptModel extends ChangeNotifier {
  dynamic store;

  dynamic address;

  dynamic date;

  dynamic total;

  dynamic category;

  dynamic rawText;

  ReceiptModel.empty();

  ReceiptModel(
      {this.store,
      this.address,
      this.date,
      this.total,
      this.category,
      this.rawText});

  ReceiptModel.fromJson(Map<String, dynamic> json)
      : store = json['store'],
        address = json['address'],
        date = json['date'],
        total = json['total'],
        category = json['category'],
        rawText = json['raw_text'];

  Map<String, dynamic> toJson() => {
        'store': store,
        'address': address,
        'date': date,
        'total': total,
        'category': category,
        'rawText': rawText,
      };

  void setStore(String newName) {
    /// Let all listeners know that the value of name has changed for this receipt
    store = newName;
    notifyListeners();
  }

  void setAddress(String newAddress) {
    address = newAddress;
    notifyListeners();
  }

  void setDate(dynamic newDate) {
    newDate = newDate;
    notifyListeners();
  }

  void setTotal(dynamic newTotal) {
    total = newTotal;
    notifyListeners();
  }

  void setCategory(dynamic newCategory) {
    category = newCategory;
    notifyListeners();
  }
}
