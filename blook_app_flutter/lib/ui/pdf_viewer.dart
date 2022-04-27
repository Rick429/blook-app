import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:blook_app_flutter/utils/preferences.dart';
import 'package:blook_app_flutter/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatefulWidget {
  final String document;
  const PdfViewer({Key? key, required this.document}) : super(key: key);

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
                      'Bearer ${PreferenceUtils.getString('token')}'
                },);
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BlookStyle.blackColor,
      appBar: AppBar(
              backgroundColor: Colors.transparent,
              iconTheme: const IconThemeData(color: Colors.white),
            ),
      body: Center(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
                decoration: BoxDecoration(),
                child: PDF(
                  fitPolicy: FitPolicy.BOTH,
                  autoSpacing: true,
                  fitEachPage: true,
                  pageSnap: false,
                ).fromUrl(
                  document,
                  headers: {
                    'Authorization':
                        'Bearer ${PreferenceUtils.getString('token')}'
                  },
                ),
              ),
             /*  PDFViewer(
                document: pdfDocument,) */
            /* SfPdfViewer.network(
                document,
                headers: {
                  'Authorization':
                      'Bearer ${PreferenceUtils.getString('token')}'
                },
              ), */
      ),
    );
  }
}
