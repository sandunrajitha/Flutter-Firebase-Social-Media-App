import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttergram/models/user.dart' as models;
import 'package:fluttergram/providers/user_provider.dart';
import 'package:fluttergram/resources/firestore_methods.dart';
import 'package:fluttergram/utils/colors.dart';
import 'package:fluttergram/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final models.User user = Provider.of<UserProvider>(context).getUser!;

    return _file != null
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: (() => clearPostData()),
              ),
              title: const Text(
                'Post to',
                style:
                    TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
              ),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: () =>
                      postImage(user.uid, user.username, user.profilePicUrl),
                  child: const Text(
                    'Post',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                _isLoading
                    ? const LinearProgressIndicator(
                        color: Colors.blueAccent,
                      )
                    : const Padding(
                        padding: EdgeInsets.only(top: 0),
                      ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.profilePicUrl),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.47,
                      child: TextField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          hintText: 'Write a caption',
                          border: InputBorder.none,
                        ),
                        maxLines: 8,
                      ),
                    ),
                    SizedBox(
                      height: 55,
                      width: 55,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: MemoryImage(_file!),
                              fit: BoxFit.fill,
                              alignment: FractionalOffset.topCenter,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ],
            ),
          )
        : Center(
            child: IconButton(
              icon: const Icon(Icons.upload),
              onPressed: () => _selectImage(context),
            ),
          );
  }

  Future<void> _selectImage(BuildContext parentContext) {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  void postImage(
    String uid,
    String username,
    String profImage,
  ) async {
    try {
      setState(() {
        _isLoading = true;
      });

      String res = await FirestoreMethods().uploadPost(
        _file!,
        _descriptionController.text,
        uid,
        username,
        profImage,
      );

      setState(() {
        _isLoading = false;
      });

      if (context.mounted) {
        if (res == 'success') {
          clearPostData();
          showSnackBar(context, 'Posted!');
        } else {
          showSnackBar(context, res);
        }
      }
    } catch (err) {
      if (context.mounted) {
        showSnackBar(context, err.toString());
      }
    }
  }

  void clearPostData() {
    setState(() {
      _file = null;
    });
  }
}
