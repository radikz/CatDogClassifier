import 'package:flutter/material.dart';

import 'just_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: Provider.of<JustProvider>(context, listen: false).loadModel(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.error != null) {
                return Center(
                  child: Text('Error has occurred'),
                );
              } else {
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Cat Dog Classifier',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          // width: double.infinity,
                          child: Consumer<JustProvider>(
                            builder: (context, image, ch) =>
                                image.getImage != null
                                    ? Image.file(
                                        image.getImage,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        'https://cdn.pixabay.com/photo/2016/07/21/14/18/dog-1532627_960_720.png',
                                        fit: BoxFit.cover,
                                      ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Consumer<JustProvider>(
                            builder: (context, result, ch) => result
                                        .getOutput !=
                                    null
                                ? Text(
                                    'Result: ${result.getOutput[0]['label']}')
                                : Container()),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: TextButton(
                                  onPressed: () async {
                                    final _image =
                                        await Provider.of<JustProvider>(context,
                                                listen: false)
                                            .pickImage(false);
                                    await Provider.of<JustProvider>(context,
                                            listen: false)
                                        .detect(_image);
                                  },
                                  child: Text(
                                    'Take from gallery',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: TextButton(
                                  onPressed: () async {
                                    // await ImagePicker().getImage(source: ImageSource.gallery);
                                    final _image =
                                        await Provider.of<JustProvider>(context,
                                                listen: false)
                                            .pickImage(true);
                                    await Provider.of<JustProvider>(context,
                                            listen: false)
                                        .detect(_image);
                                  },
                                  child: Text(
                                    'Take from camera',
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
