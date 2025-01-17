part of 'home_page.dart';

class Body extends StatelessWidget{
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      CardData(
        'Замри!',
        descriptionText: 'hahaha',
        imageUrl: 'https://cdn.trinixy.ru/pics3/20080128/racoon_03.jpg',
      ),
      CardData(
        'Прив! КаДел?',
        descriptionText: 'ahahahahah',
        icon: Icons.hail,
        imageUrl: 'https://cdn.trinixy.ru/pics3/20080128/racoon_06.jpg',
      ),
      CardData(
        'Ох',
        descriptionText: 'lol',
        icon: Icons.warning_amber,
        imageUrl: 'https://cdn.trinixy.ru/pics3/20080128/racoon_24.jpg',
      ),
    ];
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: data.map((data) {
            return _Card.fromData(
              data,
              onLike: (String title, bool isLiked) =>
                _showSnackBar(context, title, isLiked),
              onTap: () => _navToDetails(context, data),
            );
          }).toList(),
        ),
      ),
    );
  }
}

void _navToDetails(BuildContext context, CardData data) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => DetailsPage(data)),
  );
}

void _showSnackBar(BuildContext context, String title, bool isLiked) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Racoon $title ${isLiked ? 'liked!' : 'disliked :('}',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      backgroundColor: Colors.orangeAccent,
      duration: const Duration(seconds: 1),
    ));
  });
}

typedef OnLikeCallback = void Function(String title, bool isLiked)?;

class _Card extends StatefulWidget{
  final String text;
  final String descriptionText;
  final IconData icon;
  final String? imageUrl;
  final OnLikeCallback onLike;
  final VoidCallback? onTap;

  const _Card(
    this.text, {
      this.icon = Icons.ac_unit_outlined,
      required this.descriptionText,
      this.imageUrl,
      this.onLike,
      this.onTap,
    }
  );

  factory _Card.fromData(
    CardData data, {
      OnLikeCallback onLike,
      VoidCallback? onTap,
    }) =>
    _Card(
      data.text,
      descriptionText: data.descriptionText,
      icon: data.icon,
      imageUrl: data.imageUrl,
      onLike: onLike,
      onTap: onTap,
    );

  @override
  State<_Card> createState() => _CardState();
}

class _CardState extends State<_Card> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.all(16),
        constraints: const BoxConstraints(minHeight: 200),
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
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              child: SizedBox(
                height: double.infinity,
                width: 120,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        widget.imageUrl ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Placeholder(),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                          ),
                        ),
                        padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                        child: Text(
                          'скидка 20%',
                          style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.text * 1,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    Text(
                      widget.descriptionText * 2,
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
                      setState(() => isLiked = !isLiked);
                      widget.onLike?.call(widget.text, isLiked);
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
      ),
    );
  }
}
