import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:flutter/material.dart';

class PdfViewer extends StatefulWidget {
  final String document;
  const PdfViewer({ Key? key , required this.document}) : super(key: key);

  @override
  State<PdfViewer> createState() => _PdfViewerState(document: this.document);
}

class _PdfViewerState extends State<PdfViewer> {
  final String document;
  _PdfViewerState({required this.document});
  late PDFDocument pdfDocument;
  bool _isLoading = true;

  @override
  void initState() {
    loadDocument();
    super.initState();
  }

  loadDocument() async {
    pdfDocument = await PDFDocument.fromURL(document,
                        headers: {
                          'Authorization':
                              'Bearer ${PreferenceUtils.getString('token')}'},
                            );
                            setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Example'),
      ),
      body: Center(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : PDFViewer(document: pdfDocument,)),
    );
  }
}