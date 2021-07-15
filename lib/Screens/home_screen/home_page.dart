import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gebeta_food/Screens/home_screen/list_view.dart';
import 'package:gebeta_food/Screens/home_screen/popular_food.dart';
import 'package:gebeta_food/Screens/home_screen/restaurants_list.dart';
import 'package:gebeta_food/constants.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 6);
  }

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text("choose"),
            automaticallyImplyLeading: false,
            // iconTheme: Theme.of(context).p,
          ),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text("All Products"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/products');
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff9efeb),
      key: _globalKey,
      drawer: _buildSideDrawer(context),
      // drawer: _buildSideDrawer(context),
      // appBar: AppBar(
      //   // leading: IconButton(icon: SvgPicture.asset("assets/icons/menu.svg"),onPressed: (){},),
      // ),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 250,
                decoration: BoxDecoration(color: gPrimaryColor),
              ),
              Container(
                height: 185.0,
                decoration: BoxDecoration(color: gsecondaryColor),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          _globalKey.currentState!.openDrawer();
                          print("clicked");
                        },
                        icon: SvgPicture.asset('assets/icons/menu.svg')),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 3, color: whiteColor),
                          borderRadius: BorderRadius.circular(50.0)),
                      child: CircleAvatar(
                        child: Image.asset("assets/images/profile.png"),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 55.0, left: 15.0),
                child: Text(
                  "Hello there!",
                  style: TextStyle(
                      fontSize: 30.0,
                      color: whiteColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 95.0, left: 15.0),
                child: Text(
                  "Choose Your Favorite!",
                  style: TextStyle(
                      fontSize: 30.0,
                      color: whiteColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 150, left: 15.0, right: 15.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      // contentPadding: EdgeInsets.only(top:14.0),
                      hintText: "search Your favourite food item",
                      hintStyle: TextStyle(color: ksecondaryColor),
                      icon: Icon(
                        Icons.search,
                        color: gPrimaryColor,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          TabBar(
            controller: tabController,
            indicatorColor: gPrimaryColor,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 4.0,
            // indicator: BoxDecoration(
            //     borderRadius: BorderRadius.circular(20), // Creates border
            //     color: gPrimaryColor),
            isScrollable: true,
            labelColor: Colors.black,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelColor: ksecondaryColor,
            unselectedLabelStyle: TextStyle(fontSize: 12),
            tabs: [
              Tab(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "BURGER",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
              Tab(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "PIZZA",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
              Tab(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "DESERT",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
              Tab(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "DRINKS",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
              Tab(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "NOODLES",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ),
              Tab(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "CHICKEN",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: MediaQuery.of(context).size.height - 520,
            child: TabBarView(
              children: <Widget>[
                new PopularFoodListView(),
                new PopularFoodListView(),
                new PopularFoodListView(),
                new PopularFoodListView(),
                new PopularFoodListView(),
                new PopularFoodListView(),
              ],
              controller: tabController,
            ),
          ),
          SizedBox(height: 10.0),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Padding(
          //       padding: EdgeInsets.only(left: 15.0),
          //       child: Text(
          //         "Popular Dishes",
          //         style: TextStyle(
          //             fontFamily: "Montserrat",
          //             fontSize: 17.0,
          //             color: gTextLightColor),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(right: 15.0),
          //       child: TextButton(
          //         child: Text(
          //           "View All",
          //           style: TextStyle(
          //             color: gPrimaryColor,
          //             fontSize: 14,
          //             fontFamily: "Montserrat",
          //           ),
          //         ),
          //         onPressed: () {},
          //       ),
          //     )
          //   ],
          // ),
          // SizedBox(height: 10.0),
          // PopularTodayList(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  "TOP RESTAURANTS",
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 17.0,
                      color: gTextLightColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: TextButton(
                  child: Text(
                    "View All",
                    style: TextStyle(
                      color: gPrimaryColor,
                      fontSize: 14,
                      fontFamily: "Montserrat",
                    ),
                  ),
                  onPressed: () {},
                ),
              )
            ],
          ),
          SizedBox(height: 10.0),
         RestaurantsList(),
          SizedBox(height: 20.0)
        ],
      ),
    );
  }
}
