import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//        title: Text(widget.title),
//      ),
      body: const MyWidget(),
    );
  }

}

class _CardData {
  final String text;
  final String descriptionText;
  final IconData icon;
  final String? imageUrl;

  _CardData(
    this.text, {
      required this.descriptionText,
      this.icon = Icons.abc_outlined,
      this.imageUrl,
    }
  );
}

class MyWidget extends StatelessWidget{
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      _CardData(
        'Замри',
        descriptionText: 'hahaha',
        imageUrl: 'https://cdn.trinixy.ru/pics3/20080128/racoon_03.jpg',
      ),
      _CardData(
        'Прив',
        descriptionText: 'ahahahahah',
        icon: Icons.hail,
        imageUrl: 'https://cdn.trinixy.ru/pics3/20080128/racoon_24.jpg',
      ),
      _CardData(
        'Ох',
        descriptionText: 'lol',
        icon: Icons.warning_amber,
        imageUrl: 'https://cdn.trinixy.ru/pics3/20080128/racoon_31.jpg',
      ),
    ];
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: data.map((e) => _Card.fromData(e)).toList(),
        ),
      ),
    );
  }
}


class _Card extends StatefulWidget{
  final String text;
  final String descriptionText;
  final IconData icon;
  final String? imageUrl;

  const _Card(
    this.text, {
      this.icon = Icons.ac_unit_outlined,
      required this.descriptionText,
      this.imageUrl,
    }
  );

  factory _Card.fromData(_CardData data) =>
    _Card(
      data.text,
      descriptionText: data.descriptionText,
      icon: data.icon,
      imageUrl: data.imageUrl,
    );

  @override
  State<_Card> createState() => _CardState();
}

class _CardState extends State<_Card> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.5),
            spreadRadius: 4,
            offset: const Offset(0, 5),
            blurRadius: 8,
          ),
        ],
      ),
    child: IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
            child: SizedBox(
              height: double.infinity,
              width: 200,
              child: Image.network(
                widget.imageUrl ?? '',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Placeholder(),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.text * 10,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Text(
                    widget.descriptionText * 70,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 16,
                  bottom: 16,
                ),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: isLiked
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.redAccent,
                          key: ValueKey<int>(0),
                        )
                      : const Icon(
                          Icons.favorite_border,
                          key: ValueKey<int>(1),
                        ) ,
                  ),
                ),
              ),
          ),
        ],
      ),
    ),
    );
  }
}
