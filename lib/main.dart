import 'package:flutter/material.dart';

void main() => runApp(const ShoeStoreApp());

const blue = Color(0xFF5A9DE5);
const ink = Color(0xFF172331);
const muted = Color(0xFF87919A);
const canvas = Color(0xFFF7F8FA);

class Shoe {
  const Shoe(this.name, this.price, this.image, {this.tag = 'BEST SELLER'});
  final String name;
  final String price;
  final String image;
  final String tag;
}

const shoes = [
  Shoe('Nike Air Jordan', '493.00', 'https://images.unsplash.com/photo-1552346154-21d32810aba3?auto=format&fit=crop&w=700&q=85'),
  Shoe('Nike Air Max', '897.99', 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=700&q=85'),
  Shoe('Nike Air Jordan', '849.69', 'https://images.unsplash.com/photo-1600185365483-26d7a4cc7519?auto=format&fit=crop&w=800&q=85', tag: 'BEST CHOICE'),
];

class ShoeStoreApp extends StatelessWidget {
  const ShoeStoreApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shoe Store',
        theme: ThemeData(useMaterial3: true, scaffoldBackgroundColor: canvas, colorScheme: ColorScheme.fromSeed(seedColor: blue), fontFamily: 'Roboto'),
        home: const HomePage(),
      );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int cart = 0;
  void add() => setState(() => cart++);
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: ListView(padding: const EdgeInsets.fromLTRB(20, 14, 20, 28), children: [
            Row(children: [
              _roundIcon(Icons.apps_rounded),
              const Expanded(child: Center(child: Text('Mondolibug, Sylhet', style: TextStyle(color: ink, fontSize: 14, fontWeight: FontWeight.w600)))),
              _roundIcon(Icons.shopping_bag_outlined, badge: cart > 0),
            ]),
            const SizedBox(height: 22),
            Container(height: 48, padding: const EdgeInsets.symmetric(horizontal: 16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(28)), child: const Row(children: [Icon(Icons.search, color: muted, size: 21), SizedBox(width: 12), Text('Looking for shoes', style: TextStyle(color: muted, fontSize: 13))])),
            const SizedBox(height: 28),
            _sectionTitle('Popular Shoes'),
            const SizedBox(height: 14),
            SizedBox(height: 205, child: Row(children: [Expanded(child: _productCard(shoes[0])), const SizedBox(width: 14), Expanded(child: _productCard(shoes[1]))])),
            const SizedBox(height: 38),
            _sectionTitle('New Arrivals'),
            const SizedBox(height: 14),
            _arrivalCard(shoes[2]),
          ]),
        ),
      );

  Widget _productCard(Shoe shoe) => GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(shoe: shoe, onAdd: add))),
        child: Container(clipBehavior: Clip.antiAlias, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: Padding(padding: const EdgeInsets.all(8), child: _shoeImage(shoe.image))),
          Padding(padding: const EdgeInsets.fromLTRB(10, 0, 10, 0), child: Text(shoe.tag, style: const TextStyle(color: blue, fontSize: 9, letterSpacing: .25))),
          Padding(padding: const EdgeInsets.fromLTRB(10, 4, 10, 0), child: Text(shoe.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: ink))),
          Padding(padding: const EdgeInsets.fromLTRB(10, 6, 0, 0), child: Row(children: [Expanded(child: Text('\$${shoe.price}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: ink))), Material(color: blue, borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), bottomRight: Radius.circular(16)), child: InkWell(onTap: () { add(); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to cart'), duration: Duration(seconds: 1))); }, child: const SizedBox(width: 34, height: 32, child: Icon(Icons.add, color: Colors.white, size: 21))))])),
        ])),
      );

  Widget _arrivalCard(Shoe shoe) => GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(shoe: shoe, onAdd: add))), child: Container(height: 105, padding: const EdgeInsets.only(left: 15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)), child: Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [Text(shoe.tag, style: const TextStyle(color: blue, fontSize: 9, letterSpacing: .3)), const SizedBox(height: 5), Text(shoe.name, style: const TextStyle(color: ink, fontWeight: FontWeight.w600, fontSize: 15)), const SizedBox(height: 8), Text('\$${shoe.price}', style: const TextStyle(color: ink, fontSize: 12, fontWeight: FontWeight.w700))])), Expanded(child: Padding(padding: const EdgeInsets.all(5), child: _shoeImage(shoe.image)))])));

  Widget _sectionTitle(String title) => Row(children: [Text(title, style: const TextStyle(color: ink, fontWeight: FontWeight.w700, fontSize: 15)), const Spacer(), TextButton(onPressed: () {}, style: TextButton.styleFrom(foregroundColor: blue, padding: EdgeInsets.zero, minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap), child: const Text('See all', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400)))]);
}

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.shoe, required this.onAdd});
  final Shoe shoe;
  final VoidCallback onAdd;
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(child: Column(children: [
          Padding(padding: const EdgeInsets.fromLTRB(18, 12, 18, 0), child: Row(children: [_roundIcon(Icons.arrow_back_ios_new, onTap: () => Navigator.pop(context)), const Expanded(child: Center(child: Text('Men’s Shoes', style: TextStyle(color: ink, fontWeight: FontWeight.w600, fontSize: 14)))), _roundIcon(Icons.shopping_bag_outlined)])),
          Expanded(child: Stack(alignment: Alignment.center, children: [Positioned(top: 38, left: 22, right: 22, child: SizedBox(height: 260, child: _shoeImage(shoe.image))), Positioned(top: 195, left: 24, right: 24, child: Container(height: 42, decoration: BoxDecoration(border: Border.all(color: blue, width: 1), borderRadius: BorderRadius.circular(50)))), Positioned(top: 216, child: Container(width: 35, height: 35, decoration: const BoxDecoration(color: blue, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Color(0x445A9DE5), blurRadius: 9, offset: Offset(0, 4))]), child: const Icon(Icons.compare_arrows, color: Colors.white, size: 19)))])),
          Container(width: double.infinity, padding: const EdgeInsets.fromLTRB(18, 17, 18, 12), decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(22))), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('BEST SELLER', style: TextStyle(color: blue, fontSize: 10)), const SizedBox(height: 6), Text(shoe.name, style: const TextStyle(color: ink, fontSize: 20, fontWeight: FontWeight.w700)), const SizedBox(height: 5), Text('\$${shoe.price}', style: const TextStyle(color: ink, fontSize: 15)), const SizedBox(height: 6), const Text('Air Jordan is an American brand of basketball shoes athletic, casual, and style clothing produced by Nike.', style: TextStyle(color: muted, fontSize: 12, height: 1.55)), const SizedBox(height: 12), const Text('Gallery', style: TextStyle(color: ink, fontSize: 14, fontWeight: FontWeight.w600)), const SizedBox(height: 9), Row(children: shoes.map((s) => Container(width: 47, height: 47, margin: const EdgeInsets.only(right: 9), padding: const EdgeInsets.all(3), decoration: BoxDecoration(color: canvas, borderRadius: BorderRadius.circular(12)), child: _shoeImage(s.image))).toList())])),
          Container(padding: const EdgeInsets.fromLTRB(18, 10, 18, 16), decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Color(0xFFF2F3F5)))), child: Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Price', style: TextStyle(color: muted, fontSize: 12)), const SizedBox(height: 4), Text('\$${shoe.price}', style: const TextStyle(color: ink, fontSize: 16, fontWeight: FontWeight.w700))])), SizedBox(height: 48, width: 150, child: FilledButton(onPressed: () { onAdd(); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added to cart'), duration: Duration(seconds: 1))); }, style: FilledButton.styleFrom(backgroundColor: blue, shape: const StadiumBorder()), child: const Text('Add To Cart', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))))])),
        ])),
      );
}

Widget _roundIcon(IconData icon, {bool badge = false, VoidCallback? onTap}) => InkWell(onTap: onTap, borderRadius: BorderRadius.circular(24), child: SizedBox(width: 42, height: 42, child: Stack(alignment: Alignment.center, children: [Container(width: 42, height: 42, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: Icon(icon, size: 19, color: ink)), if (badge) Positioned(right: 5, top: 5, child: Container(width: 7, height: 7, decoration: const BoxDecoration(color: Color(0xFFF36B69), shape: BoxShape.circle)))])));

Widget _shoeImage(String url) => Image.network(url, fit: BoxFit.contain, errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.shopping_bag_outlined, color: blue, size: 54)));

