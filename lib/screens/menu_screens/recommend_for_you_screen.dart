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
          "item_name" : "ရခိုင်မုန့်တီ"
        },
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675881735726%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER6480776676285193701.JPG?alt=media&token=85373be2-46b3-4946-9858-cac70d77b2fc",
          "item_name" : "အာရီယန်ခေါက်ဆွဲ (ရွှေတောင်)"
        },
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675880904784%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER8898446576298592001.JPG?alt=media&token=69535c64-f391-4360-a516-ec9d50296770",
          "item_name" : "လက်ဖက်ရည်"
        },
        {
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675883690998%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER4583947381730164383.JPG?alt=media&token=ff6de3ef-71f5-4d50-9347-43032321bd3c",
          "item_name" : "ထမင်းကြော်"
        },
        {
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1676149085355%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER6591982184294467675.JPG?alt=media&token=5244cbcc-db8c-499b-8218-27e7d5a73367",
          "item_name" : "Premier Coffee"
        },
        {
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675879907715%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER7196771598055766499.PNG?alt=media&token=295b7b99-f1cb-44b2-9880-ad32fa478d06",
          "item_name" : "Nescafe(p)"
        },
        
      ],
    },
    {
      "launch": [
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675880831295%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER3412037625059847258.JPG?alt=media&token=3371e296-96fc-48e0-88fa-0ea3c1946030",
          "item_name" : "ရခိုင်မုန့်တီ"
        },
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675881735726%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER6480776676285193701.JPG?alt=media&token=85373be2-46b3-4946-9858-cac70d77b2fc",
          "item_name" : "အာရီယန်ခေါက်ဆွဲ (ရွှေတောင်)"
        },
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675880904784%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER8898446576298592001.JPG?alt=media&token=69535c64-f391-4360-a516-ec9d50296770",
          "item_name" : "လက်ဖက်ရည်"
        },
        {
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675883690998%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER4583947381730164383.JPG?alt=media&token=ff6de3ef-71f5-4d50-9347-43032321bd3c",
          "item_name" : "ထမင်းကြော်"
        },
        {
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1676149085355%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER6591982184294467675.JPG?alt=media&token=5244cbcc-db8c-499b-8218-27e7d5a73367",
          "item_name" : "Premier Coffee"
        },
        {
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675879907715%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER7196771598055766499.PNG?alt=media&token=295b7b99-f1cb-44b2-9880-ad32fa478d06",
          "item_name" : "Nescafe(p)"
        },
      ],
    },
    {
      "dinner": [
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675873017937%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER318459958928518020.JPG?alt=media&token=9200b5fc-2961-4e1f-903c-3607c7670372",
          "item_name" : "Red Label ( 1L )"
        },
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675873418330%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER3829383680603784427.JPG?alt=media&token=fae1f322-f960-4e4d-a29d-fa281a00be8f",
          "item_name" : "Jagermeister ( P )"
        },
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1676145022099%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER5679082280935659416.JPG?alt=media&token=c5c8b28f-f6e9-4aa9-8821-fb47f7bbc8b6",
          "item_name" : "Grand Royal(smooth)"
        },
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1676146288820%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER2930381614569340031.JPG?alt=media&token=bc6ded99-ee6a-4c74-ad6f-0c5a324d3df1",
          "item_name" : "Grand Royal Whisky"
        },
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675871804905%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER5894467080858075063.JPG?alt=media&token=2f578817-7594-461c-a0ce-5f77733aa45f",
          "item_name" : "ABC(Tin)"
        },
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675872070241%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER1208689707462152568.JPG?alt=media&token=fe9de5f2-1225-41ac-b7e3-84ac5b0124db",
          "item_name" : "Tiger(Beer)"
        },
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675873916061%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER1151143295999714588.JPG?alt=media&token=17ca7ad5-d25a-4b8b-98a2-ec7f7af70bc9",
          "item_name" : "Tiger (Cup)"
        },
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675874392511%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER6872973518574714978.JPG?alt=media&token=81f4e025-1064-4f34-8d81-89a59363c436",
          "item_name" : "Tiger ( J )"
        },
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1676139579967%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER3205274094485800465.JPG?alt=media&token=dbd050a8-e4b3-45b3-af50-3c7564637c6b",
          "item_name" : "Myanmar Beer"
        },
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675878061218%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER5316047934631996616.JPG?alt=media&token=b61e880b-5f71-4c37-8ca1-9e227b5c3c19",
          "item_name" : "ကြက်ဥမွေကြော်"
        },
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675872783617%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER1021339597705083271.JPG?alt=media&token=7bd75127-2a15-47ec-a563-476165cc291e",
          "item_name" : "Mevius Original"  
        },
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1676147472350%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER2821199878589114610.JPG?alt=media&token=8e9ab4b1-5fd4-4d65-9856-b3e22772ac44",
          "item_name" : "Red Ruby"  
        },
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1676143865978%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER351990988368533296.JPG?alt=media&token=5ec570e9-cfd9-4a89-b45c-8425c14bd25b",
          "item_name" : "ရေခဲပွဲ"  
        },
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1676143865978%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER351990988368533296.JPG?alt=media&token=5ec570e9-cfd9-4a89-b45c-8425c14bd25b",
          "item_name" : "ရေသန့်"  
        },
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675876438569%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER540499645581626193.JPG?alt=media&token=bedff76c-3b61-4608-8069-59294c38a9c3",
          "item_name" : "ကန်းစွန်းပလိန်း"  
        },
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675876542676%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER4461815562080840494.JPG?alt=media&token=f42ce253-7590-486d-ba73-94bcbbe8ea2b",
          "item_name" : "ကြက်ချိုချဥ်"  
        },
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1675877915446%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER2525856580509790187.JPG?alt=media&token=241c7e94-74aa-47d6-813d-46981f12c52e",
          "item_name" : "ကြက်သားပြားကြော်"  
        },
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1676144257791%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER3596824469084825658.JPG?alt=media&token=a238efde-de94-40db-9844-2ab26844870f",
          "item_name" : "အာလူးချောင်းကြော်"  
        },
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1676144548919%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER2394329676456894146.JPG?alt=media&token=4c01c275-a68f-4a6e-8a87-c93bd6063ade",
          "item_name" : "သုံးမျိုးသုပ်"  
        },
        { 
          "image_path" : "https://firebasestorage.googleapis.com/v0/b/r-pos-2c355.appspot.com/o/images%2F1676144398929%2FDATA%2FUSER%2F0%2FCOM.EXAMPLE.R_POS%2FCACHE%2FIMAGE_PICKER2017136817687208917.JPG?alt=media&token=def6c472-c648-4af4-a0d6-aaa0b454379f",
          "item_name" : "ဝက်အစုံသုပ်"  
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
                height: MediaQuery.of(context).size.height * 0.35,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.height * 0.3,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image(image: CachedNetworkImageProvider(
                              rules[0]["morning"][index]["image_path"]
                            ), fit: BoxFit.cover,),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.height * 0.3,
                          child: Text(rules[0]["morning"][index]["item_name"], style: TextStyle(
                            fontSize: 15, 
                            fontWeight: FontWeight.bold
                          ),)
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

              // SizedBox(height: 10,),
              // Text("Launch", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              // SizedBox(height: 10,),
              // SizedBox(
              //   width: MediaQuery.of(context).size.width * 0.9,
              //   height: 100,
              //   child: ListView.separated(
              //     scrollDirection: Axis.horizontal,
              //     itemBuilder: (context, index) {
              //       return Column(
              //         children: [
              //           SizedBox(
              //             height: 60,
              //             width: 60,
              //             child: ClipRRect(
              //               borderRadius: BorderRadius.circular(10),
              //               child: Image(image: AssetImage("assets/images/logo.png")),
              //             ),
              //           ),
              //           Text("Name")
              //         ],
              //       );
              //     }, 
              //     separatorBuilder: (context, index) {
              //       return SizedBox(width: 10,);
              //     }, 
              //     itemCount: rules[1]["launch"].length
              //   ),
              // ),

              SizedBox(height: 10,),
              Text("Dinner", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              SizedBox(height: 10,),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.35,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          width: MediaQuery.of(context).size.height * 0.3,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image(image: CachedNetworkImageProvider(
                              rules[2]["dinner"][index]["image_path"]
                            ), fit: BoxFit.cover,),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                          width: MediaQuery.of(context).size.height * 0.3,
                          child: Text(rules[2]["dinner"][index]["item_name"], style: TextStyle(
                            fontSize: 15, 
                            fontWeight: FontWeight.bold
                          ),)
                        )
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