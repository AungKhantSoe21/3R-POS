import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RecommendForYou extends StatefulWidget {
  const RecommendForYou({Key? key}) : super(key: key);

  @override
  State<RecommendForYou> createState() => _RecommendForYouState();
}

class _RecommendForYouState extends State<RecommendForYou> {

  List rules = [
    {
      "morning": [
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675880831295%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER3412037625059847258.JPG?alt=media&token=3371e296-96fc-48e0-88fa-0ea3c1946030",
          "item_name" : "ရခိုင်မုန့်တီ",
          "item_price" : "1200",
          "item_status" : "Available"
        },
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675881735726%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER6480776676285193701.JPG?alt=media&token=85373be2-46b3-4946-9858-cac70d77b2fc",
          "item_name" : "အာရီယန်ခေါက်ဆွဲ (ရွှေတောင်)",
          "item_price" : "2500",
          "item_status" : "Available"
        },
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675880904784%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER8898446576298592001.JPG?alt=media&token=69535c64-f391-4360-a516-ec9d50296770",
          "item_name" : "လက်ဖက်ရည်",
          "item_price" : "1300",
          "item_status" : "Available"
        },
        {
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675883690998%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER4583947381730164383.JPG?alt=media&token=ff6de3ef-71f5-4d50-9347-43032321bd3c",
          "item_name" : "ထမင်းကြော်",
          "item_price" : "2000",
          "item_status" : "Available"
        },
        {
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1676149085355%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER6591982184294467675.JPG?alt=media&token=5244cbcc-db8c-499b-8218-27e7d5a73367",
          "item_name" : "Premier Coffee",
          "item_price" : "800",
          "item_status" : "Available"
        },
        {
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675879907715%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER7196771598055766499.PNG?alt=media&token=295b7b99-f1cb-44b2-9880-ad32fa478d06",
          "item_name" : "Nescafe(p)",
          "item_price" : "1300",
          "item_status" : "Available"
        },
        
      ],
    },
    {
      "launch": [
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675880831295%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER3412037625059847258.JPG?alt=media&token=3371e296-96fc-48e0-88fa-0ea3c1946030",
          "item_name" : "ရခိုင်မုန့်တီ",
          "item_price" : "1200",
          "item_status" : "Available"
        },
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675881735726%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER6480776676285193701.JPG?alt=media&token=85373be2-46b3-4946-9858-cac70d77b2fc",
          "item_name" : "အာရီယန်ခေါက်ဆွဲ (ရွှေတောင်)",
          "item_price" : "2500",
          "item_status" : "Available"
        },
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675880904784%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER8898446576298592001.JPG?alt=media&token=69535c64-f391-4360-a516-ec9d50296770",
          "item_name" : "လက်ဖက်ရည်",
          "item_price" : "1300",
          "item_status" : "Available"
        },
        {
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675883690998%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER4583947381730164383.JPG?alt=media&token=ff6de3ef-71f5-4d50-9347-43032321bd3c",
          "item_name" : "ထမင်းကြော်",
          "item_price" : "2000",
          "item_status" : "Available"
        },
        {
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1676149085355%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER6591982184294467675.JPG?alt=media&token=5244cbcc-db8c-499b-8218-27e7d5a73367",
          "item_name" : "Premier Coffee",
          "item_price" : "800",
          "item_status" : "Available"
        },
        {
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675879907715%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER7196771598055766499.PNG?alt=media&token=295b7b99-f1cb-44b2-9880-ad32fa478d06",
          "item_name" : "Nescafe(p)",
          "item_price" : "1300",
          "item_status" : "Available"
        },
      ],
    },
    {
      "dinner": [
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675880831295%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER3412037625059847258.JPG?alt=media&token=3371e296-96fc-48e0-88fa-0ea3c1946030",
          "item_name" : "ရခိုင်မုန့်တီ",
          "item_price" : "1200",
          "item_status" : "Available"
        },
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675881735726%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER6480776676285193701.JPG?alt=media&token=85373be2-46b3-4946-9858-cac70d77b2fc",
          "item_name" : "အာရီယန်ခေါက်ဆွဲ (ရွှေတောင်)",
          "item_price" : "2500",
          "item_status" : "Available"
        },
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675880904784%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER8898446576298592001.JPG?alt=media&token=69535c64-f391-4360-a516-ec9d50296770",
          "item_name" : "လက်ဖက်ရည်",
          "item_price" : "1300",
          "item_status" : "Available"
        },
        {
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675883690998%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER4583947381730164383.JPG?alt=media&token=ff6de3ef-71f5-4d50-9347-43032321bd3c",
          "item_name" : "ထမင်းကြော်",
          "item_price" : "2000",
          "item_status" : "Available"
        },
        {
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1676149085355%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER6591982184294467675.JPG?alt=media&token=5244cbcc-db8c-499b-8218-27e7d5a73367",
          "item_name" : "Premier Coffee",
          "item_price" : "800",
          "item_status" : "Available"
        },
        {
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675879907715%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER7196771598055766499.PNG?alt=media&token=295b7b99-f1cb-44b2-9880-ad32fa478d06",
          "item_name" : "Nescafe(p)",
          "item_price" : "1300",
          "item_status" : "Available"
        },
      ],
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Text("Morning", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image(image: CachedNetworkImageProvider(
                              rules[0]["morning"][index]["image_path"]
                            ), fit: BoxFit.cover,),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          width: 60,
                          child: Text(rules[0]["morning"][index]["item_name"])
                        )
                      ],
                    );
                  }, 
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 10,);
                  }, 
                  itemCount: rules[0]["morning"].length
                ),
              ),

              SizedBox(height: 10,),
              Text("Launch", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image(image: AssetImage("assets/images/logo.png")),
                          ),
                        ),
                        Text("Name")
                      ],
                    );
                  }, 
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 10,);
                  }, 
                  itemCount: rules[1]["launch"].length
                ),
              ),

              SizedBox(height: 10,),
              Text("Dinner", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image(image: AssetImage("assets/images/logo.png")),
                          ),
                        ),
                        Text("Name")
                      ],
                    );
                  }, 
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 10,);
                  }, 
                  itemCount: rules[2]["dinner"].length
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}