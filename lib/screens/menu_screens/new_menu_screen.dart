import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:r_pos/utils/constant_color.dart';
import 'package:r_pos/utils/constant_text.dart';
import 'package:r_pos/widgets/drop_down_bottom_modal.dart';
import 'package:r_pos/widgets/toast_message.dart';

class NewMenuScreen extends StatefulWidget {
  const NewMenuScreen({Key? key}) : super(key: key);

  @override
  State<NewMenuScreen> createState() => _NewMenuScreenState();
}

class _NewMenuScreenState extends State<NewMenuScreen> {
  final TextEditingController _menuNameController = TextEditingController();
  final TextEditingController _menuPriceController = TextEditingController();
  final TextEditingController _menuStatus = TextEditingController();
  final TextEditingController _category = TextEditingController();
  final TextEditingController _categoryName = TextEditingController();

  File? image;
  String imageUrl = "";

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    final ref = FirebaseDatabase.instance.ref();
    final que = ref.child("Category");

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {Navigator.pop(context);}, 
          icon: Icon(Icons.arrow_back, color: Colors.white,)
        ),
        title: Text("New Menu", style: TextStyle( fontFamily: poppinFont, fontSize: 16),),
      ),
      body: Column(
        children: [
          SizedBox(height: 15,),
          if(!isKeyboard)
          SizedBox(
            height: 130,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: ((buider) => showCustomBottomSheet()),
                );
              },
              customBorder: const CircleBorder(),
              child: image != null 
              ? CircleAvatar(
                radius: 52,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                    backgroundColor: primaryColor,
                    radius: 50,
                    backgroundImage: FileImage(image!),
                  ),
              )
              : CircleAvatar(
                radius: 52,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  backgroundColor: primaryColor,
                  radius: 50,
                  child: Center(
                    child: Icon(Icons.camera_alt, color: Colors.white,),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  labelText("Category"),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () async {
                              String data = await dropDownBottomModal(
                                context, false, [], que, dropListItemName: "category_name"
                              );
                              setState(() {
                                if(data.isEmpty) {
                                  _category.text = _category.text;
                                } else {
                                  _category.text = data;
                                }
                              });
                            },
                            child: AbsorbPointer(
                              child: textField(
                                "Choose category", MediaQuery.of(context).size.width * 0.75, _category, TextInputType.name, ""
                              ),
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 25.0),
                            child: SizedBox(
                              width: 50,
                              height: 45,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(primaryColor),
                                  foregroundColor: MaterialStateProperty.all(Colors.white)
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context, 
                                    barrierDismissible: false,
                                    builder: (context) => AlertDialog(
                                      title: Text("New Category", style: TextStyle(fontSize: 12),),
                                      content: SizedBox(
                                        height: 100,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            labelText("Category Name", padding: 10),
                                            textField(
                                              "Enter category name", 
                                              double.infinity, 
                                              _categoryName, 
                                              TextInputType.name,
                                              ""
                                            )
                                          ],
                                        ),
                                      ),
                                      actions: [  
                                          TextButton(onPressed: () {
                                            _categoryName.text = "";
                                            Navigator.pop(context);
                                          }, child: Text("Cancel", style: TextStyle(color: Colors.red),),),  
                                          TextButton(onPressed: () async {
                                            await ref.child("Category").push().set({
                                              "category_name" : _categoryName.text
                                            }).asStream();
                                            _categoryName.text = "";
                                            Navigator.pop(context);
                                            toastMessage("Category created", txtColor: Colors.green);
                                          }, child: Text("Create", style: TextStyle(color: Colors.green),),)  
                                      ]
                                    )
                                  );
                                },
                                child: Center(child: Icon(Icons.add)),
                              )
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  labelText("Name"),
                  textField("Enter menu name", MediaQuery.of(context).size.width * 0.9, _menuNameController, TextInputType.name, ""),
                  labelText("Price"),
                  textField("Enter menu price", MediaQuery.of(context).size.width * 0.9, _menuPriceController, TextInputType.number, ""),
                  labelText("Status"),
                  InkWell(
                    onTap: () async {
                      String data = await dropDownBottomModal(context, true, ["Available", "Unavailable"], ref);
                      setState(() {
                        if(data.isEmpty) {
                          _menuStatus.text = _menuStatus.text;
                        } else {
                          _menuStatus.text = data;
                        }
                      });
                    },
                    child: AbsorbPointer(
                      child: textField("Set menu status", MediaQuery.of(context).size.width * 0.9, _menuStatus, TextInputType.name, "")
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 100,
                      height: 40,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(primaryColor),
                          foregroundColor: MaterialStateProperty.all(Colors.black)
                        ),
                        onPressed: () async {
                          await ref.child("Item").child(_category.text).push().set({
                            "image_path" : imageUrl,
                            "item_name" : _menuNameController.text,
                            "item_price" : _menuPriceController.text,
                            "item_status" : _menuStatus.text 
                          });
                          Navigator.pop(context);
                        }, 
                        child: Text("Create", style: TextStyle(color: Colors.white),)
                      ),
                    ),
                  )
                ],
              ),
            )
          )
        ],
      ),
    );
  }

  Widget labelText(String _text, {double padding = 30}) {
    return Padding(
      padding: EdgeInsets.only(left: padding, bottom: 5),
      child: Text(
        _text,
        style: TextStyle(
          fontSize: 12
        ),
      ),
    );
  }

  Widget textField(String _hintText, double _width, TextEditingController _controller, TextInputType _textInputType, String _error) {
    return Center(
      child: SizedBox(
        width: _width,
        child: TextField(
          controller: _controller,
          keyboardType: _textInputType,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            // error text for textfield
            errorText: _error,
            hintText: _hintText,
            hintStyle: TextStyle(fontSize: 12),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(10)
            ),
            errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  Widget showCustomBottomSheet() {
    return Container(
      padding: const EdgeInsets.all(25),
      color: Colors.white10,
      height: 120,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              getPhoto(ImageSource.camera);
              Navigator.pop(context);
            },
            child: Column(
              children: [
                Icon(Icons.camera_alt_outlined),
                SizedBox(
                  height: 10,
                ),
                Text("Camera")
              ],
            ),
          ),
          InkWell(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              getPhoto(ImageSource.gallery);
              Navigator.pop(context);
            },
            child: Column(
              children: [
                Icon(Icons.photo_outlined),
                SizedBox(
                  height: 10,
                ),
                Text("Gallery")
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future getPhoto(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
      String uniqueName = DateTime.now().millisecondsSinceEpoch.toString() + image.path.toUpperCase();
      Reference storageRef = FirebaseStorage.instance.ref();
      Reference refDirImage = storageRef.child("images");
      Reference refImageToUpload = refDirImage.child(uniqueName);
      try {
        await refImageToUpload.putFile(imageTemporary);
        imageUrl = await refImageToUpload.getDownloadURL();
      } catch (e) {
        log("Error: $e");
      }
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Fail to pick image: $e');
      }
    }
  }
}