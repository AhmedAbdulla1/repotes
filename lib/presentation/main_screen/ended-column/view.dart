import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:image_picker/image_picker.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:reports/presentation/common/reusable/custom_button.dart';
import 'package:reports/presentation/common/state_render/state_renderer_imp.dart';
import 'package:reports/presentation/main_screen/ended-column/view_model.dart';
import 'package:reports/presentation/resources/color_manager.dart';
import 'package:reports/presentation/resources/font_manager.dart';
import 'package:reports/presentation/resources/values_manager.dart';

class EndedColumnView extends StatelessWidget {
  EndedColumnView({Key? key}) : super(key: key);
  final EndedColumnViewModel _viewModel = EndedColumnViewModel();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<StateFlow>(
      stream: _viewModel.outputState,
      builder: (context, snapshot) =>
          snapshot.data?.getScreenWidget(
            context,
            _getContent(),
            () {},
          ) ??
          _getContent(),
    );
  }

  Widget _getContent() {
    return ListView.separated(
        padding: EdgeInsets.all(AppPadding.p16),
        itemBuilder: (context, index) => _customItem(),
        separatorBuilder: (context, index) => SizedBox(
              height: AppSize.s16.h,
            ),
        itemCount: 30);
  }

  Widget _customItem() {
    return Container(
      decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(
            AppSize.s12,
          ),
          boxShadow: [
            BoxShadow(
              color: ColorManager.grey,
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ]),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.all(AppPadding.p8),
            child: Icon(
              Icons.picture_as_pdf_sharp,
            ),
          ),
          Expanded(
              flex: 4,
              child: Text(
                'اسم العمود524878 ',
                style: TextStyle(fontSize: FontSize.s24),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )),
          Expanded(
            flex: 3,
            child: customElevatedButtonWithoutStream(
              onPressed: () {},
              child: const Text("عرض"),
            ),
          ),
          Expanded(
            flex: 3,
            child: customElevatedButtonWithoutStream(
              onPressed: () {},
              child: const Text("حذف"),
            ),
          ),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<File> _selectedImages = [];
  int _pdfPage = 0;
  bool _showPdf = false;

  Future<void> _pickImages() async {
    List<XFile>? images = await ImagePicker().pickMultiImage();
    setState(() {
      _selectedImages = images.map((image) => File(image.path)).toList();
      _showPdf = false;
    });
  }

  Future<Uint8List> _generatePdf() async {
    final pdf = pw.Document();

    for (var imageFile in _selectedImages) {
      final bytes = await imageFile.readAsBytes();
      final image = pw.MemoryImage(bytes);

      pdf.addPage(pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(image),
          );
        },
      ));
    }

    return pdf.save();
  }

  Uint8List? pdfBytes;

  @override
  Widget build(BuildContext context) {
    print(pdfBytes);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _pickImages,
            child: Text('Pick Images'),
          ),
          SizedBox(height: 16),
          if (_selectedImages.isNotEmpty && !_showPdf)
            ElevatedButton(
              onPressed: () async {
                pdfBytes = await _generatePdf();
                setState(() {
                  _showPdf = true;
                });
                // Display the PDF by setting the page to 0
                _pdfPage = 0;
              },
              child: Text('Convert to PDF'),
            ),
          if (_showPdf)
            Expanded(
              child: PDFView(
                filePath: null,
                pdfData: pdfBytes,
                // Pass the PDF file path here if loading from a file
                pageSnap: false,
                onRender: (page) {
                  setState(() {
                    _pdfPage = page ?? 0;
                  });
                },
              ),
            ),
          if (_showPdf) Text('Page $_pdfPage'),
        ],
      ),
    );
  }
}
