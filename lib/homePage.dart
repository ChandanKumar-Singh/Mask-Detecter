import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading = false;
  var _image;
  final image = File('assets/masks.png');
  final imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  void _loadImageGallery() async {
    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    } else {
      setState(() {
        _loading = true;
        _image = File(image.path);
      });
    }
  }

  void _loadImageCamera() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    if (image == null) {
      return null;
    } else {
      setState(() {
        _loading = true;
        _image = File(image.path);
      });
    }
  }

  void loadModel() async {}

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ML Classifier',
          style: GoogleFonts.roboto(),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: h,
          width: w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: Image.asset(
                  'images/masks.png',
                  width: 100,
                ),
              ),
              Text(
                'ML Classifier',
                style: GoogleFonts.roboto(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: w,
                child: RaisedButton(
                  onPressed: () => _loadImageCamera(),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Camera',
                      style: GoogleFonts.roboto(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.teal,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: w,
                child: RaisedButton(
                  onPressed: () => _loadImageGallery(),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Gallery',
                      style: GoogleFonts.roboto(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: Colors.teal,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _loading
                  ? Expanded(child: Image.file(_image))
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
