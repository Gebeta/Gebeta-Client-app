import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gebeta_food/Screens/home_screen/list_view.dart';
import 'package:gebeta_food/Screens/home_screen/pop_foods.dart';
import 'package:gebeta_food/Screens/home_screen/rest.dart';
import 'package:gebeta_food/Screens/user_profile/profile_screen.dart';
import 'package:gebeta_food/constants.dart';
import 'package:gebeta_food/models/profile.dart';
import 'package:gebeta_food/scoped-models/main.dart';
import 'package:scoped_model/scoped_model.dart';

class MyHomePage extends StatefulWidget {
  final MainModel model;
  const MyHomePage({required this.model});

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
    // Map<String, dynamic> response = await widget.model.getProfile(widget.model.getUser.id);
    widget.model.fetchUser();
    tabController = TabController(vsync: this, length: 6);
  }

  Widget _buildSideDrawer(BuildContext context) {
    Profile profile = widget.model.getUserProfile;
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(profile.firstName + " " + profile.lastName),
                accountEmail: Text(profile.email),
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProfileScreen(widget.model, profile)));
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.shopping_cart_outlined,
                      color: gsecondaryColor,
                    ),
                    title: Text("My Cart"),
                    onTap: () {
                      Navigator.pushNamed(context, '/my_cart');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.settings_outlined,
                      color: gsecondaryColor,
                    ),
                    title: Text("Settings"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProfileScreen(widget.model, profile)));
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.history_edu_outlined,
                      color: gsecondaryColor,
                    ),
                    title: Text("Orders"),
                    onTap: () {
                      Navigator.pushNamed(context, '/orders');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.history_edu_outlined,
                      color: gsecondaryColor,
                    ),
                    title: Text("Completed Orders"),
                    onTap: () {
                      Navigator.pushNamed(context, '/completed_orders');
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.history_edu_outlined,
                      color: gsecondaryColor,
                    ),
                    title: Text("Pending Orders"),
                    onTap: () {
                      Navigator.pushNamed(context, '/pending_orders');
                    },
                  ),
                  
                  ListTile(
                    leading: Icon(
                      Icons.restaurant_outlined,
                      color: gsecondaryColor,
                    ),
                    title: Text("List of Restaurants"),
                    onTap: () {
                      Navigator.pushNamed(context, '/restaurants');
                    },
                  ),
                  ScopedModelDescendant(
                      builder: (context, Widget child, MainModel model) {
                    return ListTile(
                      leading: Icon(
                        Icons.logout_outlined,
                        color: gsecondaryColor,
                      ),
                      title: Text("Sign Out"),
                      onTap: () {
                        model.logout();
                        Navigator.pushReplacementNamed(context, '/');
                      },
                    );
                  })
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
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/my_cart');
                    print("clicked");
                  },
                  icon: Icon(Icons.shopping_cart_outlined)),
              widget.model.getCartList.length >= 1
                  ? Text("(${widget.model.getCartList.length})")
                  : Text("")
            ],
          ),
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
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    child: _buildSearchTextField(),
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
          Items(widget.model),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildHeadingTextWidget("TOP RESTAURANTS"),
              _buildViewAllTextWidget("/restaurants")
            ],
          ),
          Restaurants(widget.model),
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
        suffixIcon: Icon(
          Icons.filter_list,
          color: gPrimaryColor,
          size: 25,
        ),
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
