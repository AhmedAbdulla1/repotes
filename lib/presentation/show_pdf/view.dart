import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

import 'package:pdf/widgets.dart' as pw;

import 'package:flutter_pdfview/flutter_pdfview.dart';

class ShowPDFView extends StatefulWidget {
  const ShowPDFView({Key? key}) : super(key: key);

  @override
  State<ShowPDFView> createState() => _ShowPDFViewState();
}

class _ShowPDFViewState extends State<ShowPDFView> {
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
    List images = [];
    for (var imageFile in _selectedImages) {
      final bytes = await imageFile.readAsBytes();
      final image = pw.MemoryImage(bytes);
      images.add(image);
    }
    ByteData byteData = await rootBundle.load('assets/fonts/Cairo-Light.ttf');
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  ' اسم العمود: عمود رقم 2',
                  style: pw.TextStyle(
                    fontSize: 40,
                    fontWeight: pw.FontWeight.bold,
                    font: pw.Font.ttf(byteData),
                  ),
                ),
                pw.SizedBox(height: 30),
                pw.Link(
                  child: pw.Text(
                    'الموقع',
                    style: pw.TextStyle(
                      fontSize: 40,
                      fontWeight: pw.FontWeight.bold,
                      font: pw.Font.ttf(byteData),
                    ),
                  ),
                  destination: 'https://www.google.com/maps/place/30%C2%B058\'13.9%22N+31%C2%B00\'18.8%22E',
                ),
                pw.SizedBox(
                  height: 150,
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        child: pw.Image(images[0], fit: pw.BoxFit.fitWidth),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Expanded(
                        child: pw.Image(images[1], fit: pw.BoxFit.fitWidth),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(
                  height: 150,
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        child: pw.Image(images[0], fit: pw.BoxFit.fitWidth),
                      ),
                      pw.SizedBox(width: 10),
                      pw.Expanded(
                        child: pw.Image(images[1], fit: pw.BoxFit.fitWidth),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  Uint8List? pdfBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: _pickImages,
                child: const Text('Pick Images'),
              ),
              const SizedBox(height: 16),
              if (_selectedImages.isNotEmpty && !_showPdf)
                ElevatedButton(
                  onPressed: () async {
                    pdfBytes = await _generatePdf();
                    List<int> pdfList = pdfBytes!.toList();
                    String newi = pdfList.join();
                    print(newi);
                    // print(
                    //     "********************** ${pdfList.length}*****************************");
                    // List<int> pdfUtf = utf8.encode(newi);
                    // print("000000000${pdfUtf.length}0000000");
                    // print(pdfUtf);
                    // // utf8.encode(pdfUtf);
                    print(pdfBytes);
                    setState(() {
                      _showPdf = true;
                    });
                    // Display the PDF by setting the page to 0
                    _pdfPage = 0;
                  },
                  child: Text('Convert to PDF'),
                ),
              if (_showPdf)
                Container(
                  height: 500,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all()),
                  child: PDFView(
                    filePath: null,
                    pdfData: pdfBytes,
                    pageSnap: false,
                    onRender: (page) {
                      setState(() {
                        _pdfPage = page ?? 0;
                      });
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
