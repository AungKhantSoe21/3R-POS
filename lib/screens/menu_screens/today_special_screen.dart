
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:r_pos/utils/constant_color.dart';
import 'package:r_pos/widgets/marquee_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TodaySpecialScreen extends StatefulWidget {
  const TodaySpecialScreen({Key? key}) : super(key: key);

  @override
  State<TodaySpecialScreen> createState() => _TodaySpecialScreenState();
}

class _TodaySpecialScreenState extends State<TodaySpecialScreen> {
  final databaseReference = FirebaseDatabase.instance.ref().child("Item");
  int activeIndex = 0;
  List todaySpecialList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    await databaseReference.once().then((event) {
      DataSnapshot snapshot = event.snapshot;
      Map values = snapshot.value as Map;
      values.forEach((k, val) {
        databaseReference.child(k.toString()).once().then((ev) {
          DataSnapshot ss = ev.snapshot;
          Map v = ss.value as Map;
          v.forEach((key, value) {
            // log(value["item_name"].toString());
            if(value["today_special"] != null && value["today_special"] == "True") {
              todaySpecialList.add(value);
            }
          });
        });
      });
    });
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 45.0),
            child: Text(
              "Food",
              style: TextStyle(
                color: primaryColor.withOpacity(0.5),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 45.0),
            child: Row(
              children: [
                Text(
                  "Today Special",
                  style: TextStyle(
                    color: primaryColor.withOpacity(0.7),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 5,),
                Icon(
                  Icons.star,
                  color: Color(0xffFFD700),
                )
              ],
            ),
          ),
          if(isLoading) 
          Expanded(
            child: SizedBox(),
          ),
          if(isLoading)
          Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: primaryColor,
              ),
            ),
          ) ,
          if(isLoading) 
          Expanded(
            child: SizedBox(),
          ),
          if(!isLoading)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: CarouselSlider.builder(
                  itemCount: todaySpecialList.length,
                  itemBuilder: (context, index, anotherIndex) => Container(
                    height: double.infinity,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(image: CachedNetworkImageProvider(
                        todaySpecialList[index]["image_path"]
                      ), fit: BoxFit.cover,),
                    ),
                  ),
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 5),
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.8,
                    viewportFraction: 0.9,
                    onPageChanged: (index, reason) => {
                      setState(() {
                        activeIndex = index;
                      })
                    },
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: buildIndicator(),
          ),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(isLoading ? "Loading..." : todaySpecialList[activeIndex]["item_name"], style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                  Text(isLoading ? "Loading..." : todaySpecialList[activeIndex]["item_price"] + " Ks", style: TextStyle(fontSize: 18, color: Colors.blueGrey, fontWeight: FontWeight.bold),),
                ],
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.1,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Center(
                  child: MarqueeWidget(
                    backDuration: Duration(seconds: 12),
                    animationDuration: Duration(seconds: 12),
                    pauseDuration: Duration(seconds: 1),
                    child: Row(
                      children: [
                        Text(isLoading ? "Loading..." : "TODAY SPECIAL < ", style: TextStyle(
                          color: Color(0xffFFD700),
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                        ),),
                        for(int j = 0; j < todaySpecialList.length; j++)
                        Text(isLoading ? "Loading..." : j == todaySpecialList.length - 1 ? todaySpecialList[j]["item_name"] + " >" : todaySpecialList[j]["item_name"] + ", ", style: TextStyle(
                          color: Color(0xffFFD700),
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                        ),),
                      ],
                    )
                  ),
                )
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: todaySpecialList.length,
      effect: WormEffect(
          dotWidth: 20,
          dotHeight: 5,
          activeDotColor: primaryColor,
          dotColor: Colors.blueGrey
      ),
    );
  }
}
