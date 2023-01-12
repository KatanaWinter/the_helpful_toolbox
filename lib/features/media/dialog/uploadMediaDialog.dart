import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:the_helpful_toolbox/data/models/MediaModel.dart';
import 'package:the_helpful_toolbox/helper/media_query.dart';

class UploadMediaDialog extends StatefulWidget {
  String sUploadTo;
  Widget lastScreen;
  UploadMediaDialog(BuildContext context,
      {super.key, required this.sUploadTo, required this.lastScreen});

  @override
  State<UploadMediaDialog> createState() => _UploadMediaDialogState();
}

class _UploadMediaDialogState extends State<UploadMediaDialog> {
  final _formKey = GlobalKey<FormState>();
  Media _media = Media();
  late PlatformFile lFile;
  FilePickerResult? result;
  TextEditingController _mediaName = TextEditingController();

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Upload Media'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Wrap(
            children: [
              Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: isSmallScreen(context)
                          ? getScreenWidth(context)
                          : getScreenWidth(context) * 0.4,
                      height: getScreenHeight(context),
                      child: FocusScope(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: _mediaName,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'File to Upload'),
                                enabled: false,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter a value';
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  setState(() {
                                    _media.name = value;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  result = await FilePicker.platform.pickFiles(
                                      allowMultiple: false,
                                      allowedExtensions: [
                                        'pdf',
                                        'docx',
                                        'jpg',
                                        'jpeg',
                                        'png'
                                      ],
                                      withData: true,
                                      type: FileType.custom);
                                  if (result == null) {
                                    print("No file selected");
                                  } else {
                                    setState(() {});
                                    result?.files.forEach((element) {
                                      _media.name = element.name;
                                      _mediaName.text = element.name;
                                      lFile = element;
                                      print(element.name);
                                    });
                                  }
                                },
                                child: const Text("File Picker")),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Cancel'),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    }),
                                const SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton(
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Save'),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      saveMediaDialog(context, _media, lFile);
                                    } else {
                                      print('Error');
                                    }
                                    // Hier passiert etwas anderes
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  saveMediaDialog(context, Media media, PlatformFile lFile) async {
    Media stored = await media.mediaStore(context, lFile, widget.sUploadTo);
    // stored == true
    //     ? debugPrint("save employee to Database success")
    //     : debugPrint("save employee to Database failed");

    setState(() {});
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => widget.lastScreen));
  }
}
