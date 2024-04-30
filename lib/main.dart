import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:indonesian_food/food.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  //membuat getter berupa immutable list untuk mengambil data dari foods di file Food.dart
  List<Food> get dataFood => foods;

  //membuat mutable list untuk menyimpan data favorite food
  List<Food> _favoritesFood = <Food>[];

  //membuat getter berupa immutable list untuk mengambil data dari _favoriteFood
  List<Food> get favoriteFood => _favoritesFood;

  var snackBarMessage = "";

  void toggleFavorite(Food item) {
    if (_favoritesFood.contains(item)) {
      snackBarMessage = "Berhasil menghapus ${item.name} dari favorite";
      _favoritesFood.remove(item);
    } else {
      snackBarMessage = "Berhasil Menambahkan ${item.name} ke favorite";
      _favoritesFood.add(item);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  var appBarTitle = "";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleAppBarStyle = theme.textTheme.headlineMedium!
        .copyWith(fontWeight: FontWeight.w800, color: Color(0XFF001849));

    if(selectedIndex!=0){
      appBarTitle = "Favorite Food";
    }else{
      appBarTitle = "Indonesian Food";
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        forceMaterialTransparency: true,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
        title: Text(appBarTitle, style: titleAppBarStyle),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border(
                top: (BorderSide(color: Color(0XFF001849), width: 0.1)))),
        child: NavigationBar(
          height: 70.0,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          onDestinationSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          indicatorColor: Color(0XFFBFC2FF),
          selectedIndex: selectedIndex,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.home_outlined, color: Color(0XFF001849)),
              selectedIcon: Icon(Icons.home, color: Color(0XFF001849)),
              label: "Home",
            ),
            NavigationDestination(
                icon: Icon(Icons.favorite_outline, color: Color(0XFF001849)),
                selectedIcon: Icon(Icons.favorite, color: Color(0XFF001849)),
                label: "Favorite")
          ],
        ),
      ),
      body: <Widget>[HomePage(), FavoritePage()][selectedIndex],
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataFood = context
        .watch<MyAppState>()
        .dataFood;
    return ListView.builder(
        itemCount: dataFood.length,
        itemBuilder: (context, index) {
          final food = dataFood[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 4, left: 8, right: 8),
            child: FoodItem(food: food),
          );
        });
  }
}

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dataFavFood = context
        .watch<MyAppState>()
        .favoriteFood;
    return ListView.builder(
        itemCount: dataFavFood.length,
        itemBuilder: (context, index) {
          final food = dataFavFood[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 4, left: 8, right: 8),
            child: FoodItem(food: food),
          );
        });
  }
}

class FoodItem extends StatelessWidget {
  const FoodItem({super.key, required this.food});

  final Food food;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.titleLarge!.copyWith(
        fontSize: 23, fontWeight: FontWeight.w800, color: Color(0XFF001849));
    IconData icon;
    final appState = context.watch<MyAppState>();
    if (appState.favoriteFood.contains(food)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Card(
      color: Color(0XFFE0E0FF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      elevation: 0.0,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FoodDetailPage(food: food)));
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: AspectRatio(
                  aspectRatio: 2.5,
                  child: Image.network(
                    food.image,
                    fit: BoxFit.cover,
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(food.name, style: textStyle),
                ),
                IconButton(
                    onPressed: () {
                      context.read<MyAppState>().toggleFavorite(food);
                      final snackBar = SnackBar(
                        content: Text(appState.snackBarMessage),
                        duration: Duration(milliseconds:500 ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    icon: Icon(icon),
                    color: Color(0XFF001849)),
              ],
            )
          ],
        ),
      ),
    );
  }
}


class FoodDetailPage extends StatelessWidget {
  const FoodDetailPage({super.key, required this.food});

  final Food food;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleAppBarStyle = theme.textTheme.headlineSmall!
        .copyWith(fontWeight: FontWeight.w600, color: Color(0XFF001849));
    final titleFoodStyle = theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600, color: Color(0XFF001849));
    final bodyFoodStyle = theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.normal);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        forceMaterialTransparency: true,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark
        ),
        centerTitle: true,
        foregroundColor: Color(0XFF001849),
        title: Text(
          "Detail Food",
          style: titleAppBarStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1.5,
              child: Image.network(food.image, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(food.name, style: titleFoodStyle, textAlign: TextAlign.center,),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 14, right: 14),
              child: Text(
                food.desc,
                textAlign: TextAlign.justify,
                style: bodyFoodStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
