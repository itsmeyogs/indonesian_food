//membuat class Food yang berisi id, image, name dan desc
class Food {
  final String image;
  final String name;
  final String desc;

  Food({ required this.image, required this.name, required this.desc,
  });
}

//membuat mutable list data dari class Food
List<Food> foods = [
  Food(
      image: "https://www.unileverfoodsolutions.co.id/dam/global-ufs/mcos/SEA/calcmenu/recipes/ID-recipes/soups/soto-betawi/main-header.jpg",
      name: "Soto Betawi",
      desc: "Soto Betawi adalah makanan khas Betawi yang terbuat dari daging sapi, jeroan, dan sayuran yang direbus dalam kuah santan yang kaya rempah-rempah. Soto Betawi biasanya disajikan dengan emping, bawang goreng, dan sambal."
  ),
  Food(
      image: "https://www.andy-cooks.com/cdn/shop/articles/20230527000540-andy-20cooks-20-20nasi-20goreng.jpg",
      name: "Nasi Goreng",
      desc: "Nasi Goreng adalah makanan khas Indonesia yang terbuat dari nasi yang digoreng dengan berbagai macam bumbu dan topping, seperti daging, telur, sayuran, dan kerupuk. Nasi Goreng adalah makanan yang sangat populer di Indonesia dan dinikmati oleh berbagai kalangan."
  ),
  Food(
      image: "https://d1vbn70lmn1nqe.cloudfront.net/prod/wp-content/uploads/2023/07/14053934/Mudah-Dibuat-di-Rumah-Ini-Resep-Sate-Ayam-Bumbu-Kacang-yang-Lezat-.jpg.webp",
      name: "Sate Ayam",
      desc: "Sate Ayam adalah makanan khas Indonesia yang terbuat dari daging ayam yang ditusuk dengan tusuk sate dan dibakar. Sate Ayam biasanya disajikan dengan saus kacang dan sambal. Sate Ayam adalah makanan yang sangat populer di Indonesia dan dinikmati oleh berbagai kalangan."
  ),
  Food(
      image: "https://asset.kompas.com/crops/4aqOaU_1HDJzJZDlhtm1mFQFmSM=/0x0:698x465/750x500/data/photo/2021/01/08/5ff86f55cf2e4.jpg",
      name: "Bakso",
      desc: "Bakso adalah makanan khas Indonesia yang terbuat dari daging sapi giling yang dicampur dengan tepung tapioka. Bakso biasanya disajikan dalam kuah kaldu sapi yang panas dan diberi tambahan mie, bihun, dan sayuran. Bakso adalah makanan yang sangat populer di Indonesia dan dinikmati oleh berbagai kalangan."
  ),
  Food(
      image: "https://www.astronauts.id/blog/wp-content/uploads/2023/03/Resep-Rendang-Daging-Sapi-Untuk-Lebaran-Gurih-dan-Nikmat-1200x800.jpg",
      name: "Rendang",
      desc: "Rendang adalah makanan khas Indonesia yang terbuat dari daging sapi yang dimasak dengan bumbu rempah-rempah selama berjam-jam. Rendang memiliki cita rasa yang gurih dan pedas. Rendang adalah makanan khas Indonesia yang telah diakui oleh UNESCO sebagai salah satu warisan budaya kuliner dunia."
  ),
  Food(
      image: "https://asset.kompas.com/crops/lU3xDz9UDCYg9qWpqGqyuTTq5CQ=/23x0:868x563/750x500/data/photo/2022/07/12/62ccebf61f9ce.jpeg",
      name: "Gudeg",
      desc: "Gudeg adalah makanan khas Yogyakarta yang terbuat dari nangka muda yang dimasak dengan santan dan gula merah. Gudeg biasanya disajikan dengan nasi, telur, dan ayam goreng. Gudeg adalah makanan khas Yogyakarta yang telah diakui oleh UNESCO sebagai salah satu warisan budaya kuliner dunia."
  ),
  Food(
      image: "https://static.promediateknologi.id/crop/0x0:0x0/0x0/webp/photo/indizone/2022/07/11/M7skmmN/5-resep-asli-rawon-daging-sapi-khas-surabaya-dijamin-enak43.jpg",
      name: "Rawon",
      desc: "Rawon adalah makanan khas Jawa Timur yang terbuat dari daging sapi yang dimasak dengan kuah hitam yang kaya rempah-rempah. Rawon biasanya disajikan dengan nasi, tauge, dan emping. Rawon adalah makanan khas Jawa Timur yang telah diakui oleh UNESCO sebagai salah satu warisan budaya kuliner dunia."
  ),
  Food(
      image: "https://cdn.idntimes.com/content-images/community/2022/07/img-20220712-125407-5e7f09505567688e0cb6154ede497009-b302ddcf20699d0e20166d0600ab1125_600x400.jpg",
      name: "Sop Buntut",
      desc: "Sop Buntut adalah makanan khas Indonesia yang terbuat dari buntut sapi yang dimasak dalam kuah kaldu yang kaya rempah-rempah. Sop Buntut biasanya disajikan dengan nasi, kentang, dan wortel. Sop Buntut adalah makanan yang sangat populer di Indonesia dan dinikmati oleh berbagai kalangan."
  ),
  Food(
      image: "https://img.okezone.com/content/2017/02/10/298/1615399/food-story-menelusuri-sejarah-pecel-lele-dan-mitos-dibaliknya-sBC3HjxKHr.jpg",
      name: "Pecel Lele",
      desc: "Pecel Lele adalah makanan khas Indonesia yang terbuat dari ikan lele yang digoreng dan disajikan dengan sambal pecel, lalapan, dan nasi. Pecel Lele adalah makanan yang sangat populer di Indonesia dan dinikmati oleh berbagai kalangan."
  ),
  Food(
      image: "https://asset.kompas.com/crops/J0ARoySS4ZFviSelgHTMsxHPNv0=/0x0:1000x667/750x500/data/photo/2020/12/17/5fdb3cd0c1525.jpg",
      name: "Ikan Bakar",
      desc: "Ikan Bakar adalah makanan khas Indonesia yang terbuat dari ikan yang dibakar dengan bumbu rempah-rempah. Ikan Bakar biasanya disajikan dengan sambal dan lalapan. Ikan Bakar adalah makanan yang sangat populer di Indonesia dan dinikmati oleh berbagai kalangan."
  ),
  Food(
      image: "https://asset.kompas.com/crops/btj22rekM1BWGnffmdQnoCt5ezk=/0x10:1000x677/750x500/data/photo/2021/07/29/61019f07ef1ac.jpg",
      name: "Bubur Ayam",
      desc: "Bubur Ayam adalah makanan khas Indonesia yang terbuat dari nasi yang dimasak dengan santan, kaldu ayam, dan berbagai macam topping, seperti ayam suwir, cakwe, dan kerupuk. Bubur Ayam adalah makanan yang sangat populer di Indonesia dan dinikmati oleh berbagai kalangan."
  ),
  Food(
      image: "https://www.sasa.co.id/medias/page_medias/nasi_kuning_rice_cooker.jpg",
      name : "Nasi Uduk",
      desc : "Nasi Uduk adalah makanan khas indonesia yang terbuat dari nasi yang dimasak dengan santan dan rempah-rempah, seperti pala, kayu manis, jahe, daun serai, dan merica. Nasi uduk memiliki aroma yang khas dan rasa yang gurih. Nasi Uduk adalah makanan yang sangat populer di Indonesia dan dinikmati oleh berbagai kalangan."
  )
];