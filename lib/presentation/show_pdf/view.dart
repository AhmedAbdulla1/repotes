import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';

import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:reports/app/app_prefs.dart';
import 'package:reports/app/constant.dart';
import 'package:reports/app/di.dart';
import 'package:reports/data/data_source/lacal_database.dart';
import 'package:reports/presentation/resources/color_manager.dart';
import 'package:reports/presentation/resources/string_manager.dart';
import 'package:reports/presentation/resources/values_manager.dart';

class ShowPDFView extends StatefulWidget {
  const ShowPDFView(
      {Key? key,
      required this.filepath,
      required this.index,
      this.state = true})
      : super(key: key);
  final int index;
  final String filepath;
  final bool state;

  @override
  State<ShowPDFView> createState() => _ShowPDFViewState();
}

class _ShowPDFViewState extends State<ShowPDFView> {
  String url = 'https://roayadesign.com/api_s/tqarer_a3meda_s3udia/pdf_upload';
  final AppPreferences _appPreferences = instance<AppPreferences>();
  bool isLoading = false;
  Box box = Hive.box<AddColumnModel>(Constant.mainBoxName);

  Future<void> uploadFile(String filePath, String url) async {
    final dio = Dio();

    try {
      FormData formData = FormData.fromMap({
        'user_name': _appPreferences.getToken(),
        'pdf': await MultipartFile.fromFile(filePath),
      });

      Response response = await dio.post(url, data: formData);
      if (response.statusCode == 200) {
        isLoading = false;
        setState(() {});
        print('File uploaded successfully!');
      } else {
        print('File upload failed with status ${response.statusCode}');
      }
    } catch (error) {
      print('File upload failed: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'pdf',
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Stack(children: [
            Column(
              children: [
                widget.filepath.isNotEmpty
                    ? Expanded(
                        child: PDFView(
                          filePath: widget.filepath,
                          pageSnap: false,
                          onRender: (page) {
                            setState(() {});
                          },
                        ),
                      )
                    : const SizedBox(),
                if (widget.state)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                        height: AppSize.s55,
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: !isLoading
                                ? () async {
                                    isLoading = true;
                                    setState(() {});
                                    await uploadFile(widget.filepath, url)
                                        .then((value) {
                                          isLoading = false ;
                                          setState(() {
                                            box.deleteAt(widget.index);
                                            Navigator.pop(context);
                                          });

                                    });
                                  }
                                : null,
                            child: const Text(AppStrings.save))),
                  ),
              ],
            ),
            if (isLoading)
              Center(
                child: Container(
                  color: Colors.black12,
                  child: CircularProgressIndicator(
                    color: ColorManager.primary,
                  ),
                ),
              )
          ]),
        ),
      ),
    );
  }
}
