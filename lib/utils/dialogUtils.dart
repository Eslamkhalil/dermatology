import 'package:flutter/material.dart';

import '../widgets/customButton.dart';



class DialogUtils{
  DialogUtils._();
  static final DialogUtils _instance = DialogUtils._();
  factory DialogUtils() => _instance;

  Future<void> showOptionsDialog( BuildContext context,{required String title,
    required String option1,required String option2,
    required GestureTapCallback onTap1,
    required GestureTapCallback onTap2}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text(option1),
                    onTap:onTap1,
                  ),
                  Padding(padding: const EdgeInsets.all(10)),
                  GestureDetector(
                    child: Text(option2),
                    onTap:onTap2,
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

 


  showAdvancedDialog(BuildContext context,{ String? title , description ='' ,
    String? iconPath, textCancel='خروج' ,String? textOk,
    required GestureTapCallback onTabCancel, final GestureTapCallback? onTabOk  }){
    showDialog(context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.only(left: 16,top: 16, right: 16,bottom: 16),
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),

              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    height: 70.0,
                    width: 70.0,
                    child:  Image(
                      image: AssetImage(iconPath ?? ''),
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  title != null ? Text(title ,style:  TextStyle(fontSize: 22,fontWeight: FontWeight.w600),) : const SizedBox() ,
                  const SizedBox(height: 8.0,),
                  Text(description,style:  TextStyle(fontSize: 16),textAlign: TextAlign.center,),
                  description !=null || description !='' ? const SizedBox(height: 5,) : const SizedBox(height: 5,),
                  const SizedBox(height: 8.0,),
                  textOk == null ? CustomButton(
                    onPressed:onTabCancel ,
                    width: double.infinity,
                    margin:const EdgeInsets.only(left: 10.0 ,right: 10.0),
                    text: textCancel,
                  ) :Row(
                    children: [
                      Expanded(flex: 1,
                          child: CustomButton(
                            onPressed:onTabCancel ,
                            margin:const EdgeInsets.only(left: 5.0 ,right: 5.0),
                            text: textCancel,
                          ),
                      ),
                      Expanded(flex: 1,
                        child: CustomButton(
                          onPressed:onTabOk ?? (){},
                          margin:const EdgeInsets.only(left: 5.0 ,right: 5.0),
                          text: textOk,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );

        }
    );


  }
}