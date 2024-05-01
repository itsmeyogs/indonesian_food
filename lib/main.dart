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

  //membuat variabel untuk menampung pesan snackbar
  var snackBarMessage = "";

  //fungsi yang berguna untuk menambah dan menghapus favorite
  void toggleFavorite(Food item) {
    //mengecek apakah item yang di klik sudah ada di list favorite
    if (favoriteFood.contains(item)) {
      //jika sudah ada, maka akan mengubah pesan snackbar dan menghapus item dari list favorite
      snackBarMessage = "Berhasil menghapus ${item.name} dari favorite";
      _favoritesFood.remove(item);
    } else {
      //jika belum ada, maka akan mengubah pesan snackbar dan menambah item ke list favorite
      snackBarMessage = "Berhasil Menambahkan ${item.name} ke favorite";
      _favoritesFood.add(item);
    }
    //memberitahu widget apabila terjadi perubahan pada data
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //membuat variabel yang digunakan untuk indeks halaman
  var selectedIndex = 0;

  //membuat variabel yang digunakan untuk teks judul di appbar
  var appBarTitle = "";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    //mengatur style pada teks judul di appbar
    final titleAppBarStyle = theme.textTheme.headlineMedium!
        .copyWith(fontWeight: FontWeight.w800, color: Color(0XFF001849));

    //mengecek apakah indeks halaman tidak sama dengan 0 (Home Page)
    if(selectedIndex!=0){
      //jika iya, maka akan menampilkan teks berupa "Favorite Food"
      appBarTitle = "Favorite Food";
    }else{
      //jika tidak, maka akan menampilkan teks berupa "Indonesian Food"
      appBarTitle = "Indonesian Food";
    }

    //menambahkan widget Scaffold untuk membuat kerangka tampilan apps
    return Scaffold(
      //menambahkan Appbar pada tampilan
      appBar: AppBar(
        //mengubah warna appbar menjadi transparan
        backgroundColor: Colors.transparent,
        //mengatur elevation menjadi 0
        elevation: 0.0,
        //memaksa agar appbar menjadi transparan
        forceMaterialTransparency: true,
        //mengatur style dari Ui hp
        systemOverlayStyle: SystemUiOverlayStyle(
          //mengubah warna statusbar menjadi transparan
            statusBarColor: Colors.transparent,
            //mengubah kecerahan icon pada statusbar menjadi gelap
            statusBarIconBrightness: Brightness.dark),
        //Widget teks digunakan pada parameter title AppBar untuk menampilkan judul
        title: Text(appBarTitle, style: titleAppBarStyle),
      ),
      //menambahkan widget kontainer
      bottomNavigationBar: Container(
        //menambahkan decoration berupa BoxDecoration
        decoration: BoxDecoration(
          //menambahkan Border atas sebesar 0.1 pada navbar, sebagai garis pemisah navbar dan konten
            border: Border(
                top: (BorderSide(color: Color(0XFF001849), width: 0.1)))),
        //menambahkan widget NavigationBar
        child: NavigationBar(
          //mengatur tinggi navbar
          height: 70.0,
          //mengatur warna navbar dengan Colors.transparent
          backgroundColor: Colors.transparent,
          //mengatur elevation navbar = 0
          elevation: 0.0,
          //mengatur state ketika navbar digunakan
          onDestinationSelected: (index) {
            setState(() {
              //mengubah nilai index halaman sesuai dengan yang sedang dibuka
              selectedIndex = index;
            });
          },
          //mengubah warna indicator item yang dipilih di navbar
          indicatorColor: Color(0XFFBFC2FF),
          //mengatur indeks halaman saat ini
          selectedIndex: selectedIndex,
          //menambahkan item destinasi navbar
          destinations: const <Widget>[
            //item navigasi untuk halaman home
            NavigationDestination(
              icon: Icon(Icons.home_outlined, color: Color(0XFF001849)),
              selectedIcon: Icon(Icons.home, color: Color(0XFF001849)),
              label: "Home",
            ),
            //item navigasi untuk halaman favorite
            NavigationDestination(
                icon: Icon(Icons.favorite_outline, color: Color(0XFF001849)),
                selectedIcon: Icon(Icons.favorite, color: Color(0XFF001849)),
                label: "Favorite")
          ],
        ),
      ),
      //menampilkan isi konten sesuai dengan index halaman (indeks 0 = HomePage, indeks 1 = FavoritePage)
      body: <Widget>[HomePage(), FavoritePage()][selectedIndex],
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //mengambil data list food dan listen setiap perubahan pada state
    final dataFood = context.watch<MyAppState>().dataFood;
    //menambahkan widget listview untuk menampilkan data lebih dari satu secara vertikal
    return ListView.builder(
      //menentukan jumlah data yang akan ditampilkan
        itemCount: dataFood.length,
        itemBuilder: (context, index) {
          final food = dataFood[index];
          //menambahkan padding agar item yang ditampilkan tidak mepet dengan
          return Padding(
            padding: const EdgeInsets.only(bottom: 4, left: 8, right: 8),
            //memanggil class FoodItem untuk menampilkan item
            child: FoodItem(food: food),
          );
        });
  }
}

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.normal);
    //mengambil data list favorite food dan listen setiap perubahan pada state
    final dataFavFood = context.watch<MyAppState>().favoriteFood;
    //mengecek apakah data list favorite kosong atau tidak
    if(context.watch<MyAppState>().favoriteFood.isEmpty){
      //jika iya maka akan meanmpilkan teks berupa "No Favorites yet"
      return Center(child: Text("No favorites yet", style: textStyle));
    }
    //menambahkan widget listview untuk menampilkan data lebih dari satu secara vertikal

    return ListView.builder(
      //menentukan jumlah data yang akan ditampilkan
        itemCount: dataFavFood.length,
        itemBuilder: (context, index) {
          final food = dataFavFood[index];
          //menambahkan padding agar item yang ditampilkan tidak mepet dengan
          return Padding(
            padding: const EdgeInsets.only(bottom: 4, left: 8, right: 8),
            //memanggil class FoodItem untuk menampilkan item
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
    //mengatur style widget text nama item yang ada di card
    final textStyle = theme.textTheme.titleLarge!.copyWith(
        fontSize: 23, fontWeight: FontWeight.w800, color: Color(0XFF001849));
    IconData icon;
    //inisiasi appstate untuk listen setiap perubahan yang terjadi
    final appState = context.watch<MyAppState>();

    //mengecek apakah item sudah ada di list favorite
    if (appState.favoriteFood.contains(food)) {
      //jika ada maka icon favorite yang akan ditampilkan berupa favorite
      icon = Icons.favorite;
    } else {
      //jika tidak maka icon favorite yang akan ditampilan berupa favorite border
      icon = Icons.favorite_border;
    }

    //menambahkan widget card untuk membuat sebuah card
    return Card(
      //mengatur warna background card
      color: Color(0XFFE0E0FF),
      //membuat lengkungan(corner radius) pada card
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      //mengatur elevation card = 0
      elevation: 0.0,
      //menambahkan widget InkWell agar item dapat di klik
      child: InkWell(
        onTap: () {
          //menambahkan navigator dengan MaterialPageRoute agar ketika item diklik, maka akan berpindah kehalaman detail
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FoodDetailPage(food: food)));
        },
        //menambahkan widget column pada card
        child: Column(
          children: [
            //menambahkan widget ClipRRect untuk memotong gambar dengan lengkungan(corner radius)
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              //menambahkan widget AspectRatio untuk mengatur rasio ukuran gambar
              child: AspectRatio(
                //mengatur rasio sebesar 2.5
                  aspectRatio: 2.5,
                  //menambahkan widget Image.network untuk menampilkan gambar dari internet
                  child: Image.network(
                    food.image,
                    //mengatur skala gambar agar menutupi semua container
                    fit: BoxFit.cover,
                  )),
            ),
            //menambahkan widget row pada card untuk penempatan nama item dan iconbutton favorite
            Row(
              //mengatur alignment menjadi spacebetween row agar mendistribusikan ruang secara merata
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //menambahkan widget padding untuk agar nama item tidak terlalu mepet dengan pinggir card
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  //menambahkan widget teks untuk menampilkan nama item
                  child: Text(food.name, style: textStyle),
                ),
                //menambahkan widget iconButton untuk menampilkan tombol favorite
                IconButton(
                    onPressed: () {
                      //menjalankan fungsi togglefavorite pada state ketika tombol diklik
                      //menggunakan read,dikarenakan tidak perlu untuk listen perubahan yang terjadi pada state
                      context.read<MyAppState>().toggleFavorite(food);
                      //menambahkan widget Snackbar untuk menampilkan pesan perubahan pada ketika tombol favorite di klik
                      final snackBar = SnackBar(
                        content: Text(appState.snackBarMessage),
                        //mengatur durasi tampilnya snackbar sebesar 500ms (0.5 detik)
                        duration: Duration(milliseconds:500 ),
                      );
                      //menampillkan snackbar pada apps
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    //menambahkan widget icon untuk favorite
                    icon: Icon(icon),
                    //mengatur warna icon favorite
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
    //mengatur style text judul pada AppBar
    final titleAppBarStyle = theme.textTheme.headlineSmall!
        .copyWith(fontWeight: FontWeight.w600, color: Color(0XFF001849));
    //mengatur style text nama item pada konten
    final titleFoodStyle = theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600, color: Color(0XFF001849));
    //mengatur style text desc item pada konten
    final bodyFoodStyle = theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.normal);
    //menambahkan widget Scaffold untuk membuat kerangka tampilan apps
    return Scaffold(
      //menambahkan widget AppBar
      appBar: AppBar(
        //mengatur warna background pada AppBar menjadi Colors.transparent
        backgroundColor: Colors.transparent,
        //mengatur elevation appbar = 0
        elevation: 0.0,
        //memaksa agar appbar berwarna transparan
        forceMaterialTransparency: true,
        //mengatur style ui handphone
        systemOverlayStyle: SystemUiOverlayStyle(
          //mengubah warna statusbar menjadi transparent
            statusBarColor: Colors.transparent,
            //mengubah kecerahan icon menjadi gelap
            statusBarIconBrightness: Brightness.dark
        ),
        //mengatur judul pada appbar agar posisinya ditengah
        centerTitle: true,
        //mengatur warna foreground pada Appbar
        foregroundColor: Color(0XFF001849),
        //menambahkan widget Text untuk menampilkan judul pada AppBar
        title: Text(
          "Detail Food",
          style: titleAppBarStyle,
        ),
      ),
      //menambahkan widget SingleChildScrollView agar tampilan data di scroll ketika konten melebihi ukuran layar(misalnya ketika landscape)
      body: SingleChildScrollView(
        //menambahkan widget Column
        child: Column(
          children: [
            //menambahkan Widget Aspect rasio untuk mengatur rasio dari gambar
            AspectRatio(
              //mengatur rasio gambar sebesar 1.5
              aspectRatio: 1.5,
              //menambahkan widget Image.network untuk menampilkan gambar dari internet
              child: Image.network(
                  food.image,
                  //mengatur skala gambar agar menutupi semua container
                  fit: BoxFit.cover),
            ),
            //menambahkan widget padding untuk mengatur agar teks nama item tidak terlalu mepet
            Padding(
              padding: const EdgeInsets.all(10.0),
              //menambahkan widget Text untuk menampilkan nama item dengan teks rata tengah
              child: Text(food.name, style: titleFoodStyle, textAlign: TextAlign.center,),
            ),
            //menambahkan widget Padding untuk mengatur agar teks desc item tidak terlalu mepet
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 14),
              //menambahkan widget teks untuk menampilkan desc item
              child: Text(
                food.desc,
                //mengatur teks agar sama rata
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
