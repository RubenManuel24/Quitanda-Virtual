import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UtilServices {
   
   final storage = const FlutterSecureStorage();


  // Salva dado localmente em segurança
  Future<void> salveLocalData({required String key, required String data})async{

    await storage.write(key: key, value: data);
    
  }

  // Recupera dado salva localmente em segurança
  Future<String?> getLocalData({required String key})async{

    return await storage.read(key: key);

  }


  // Remove dado salvo localmente
  Future<void> removeLocalData({required String key})async{

    await storage.delete(key: key);

  }
  
  //KZ valor
  String priceToCurrency(double value){
    NumberFormat format = NumberFormat.simpleCurrency(name: 'Kz ');
    return format.format(value);
  }

  //Formatacao de data
  String formatDateTime( DateTime dateTime){
    initializeDateFormatting();

        DateFormat dateFormat = DateFormat.yMd("pt_PT").add_Hm();
        return  dateFormat.format(dateTime.toLocal());
  }


  void showToast({required String text, bool isError = false}){

     Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: isError ? Colors.red : Colors.white,
        textColor: isError ? Colors.white :  Colors.black,
        fontSize: 16.0,
        webBgColor: isError ? "red" : "white",
        webPosition: "center",
    );

  }

  Uint8List decodeQrCodeImage(String value){
    String base64String = value.split(",").last;
    return base64.decode(base64String);

  }

}



