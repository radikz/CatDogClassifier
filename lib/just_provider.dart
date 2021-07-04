import 'dart:io';

import 'package:flutter/widgets.dart';

// import 'package:provider/just_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class JustProvider with ChangeNotifier {
  File _image;
  List _output;

  List get getOutput {
    return _output;
  }

  File get getImage {
    return _image;
  }

  Future<void> detect(File image) async {
    final output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.6,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    _output = output;
    notifyListeners();
    // return _output;
  }

  Future<String> loadModel() async {
    final res = await Tflite.loadModel(
        model: "assets/model_unquant.tflite", labels: "assets/labels.txt");
    return res;
  }

  Future<File> pickImage(bool isCamera) async {
    var image = await ImagePicker()
        .getImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);
    if (image == null) return null;
    _image = File(image.path);
    return _image;
  }
}
