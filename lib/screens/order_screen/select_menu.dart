import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:r_pos/utils/constant_color.dart';
import 'package:r_pos/utils/constant_text.dart';
import 'package:r_pos/widgets/drop_down_bottom_modal.dart';
import 'package:r_pos/widgets/loader.dart';
import 'package:r_pos/widgets/toast_message.dart';

class SelectedMenuList {
  static List selectedMenuCard = [];
}

class SelectMenuScreen extends StatefulWidget {
  const SelectMenuScreen({Key? key}) : super(key: key);

  @override
  State<SelectMenuScreen> createState() => _SelectMenuScreenState();
}

class _SelectMenuScreenState extends State<SelectMenuScreen> {
  List categoryList = [];
  List items = [];
  List selectedMenuCard = [];
  int ingredientPrice = 0;

  final TextEditingController _ingredient = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < SelectedMenuList.selectedMenuCard.length; i++) {
      selectedMenuCard.add({
        "key": SelectedMenuList.selectedMenuCard[i]["key"],
        "data": SelectedMenuList.selectedMenuCard[i]["data"].toList(),
      });
    }
  }

  // rules calculation
  List setOfRules = [
    {
      "front_itemset": ["လက်ဖက်ရည်"], 
      "back_itemset": [
        {
          "key": "-NNmS-hWiBc5aP4onhkd",
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675883690998%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER4583947381730164383.JPG?alt=media&token=ff6de3ef-71f5-4d50-9347-43032321bd3c",
          "item_name" : "ထမင်းကြော်",
          "item_price" : "2000",
          "item_status" : "Available"
        },
        {
          "key": "-NNlyTiAypy-CZBA7QNA",
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675875681567%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER7725385218028057313.JPG?alt=media&token=4b9c91c4-c1cf-4fb8-b598-adea4f083519",
          "item_name" : "ကြက်ဥပလာတာ",
          "item_price" : "1500",
          "item_status" : "Available"
        },
        {
          "key": "-NNmFAgnObRehYQWmXr5",
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675880324530%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER1856379200483197038.JPG?alt=media&token=d087c472-e6e2-4188-84b1-199058cdd57d",
          "item_name" : "ပေါင်မုန့်မီးကင်",
          "item_price" : "1000",
          "item_status" : "Available"
        }
      ]
    },
    {
      "front_itemset": [], 
      "back_itemset": []
    },
    {
      "front_itemset": [], 
      "back_itemset": []
    },
    {
      "front_itemset": [], 
      "back_itemset": []
    }
  ];
  List frontItemset = [];
  List suggestedMenuSet = [];
  // rules calculation

  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance.ref();
    final que = ref.child("Ingredient");

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          "Select Menu",
          style: TextStyle(
              color: Colors.white, fontFamily: poppinFont, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: ref.child("Category").onValue.asBroadcastStream(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    final map = snapshot.data.snapshot.value;
                    categoryList = map.values.toList();
                    categoryList.sort((a, b) =>
                        a['category_name'].compareTo(b['category_name']));
                    return DefaultTabController(
                      length: categoryList.length + 1,
                      child: Column(
                        children: [
                          TabBar(
                            isScrollable: true,
                            indicatorColor: primaryColor,
                            indicatorSize: TabBarIndicatorSize.label,
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.black,
                            tabs: [
                              Tab(
                                child: Center(
                                  child: Text(
                                    "Suggested Menu",
                                  ),
                                ),
                              ),
                              for (int i = 0; i < categoryList.length; i++)
                                Tab(
                                  child: Center(
                                    child: Text(
                                      categoryList[i]['category_name'],
                                    ),
                                  ),
                                )
                            ],
                          ),
                          Expanded(
                              child: TabBarView(
                            children: [
                                suggestedMenuSet.isEmpty
                                ? Center(
                                  child: Text("No suggestion yet!"),
                                )
                                : ListView.separated(
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            // calculation of suggestion menu
                                              // if(frontItemset.contains(suggestedMenuSet[index]["item_name"])) {
                                              //   frontItemset.add(suggestedMenuSet[index]["item_name"]);
                                              // }
                                              // suggestedMenuSet.clear();
                                              // for(int i = 0; i < setOfRules.length; i++) {
                                              //   if(setOfRules[i]["front_itemset"] == frontItemset) {
                                              //     for(int j = 0; j < setOfRules[i]["back_itemset"].length; j++) {
                                              //       suggestedMenuSet.add(
                                              //         setOfRules[i]["back_itemset"][j]
                                              //       );
                                              //     }
                                              //   }
                                              // }
                                              // calculation of suggestion menu
                                            if (selectedMenuCard.isEmpty) {
                                              selectedMenuCard.add({
                                                'key': suggestedMenuSet[index]
                                                    ['key'],
                                                'data': [
                                                  {
                                                    'image':
                                                        suggestedMenuSet[index]
                                                            ['image_path'],
                                                    'name':
                                                        suggestedMenuSet[index]
                                                            ['item_name'],
                                                    'ingredient': "",
                                                    'description': "",
                                                    'ingredient_price': "",
                                                    'price':
                                                        suggestedMenuSet[index]
                                                            ['item_price']
                                                  }
                                                ]
                                              });
                                            } else {
                                              for (int j = 0;
                                                  j < selectedMenuCard.length;
                                                  j++) {
                                                if (selectedMenuCard[j]
                                                        ['key'] ==
                                                    suggestedMenuSet[index]
                                                        ['key']) {
                                                  selectedMenuCard[j]['data']
                                                      .add({
                                                    'image':
                                                        suggestedMenuSet[index]
                                                            ['image_path'],
                                                    'name':
                                                        suggestedMenuSet[index]
                                                            ['item_name'],
                                                    'ingredient': "",
                                                    'description': "",
                                                    'ingredient_price': "",
                                                    'price':
                                                        suggestedMenuSet[index]
                                                            ['item_price']
                                                  });
                                                  break;
                                                } else if (j ==
                                                    selectedMenuCard.length -
                                                        1) {
                                                  selectedMenuCard.add({
                                                    'key':
                                                        suggestedMenuSet[index]
                                                            ['key'],
                                                    'data': [
                                                      {
                                                        'image':
                                                            suggestedMenuSet[
                                                                    index]
                                                                ['image_path'],
                                                        'name':
                                                            suggestedMenuSet[
                                                                    index]
                                                                ['item_name'],
                                                        'ingredient': "",
                                                        'description': "",
                                                        'price':
                                                            suggestedMenuSet[
                                                                    index]
                                                                ['item_price']
                                                      }
                                                    ]
                                                  });
                                                  break;
                                                }
                                              }
                                            }
                                          });
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 10),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.30,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    color: primaryColor,
                                                    border: Border.all(),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: CachedNetworkImage(
                                                      imageUrl: suggestedMenuSet[
                                                                              index]
                                                                          [
                                                                          'image_path']
                                                                      .toString() ==
                                                                  "null" ||
                                                              suggestedMenuSet[
                                                                              index]
                                                                          [
                                                                          'image_path']
                                                                      .isEmpty ==
                                                                  true
                                                          ? "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/defaultImage%2Ffood.jpg?alt=media&token=5d34f868-8500-4062-a6f9-2e223ea7eb2f"
                                                          : suggestedMenuSet[
                                                                  index]
                                                              ['image_path'],
                                                      placeholder: (context,
                                                              s) =>
                                                          Loader(
                                                              Colors.white, 2,
                                                              size: 15),
                                                    ),
                                                  )),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0),
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.60,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        suggestedMenuSet[index]
                                                            ['item_name'],
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        suggestedMenuSet[index]
                                                                ['item_price'] +
                                                            " Ks",
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                        height: 10,
                                      );
                                    },
                                    itemCount: suggestedMenuSet.length
                              ),
                              for (int i = 0; i < categoryList.length; i++)
                                FirebaseAnimatedList(
                                    query: ref.child("Item").child(
                                        categoryList[i]["category_name"]),
                                    itemBuilder: (context, snapshot, animation, index) {
                                      Map mydata = snapshot.value as Map;
                                      mydata['key'] = snapshot.key;

                                      if (snapshot.hasChild("image_path") !=
                                          true) {
                                        return const Center(
                                          child: Text(
                                              "No menu for this category!"),
                                        );
                                      } else {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              // calculation of suggestion menu
                                              if(frontItemset.contains(mydata["item_name"]) == false) {
                                                frontItemset.add(mydata["item_name"]);
                                              }
                                              suggestedMenuSet.clear();
                                              for(int i = 0; i < setOfRules.length; i++) {
                                                if(setOfRules[i]["front_itemset"].toString() == frontItemset.toString()) {
                                                  for(int j = 0; j < setOfRules[i]["back_itemset"].length; j++) {
                                                    suggestedMenuSet.add(
                                                      setOfRules[i]["back_itemset"][j]
                                                    );
                                                  }
                                                }
                                              }
                                              // calculation of suggestion menu

                                              if (selectedMenuCard.isEmpty) {
                                                selectedMenuCard.add({
                                                  'key': mydata['key'],
                                                  'data': [
                                                    {
                                                      'image': mydata['image_path'],
                                                      'name': mydata['item_name'],
                                                      'ingredient': "",
                                                      'description': "",
                                                      'ingredient_price': "",
                                                      'price': mydata['item_price']
                                                    }
                                                  ]
                                                });
                                              } else {
                                                for (int j = 0;
                                                    j < selectedMenuCard.length;
                                                    j++) {
                                                  if (selectedMenuCard[j]
                                                          ['key'] ==
                                                      mydata['key']) {
                                                    selectedMenuCard[j]['data']
                                                        .add({
                                                      'image':
                                                          mydata['image_path'],
                                                      'name':
                                                          mydata['item_name'],
                                                      'ingredient': "",
                                                      'description': "",
                                                      'ingredient_price': "",
                                                      'price':
                                                          mydata['item_price']
                                                    });
                                                    break;
                                                  } else if (j ==
                                                      selectedMenuCard.length -
                                                          1) {
                                                    selectedMenuCard.add({
                                                      'key': mydata['key'],
                                                      'data': [
                                                        {
                                                          'image': mydata[
                                                              'image_path'],
                                                          'name': mydata[
                                                              'item_name'],
                                                          'ingredient': "",
                                                          'description': "",
                                                          'price': mydata[
                                                              'item_price']
                                                        }
                                                      ]
                                                    });
                                                    break;
                                                  }
                                                }
                                              }
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0, horizontal: 10),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.30,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                      color: primaryColor,
                                                      border: Border.all(),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: CachedNetworkImage(
                                                        imageUrl: mydata['image_path']
                                                                        .toString() ==
                                                                    "null" ||
                                                                mydata['image_path']
                                                                        .isEmpty ==
                                                                    true
                                                            ? "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/defaultImage%2Ffood.jpg?alt=media&token=5d34f868-8500-4062-a6f9-2e223ea7eb2f"
                                                            : mydata[
                                                                'image_path'],
                                                        placeholder: (context,
                                                                s) =>
                                                            Loader(
                                                                Colors.white, 2,
                                                                size: 15),
                                                      ),
                                                    )),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 15.0),
                                                  child: SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.60,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          mydata['item_name'],
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 14),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          mydata['item_price'] +
                                                              " Ks",
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 12),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    })
                            ],
                          ))
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
          ),
          if (selectedMenuCard.isNotEmpty)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 120,
                color: primaryColor,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, i) {
                            selectedMenuCard.sort((a, b) => a['data'][0]['name']
                                .compareTo(b['data'][0]['name']));
                            return Stack(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 7.0),
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          List newData =
                                              selectedMenuCard[i]['data'];
                                          await showModalBottomSheet(
                                                  context: context,
                                                  builder: (context) {
                                                    return StatefulBuilder(
                                                        builder: (context,
                                                            setState) {
                                                      List data = newData;
                                                      return SizedBox(
                                                          height: 400,
                                                          width: 300,
                                                          child: Column(
                                                            children: [
                                                              const SizedBox(
                                                                  height: 35,
                                                                  child: Center(
                                                                      child: Text("Edit Selected Menu"))),
                                                              Expanded(
                                                                child: data
                                                                        .isEmpty
                                                                    ? Container()
                                                                    : ListView.separated(
                                                                        physics: const BouncingScrollPhysics(),
                                                                        itemBuilder: (context, j) {
                                                                          return SizedBox(
                                                                            width:
                                                                                200,
                                                                            height:
                                                                                60,
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                const SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                Container(
                                                                                  width: 60,
                                                                                  height: 60,
                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(), image: DecorationImage(image: NetworkImage(data[j]['image'].toString() == "null" || data[j]['image'].isEmpty == true ? "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/defaultImage%2Ffood.jpg?alt=media&token=5d34f868-8500-4062-a6f9-2e223ea7eb2f" : data[j]['image']), fit: BoxFit.cover)),
                                                                                ),
                                                                                Expanded(
                                                                                  child: SizedBox(
                                                                                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                                      Row(
                                                                                        children: [
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.only(left: 10.0, right: 10),
                                                                                            child: SizedBox(
                                                                                                width: 100,
                                                                                                child: Text(
                                                                                                  data[j]['name'],
                                                                                                  maxLines: 1,
                                                                                                  overflow: TextOverflow.ellipsis,
                                                                                                )),
                                                                                          ),
                                                                                          const Text(" | "),
                                                                                          Expanded(
                                                                                            child: SizedBox(
                                                                                                child: Text(
                                                                                              data[j]['ingredient'].isEmpty ? "No Ingredient" : data[j]['ingredient'],
                                                                                              maxLines: 1,
                                                                                              overflow: TextOverflow.ellipsis,
                                                                                            )),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      Row(
                                                                                        children: [
                                                                                          Padding(
                                                                                            padding: const EdgeInsets.only(left: 10.0, right: 10),
                                                                                            child: SizedBox(
                                                                                                width: 100,
                                                                                                child: Text(
                                                                                                  data[j]['price'] + " Ks",
                                                                                                  maxLines: 1,
                                                                                                  overflow: TextOverflow.ellipsis,
                                                                                                )),
                                                                                          ),
                                                                                          const Text(" | "),
                                                                                          Expanded(
                                                                                            child: SizedBox(
                                                                                                child: Text(
                                                                                              data[j]['description'].isEmpty ? "No Description" : data[j]['description'],
                                                                                              maxLines: 1,
                                                                                              overflow: TextOverflow.ellipsis,
                                                                                            )),
                                                                                          )
                                                                                        ],
                                                                                      )
                                                                                    ]),
                                                                                  ),
                                                                                ),
                                                                                PopupMenuButton<int>(
                                                                                  itemBuilder: (context) => [
                                                                                    PopupMenuItem(
                                                                                      value: 1,
                                                                                      child: Row(
                                                                                        children: const [
                                                                                          Icon(Icons.edit),
                                                                                          SizedBox(
                                                                                            width: 10,
                                                                                          ),
                                                                                          Text("Edit")
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    PopupMenuItem(
                                                                                      value: 2,
                                                                                      child: Row(
                                                                                        children: const [
                                                                                          Icon(Icons.delete),
                                                                                          SizedBox(
                                                                                            width: 10,
                                                                                          ),
                                                                                          Text("Delete")
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                  color: Colors.grey,
                                                                                  elevation: 2,
                                                                                  onSelected: (value) {
                                                                                    if (value == 1) {
                                                                                      _ingredient.text = data[j]['ingredient'];
                                                                                      _description.text = data[j]['description'];
                                                                                      showDialog(
                                                                                          context: context,
                                                                                          barrierDismissible: false,
                                                                                          builder: (context) => AlertDialog(
                                                                                                  title: const Text(
                                                                                                    "Update",
                                                                                                    style: TextStyle(fontSize: 12),
                                                                                                  ),
                                                                                                  content: SizedBox(
                                                                                                    height: 200,
                                                                                                    child: Column(
                                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                      children: [
                                                                                                        labelText("Add Ingredient", padding: 10),
                                                                                                        InkWell(
                                                                                                          onTap: () async {
                                                                                                            List data = await dropDownBottomModal(context, false, [], que, dropListItemName: "ingredient_name", dropListItemName2: "ingredient_price");
                                                                                                            log(data.toString());
                                                                                                            setState(() {
                                                                                                              if (data.isEmpty) {
                                                                                                                _ingredient.text = _ingredient.text;
                                                                                                                ingredientPrice = ingredientPrice;
                                                                                                              } else {
                                                                                                                _ingredient.text = data[0][0];
                                                                                                                ingredientPrice = int.parse(data[0][1]);
                                                                                                              }
                                                                                                            });
                                                                                                          },
                                                                                                          child: AbsorbPointer(
                                                                                                            child: textField("Add Ingredient", double.infinity, _ingredient, TextInputType.name, ""),
                                                                                                          ),
                                                                                                        ),
                                                                                                        labelText("Description", padding: 10),
                                                                                                        textField("Description", double.infinity, _description, TextInputType.name, "")
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                  actions: [
                                                                                                    TextButton(
                                                                                                      onPressed: () {
                                                                                                        _ingredient.text = "";
                                                                                                        _description.text = "";
                                                                                                        Navigator.pop(context);
                                                                                                      },
                                                                                                      child: const Text(
                                                                                                        "Cancel",
                                                                                                        style: TextStyle(color: Colors.red),
                                                                                                      ),
                                                                                                    ),
                                                                                                    TextButton(
                                                                                                      onPressed: () async {
                                                                                                        setState(() {
                                                                                                          data[j]['ingredient'] = _ingredient.text;
                                                                                                          data[j]['price'] = (int.parse(data[j]['price']) + ingredientPrice).toString();
                                                                                                          data[j]['description'] = _description.text;
                                                                                                        });
                                                                                                        _ingredient.text = "";
                                                                                                        ingredientPrice = 0;
                                                                                                        _description.text = "";
                                                                                                        Navigator.pop(context);
                                                                                                        toastMessage("Update Successful", txtColor: Colors.green);
                                                                                                      },
                                                                                                      child: const Text(
                                                                                                        "Update",
                                                                                                        style: TextStyle(color: Colors.green),
                                                                                                      ),
                                                                                                    )
                                                                                                  ]));
                                                                                    } else {
                                                                                      setState(() {
                                                                                        Future(() {
                                                                                          if (j <= 0 && data.length == 1) {
                                                                                            Navigator.pop(context);
                                                                                          }
                                                                                        }).then((value) {
                                                                                          if (j <= 0 && data.length == 1) {
                                                                                            data = [];
                                                                                            selectedMenuCard[i] = [];
                                                                                            selectedMenuCard.removeAt(i);
                                                                                          } else {
                                                                                            data.removeAt(j);
                                                                                          }
                                                                                        });
                                                                                      });
                                                                                    }
                                                                                  },
                                                                                ),
                                                                                const SizedBox(
                                                                                  width: 10,
                                                                                )
                                                                              ],
                                                                            ),
                                                                          );
                                                                        },
                                                                        separatorBuilder: (context, index) {
                                                                          return const SizedBox(
                                                                            height:
                                                                                10,
                                                                          );
                                                                        },
                                                                        itemCount: data.length),
                                                              ),
                                                              SizedBox(
                                                                  height: 40,
                                                                  child: Align(
                                                                      alignment:
                                                                          Alignment
                                                                              .centerRight,
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsets.only(
                                                                            right:
                                                                                20.0,
                                                                            bottom:
                                                                                5),
                                                                        child: ElevatedButton(
                                                                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(primaryColor)),
                                                                            onPressed: () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child: const Text("OK")),
                                                                      ))),
                                                            ],
                                                          ));
                                                    });
                                                  })
                                              .then((value) => setState(() {}));
                                        },
                                        child: Container(
                                          width: 70,
                                          height: 70,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              image: DecorationImage(
                                                  image: selectedMenuCard[i]['data'][0]
                                                                      ['image']
                                                                  .toString() ==
                                                              "null" ||
                                                          selectedMenuCard[i]['data'][0]
                                                                      ['image']
                                                                  .isEmpty ==
                                                              true
                                                      ? const NetworkImage(
                                                          "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/defaultImage%2Ffood.jpg?alt=media&token=5d34f868-8500-4062-a6f9-2e223ea7eb2f")
                                                      : NetworkImage(
                                                          selectedMenuCard[i]
                                                              ['data'][0]['image']),
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                      SizedBox(
                                          width: 70,
                                          child: Text(
                                            selectedMenuCard[i]['data'][0]
                                                ['name'],
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 8,
                                                color: Colors.white),
                                          ))
                                    ],
                                  ),
                                ),
                                Positioned(
                                    top: 8,
                                    right: 1,
                                    child: CircleAvatar(
                                      radius: 10.5,
                                      backgroundColor: Colors.black,
                                      child: CircleAvatar(
                                          radius: 10,
                                          backgroundColor: Colors.white,
                                          child: Center(
                                              child: Text(
                                                  selectedMenuCard[i]['data']
                                                      .length
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 10)))),
                                    ))
                              ],
                            );
                          },
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          separatorBuilder: (context, i) {
                            return const SizedBox(
                              width: 10,
                            );
                          },
                          itemCount: selectedMenuCard.length),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white)),
                          onPressed: () {
                            setState(() {
                              SelectedMenuList.selectedMenuCard =
                                  selectedMenuCard;
                            });
                            Navigator.pop(context);
                          },
                          child: const Center(
                              child: Icon(
                            Icons.add,
                            size: 30,
                            color: Colors.black,
                          ))),
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
              ),
            )
        ],
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
