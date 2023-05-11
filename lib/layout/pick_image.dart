import 'dart:io';
import 'dart:math';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../constants/colors_constants.dart';
import '../utils/common_helper.dart';
import '../utils/custom_alert_dialog.dart';

class PickImageScreen extends StatefulWidget {
  const PickImageScreen({super.key});

  @override
  State<PickImageScreen> createState() => _PickImageScreenState();
}

class _PickImageScreenState extends State<PickImageScreen> {
  File? uploadImage;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      onPressed: () {
        showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomAlertDialog(
                                  height: 200,
                                  widget: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          leading: const Icon(
                                            Icons.add_photo_alternate_outlined,
                                          ),
                                          title: TextButton(
                                            child: const Text(
                                              'المعرض',
                                              style: TextStyle(
                                                fontSize: 20,
                                                color: AppColor.PrimaryColor,
                                              ),
                                            ),
                                            onPressed: () async {
                                              if (await CommonHelper
                                                  .checkCameraAndGalleryPermission(
                                                      context)) {
                                                var picked = await ImagePicker()
                                                    .pickImage(
                                                        source: ImageSource
                                                            .gallery);
                                                if (picked != null) {
                                                  uploadImage =
                                                      File(picked.path);
                                                  uploadImage =
                                                      await CommonHelper
                                                          .compress(
                                                              image:
                                                                  uploadImage,
                                                              quality: 80);
                                                  var rand =
                                                      Random().nextInt(100000);
                                                  var imagename = "$rand" +
                                                      basename(
                                                          uploadImage?.path ??
                                                              '');

                                                  Navigator.of(context).pop();
                                                  setState(() {});
                                                }
                                              }
                                            },
                                          ),
                                        ),
                                        ListTile(
                                          leading: const Icon(
                                              Icons.add_a_photo_outlined),
                                          title: TextButton(
                                              child: const Text(
                                                'الكاميرا',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: AppColor.PrimaryColor,
                                                ),
                                              ),
                                              onPressed: () async {
                                                var picked = await ImagePicker()
                                                    .pickImage(
                                                        source:
                                                            ImageSource.camera);
                                                if (picked != null) {
                                                  uploadImage =
                                                      File(picked.path);
                                                  uploadImage =
                                                      await CommonHelper
                                                          .compress(
                                                              image:
                                                                  uploadImage,
                                                              quality: 80);
                                                  var rand =
                                                      Random().nextInt(100000);
                                                  var imagename = "$rand" +
                                                      basename(
                                                          uploadImage?.path ??
                                                              '');

                                                  Navigator.of(context).pop();
                                                  setState(() {});
                                                }
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                         
      },
      child: Text('Pick Image'),
    ));
  }
}
