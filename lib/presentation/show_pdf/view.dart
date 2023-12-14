import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:reports/app/app_prefs.dart';
import 'package:reports/app/constant.dart';
import 'package:reports/app/di.dart';
import 'package:reports/data/data_source/lacal_database.dart';
import 'package:reports/presentation/common/state_render/state_renderer_imp.dart';
import 'package:reports/presentation/resources/color_manager.dart';
import 'package:reports/presentation/resources/routes_manager.dart';
import 'package:reports/presentation/resources/string_manager.dart';
import 'package:reports/presentation/resources/values_manager.dart';
import 'package:reports/presentation/show_pdf/view_model.dart';

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
  final ShowPdfViewModel _viewModel = ShowPdfViewModel();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'pdf',
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: ColorManager.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder<StateFlow>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) =>
              snapshot.data?.getScreenWidget(
                context,
                _getContent(),
                () {},
              ) ??
              _getContent()),
    );
  }

  Widget _getContent() {
    return SafeArea(
      child: Column(
        children: [
          widget.filepath.isNotEmpty
              ? Expanded(
                  child: PDFView(
                    filePath: widget.filepath,
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
                      onPressed: () {
                        _viewModel
                            .uploadPdf(
                          widget.filepath,
                          context,
                          widget.index,
                        ).then((value) {
                         if (value) Navigator.pop(context);
                        });
                      },
                      child: const Text(
                        AppStrings.save,
                        style: TextStyle(color: Colors.white),
                      ))),
            ),
        ],
      ),
    );
  }
}
