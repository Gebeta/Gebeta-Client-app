import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gebeta_food/Screens/home_screen/list_view.dart';
import 'package:gebeta_food/Screens/home_screen/popular_food.dart';
// import 'package:gebeta_food/Screens/home_screen/popular_food.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 6);
  }

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("Client Name"),
                accountEmail: Text("Client Email"),
                currentAccountPicture: CircleAvatar(
                    backgroundColor:
                        Theme.of(context).platform == TargetPlatform.iOS
                            ? Colors.blue
                            : Colors.white,
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 2, color: whiteColor),
                            borderRadius: BorderRadius.circular(50.0)),
                        child: Image.asset("assets/images/profile.png"))),
              ),
              Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.person_outline,
                      color: gsecondaryColor,
                    ),
                    title: Text("Profile"),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/profile');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.shopping_cart_outlined,
                      color: gsecondaryColor,
                    ),
                    title: Text("My Cart"),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/my_cart');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.settings_outlined,
                      color: gsecondaryColor,
                    ),
                    title: Text("Settings"),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/profile');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.history_edu_outlined,
                      color: gsecondaryColor,
                    ),
                    title: Text("Orders"),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/my_orders');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.favorite_border,
                      color: gsecondaryColor,
                    ),
                    title: Text("Favorites"),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/my_favorites');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.restaurant_outlined,
                      color: gsecondaryColor,
                    ),
                    title: Text("View All Restaurants"),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/restaurants');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.logout_outlined,
                      color: gsecondaryColor,
                    ),
                    title: Text("Sign Out"),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                  ),
                ],
              )
            ],
          ),
          Column(
            children: [
              Divider(),
              Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.share_outlined,
                      color: gsecondaryColor,
                    ),
                    title: Text("Tell a Friend"),
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, '/'); // undefined route
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.help_outline_rounded,
                      color: gsecondaryColor,
                    ),
                    title: Text("Help and Feedback"),
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, '/'); // undefined route
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            _globalKey.currentState!.openDrawer();
            print("clicked");
          },
          icon: SvgPicture.asset('assets/icons/menu.svg'),
        ),
        title: Text(
          "Gebeta Delivery",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _globalKey.currentState!.openDrawer();
                print("clicked");
              },
              icon: Icon(Icons.shopping_cart_outlined)),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      backgroundColor: Color(0xfff9efeb),
      key: _globalKey,
      drawer: _buildSideDrawer(context),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 190,
                decoration: BoxDecoration(
                  color: gPrimaryColor,
                ),
              ),
              Container(
                height: 135.0,
                decoration: BoxDecoration(color: gsecondaryColor),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  "Hello there!",
                  style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: "Raleway",
                      color: whiteColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 45.0, left: 15.0),
                child: Text(
                  "Grab Your Favorite Meal!",
                  style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: "Raleway",
                      color: whiteColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 105, left: 15.0, right: 15.0),
                child: Form(
                  key: _formKey,
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        child: _buildSearchTextField(),
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.filter))
                    ],
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
            isScrollable: true,
            labelColor: Colors.black,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelColor: ksecondaryColor,
            unselectedLabelStyle: TextStyle(fontSize: 12),
            tabs: [
              Tab(child: _buildTab("BURGER")),
              Tab(child: _buildTab("PIZZA")),
              Tab(child: _buildTab("DESSERT")),
              Tab(child: _buildTab("DRINKS")),
              Tab(child: _buildTab("NOODLES")),
              Tab(
                child: _buildTab("CHICKEN"),
              )
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.33,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHeadingTextWidget("RECOMMENDATiONS"),
              _buildViewAllTextWidget("/foods")
            ],
          ),
          Recommendations(),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHeadingTextWidget("TOP RESTAURANTS"),
              _buildViewAllTextWidget("/restaurants")
            ],
          ),
          RestaurantsList(),
          SizedBox(height: 20.0)
        ],
      ),
    );
  }

  TextFormField _buildSearchTextField() {
    return TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "search Your favourite food item",
        hintStyle: TextStyle(color: ksecondaryColor),
        icon: Icon(
          Icons.search,
          color: gPrimaryColor,
        ),
      ),
    );
  }

  Padding _buildTab(String tabName) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        tabName,
        style: TextStyle(fontSize: 15.0),
      ),
    );
  }

  Padding _buildHeadingTextWidget(String heading) {
    return Padding(
      padding: EdgeInsets.only(left: 15.0),
      child: Text(
        heading,
        style: TextStyle(
            fontFamily: "Montserrat", fontSize: 17.0, color: gTextLightColor),
      ),
    );
  }

  Padding _buildViewAllTextWidget(String route) {
    return Padding(
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
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
      ),
    );
  }
}
