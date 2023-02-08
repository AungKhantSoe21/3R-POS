import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:r_pos/utils/constant_color.dart';
import 'package:r_pos/utils/constant_text.dart';
import 'package:r_pos/widgets/toast_message.dart';

class IngredientScreen extends StatefulWidget {
  const IngredientScreen({Key? key}) : super(key: key);

  @override
  State<IngredientScreen> createState() => _IngredientScreenState();
}

class _IngredientScreenState extends State<IngredientScreen> {
  final TextEditingController _ingredient = TextEditingController();
  final TextEditingController _ingredientPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {Navigator.pop(context);}, 
          icon: const Icon(Icons.arrow_back, color: Colors.white,)
        ),
        title: const Text(
          "Ingredient",
          style: TextStyle(
              fontFamily: poppinFont, fontSize: 16, color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              title: const Text(
                "New Ingredient",
                style: TextStyle(fontSize: 12),
              ),
              content: SizedBox(
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labelText("Ingredient Name", padding: 10),
                    textField("Enter ingredient name", double.infinity, _ingredient, TextInputType.name, ""),
                    labelText("Ingredient Price", padding: 10),
                    textField("Enter ingredient price", double.infinity, _ingredientPrice, TextInputType.number, "")
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _ingredient.text = "";
                    _ingredientPrice.text = "";
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    ref
                        .child("Ingredient")
                        .push()
                        .set({
                          "ingredient_name": _ingredient.text,
                          "ingredient_price": _ingredientPrice.text 
                        }).asStream();
                    _ingredient.text = "";
                    _ingredientPrice.text = "";
                    Navigator.pop(context);
                    toastMessage("Ingredient created", txtColor: Colors.green);
                  },
                  child: const Text(
                    "Create",
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
          );
        },
        backgroundColor: primaryColor,
        child: Stack(
          clipBehavior: Clip.none,
          children: const [
            Icon(
              Icons.restaurant,
              color: Colors.white,
              size: 18,
            ),
            Positioned(
              left: 12,
              bottom: 13,
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 14,
              ),
            ),
          ],
        ),
      ),
      body: FirebaseAnimatedList(
        query: ref.child("Ingredient"), 
        itemBuilder: (context, snapshot, a, i) {
          Map mydata = snapshot.value as Map;
          mydata['key'] = snapshot.key;
          return ListTile(
            leading: const Icon(Icons.restaurant_sharp),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(mydata['ingredient_name']),
                Text(mydata['ingredient_price'] + " Ks"),
              ],
            ),
            trailing: IconButton(
              onPressed: () {
                ref.child("ingredient").child(mydata['key']).remove();
              }, 
              icon: const Icon(Icons.delete, color: Colors.red,)
            ),
          );
        }
      ),
    );
  }

  Widget labelText(String text, {double padding = 30}) {
    return Padding(
      padding: EdgeInsets.only(left: padding, bottom: 5),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }

  Widget textField(
      String hintText,
      double width,
      TextEditingController controller,
      TextInputType textInputType,
      String error) {
    return Center(
      child: SizedBox(
        width: width,
        child: TextField(
          controller: controller,
          keyboardType: textInputType,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
            // error text for textfield
            errorText: error,
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 12),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10)),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}