import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:gebeta_food/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FoodDetailPage extends StatefulWidget {
  String foodName;
  String img;
  double price;

  FoodDetailPage(this.foodName, this.img, this.price);

  @override
  _FoodDetailPageState createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                child: Carousel(
                  dotIncreasedColor: Color(0xFFFF335C),
                  dotBgColor: Colors.black.withOpacity(0.1),
                  showIndicator: true,
                  animationCurve: Curves.fastOutSlowIn,
                  indicatorBgPadding: 10.0,
                  dotSize: 4.0,
                  autoplay: false,
                  boxFit: BoxFit.cover,
                  images: [
                    ExactAssetImage("assets/images/burger.png"),
                    ExactAssetImage("assets/images/burger2.png"),
                    ExactAssetImage("assets/images/burger.png"),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 25.0, left: 5.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                        onPressed: () {
                           Navigator.pop(context);
                        },
                        color: whiteColor,
                        icon: Icon(Icons.arrow_back_ios)),
                    IconButton(
                        onPressed: () {},
                        color: whiteColor,
                        icon: Icon(Icons.favorite_border))
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              decoration: ShapeDecoration(
                  color: Color(0xfff9efeb),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ))),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, left: 15),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on,
                              color: gTextLightColor,
                              size: 18,
                            ),
                            Text(
                              "Restaurant Name",
                              style: TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: "Montserrat",
                                  color: gTextLightColor,
                                  fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            RatingBarIndicator(
                              rating: 3.5,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: gPrimaryColor,
                              ),
                              itemCount: 5,
                              itemSize: 14.0,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 15.0, top: 10, left: 15, bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.foodName,
                              style: TextStyle(
                                  color: Color(0xFF563734),
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0),
                            ),
                            Text(
                              widget.price.toString() + " ETB",
                              style: TextStyle(
                                  color: gsecondaryColor,
                                  fontFamily: 'Montserrat',
                                  fontSize: 25.0),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("About",
                                style: TextStyle(
                                    color: gTextColor,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.0)),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut non quam quis risus semper viverra. Aenean bibendum a erat non condimentum. Phasellus ut lorem ac tellus tempor lacinia.",
                              style: TextStyle(
                                  color: gTextLightColor,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w200,
                                  fontSize: 17.0),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (count > 1) {
                                    count--;
                                  }
                                });
                              },
                              icon: Icon(Icons.remove_circle),
                              color: gsecondaryColor,
                              iconSize: 27,
                            ),
                            Text(count.toString(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "Montserrat",
                                )),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  count++;
                                });
                              },
                              icon: Icon(Icons.add_circle),
                              color: gsecondaryColor,
                              iconSize: 27,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.only(bottom: 15.0, right: 15.0, left: 15.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                          "Add (${count.toString()}) to Cart - ${count * widget.price}"),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(gPrimaryColor),
                        padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 20)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
