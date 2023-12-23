
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String book = "";
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      // File file = .;
      PdfDocument document = PdfDocument(inputBytes: result.files.first.bytes);
      book = PdfTextExtractor(document).extractText();
      document.dispose();
      setState(() {});
    } else {}
  }

  Future<void> read() async {
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.speak(book);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    book,
                    style: TextStyle(fontSize: 10),
                  ),
                )),
            const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "PDF Reader",
                    style: TextStyle(fontSize: 30),
                  ),
                )),
            ElevatedButton(
                onPressed: () => pickFile(), child: const Text("Upload PDFs")),
            Text(book == "" ? "Not Ready" : "Ready"),
            book == ""
                ? ElevatedButton(
                onPressed: () => {}, child: const Text("Please Wait"))
                : ElevatedButton(
                onPressed: () => read(), child: const Text("Read"))
          ],
        ),
      ),
    );
  }
}
