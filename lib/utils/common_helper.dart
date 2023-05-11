

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constants/assets_path.dart';
import '../constants/string_constants.dart';
import 'dialogUtils.dart';



class CommonHelper{

   static Future<File?> compress({required File? image, int quality = 80,int width = 800 ,int height =420}) async {
      //It returns an ImageProperties object containing the width and the height of the image.
      //ImageProperties properties = await FlutterNativeImage.getImageProperties(file.path);
      var path = await FlutterNativeImage.compressImage(image?.absolute.path ?? '', quality: quality ,targetWidth: width, targetHeight: height);
      return path;
   }
   static void dismissKeyBoard() {
      // for dismiss keyboard
      FocusManager.instance.primaryFocus?.unfocus();
   }

   static Future<bool> checkInternetConnection() async {
      try {
         final result = await InternetAddress.lookup("google.com");
         if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
           // print("-----------connect Internet---------");
            return true;
         } else {
           // print("------------not connect Internet-------");
            return false;
         }
      } on SocketException catch (_) {
         print("not connect");
         return false;
      }
   }

   static void showNoInternetDialog(BuildContext context){
      DialogUtils().showAdvancedDialog(context,
          description:txt_notInternet,
          iconPath: AssetsPath.icon_warning,
          onTabCancel: (){
             Navigator.of(context).pop();
          });
   }

   static void showErrorDialog(BuildContext context ,String? msg){
      Navigator.of(context).pop();
      DialogUtils().showAdvancedDialog(context,
          description: msg?? 'جدث خطأ',
          iconPath: AssetsPath.icon_error,
          onTabCancel: (){
             Navigator.of(context).pop();
          });
   }


   static Future<String> getDateFormatted(BuildContext context ) async {
      DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1990),
          lastDate: DateTime(2100));

      if (pickedDate != null) {
         String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
         print(formattedDate); //formatted date output using intl package =>  2021-03-16
        return formattedDate;
      } else {
         return '';
      }
   }

   static Future<bool> checkCameraAndGalleryPermission(BuildContext context) async {
      FocusScope.of(context).requestFocus(FocusNode());
      Map<Permission, PermissionStatus> statues = await [
         Permission.camera,
         Permission.storage,
      ].request();
      PermissionStatus? statusCamera = statues[Permission.camera];
      PermissionStatus? statusStorage = statues[Permission.storage];
      bool isGranted = statusCamera == PermissionStatus.granted &&
          statusStorage == PermissionStatus.granted ;
      if (isGranted) {
         return true;
      }
      bool isPermanentlyDenied =
          statusCamera == PermissionStatus.permanentlyDenied ||
              statusStorage == PermissionStatus.permanentlyDenied ;
      if (isPermanentlyDenied) {
         openAppSettings();
         return false;
      }

      return false;
   }

}
