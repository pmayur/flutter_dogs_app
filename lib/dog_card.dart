import 'package:flutter/material.dart';

import 'dog_model.dart';
import 'dog_detail_page.dart';

class DogCard extends StatefulWidget {
  final Dog dog;

  DogCard(this.dog);

  @override
  _DogCardState createState() => _DogCardState(dog);
}

class _DogCardState extends State<DogCard> {
  Dog dog;
  String renderUrl;

  Widget get dogImage {
    return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(renderUrl ?? ''),
        ),
      ),
    );
  }

  /* Template for display Card */
  Widget get dogCard {
    return Container(
      width: 310.0,
      height: 115.0,
      child: Card(
        color: Colors.black87,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            bottom: 8.0,
            left: 64.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(widget.dog.name,
                  style: Theme.of(context).textTheme.headline),
              Text(widget.dog.location,
                  style: Theme.of(context).textTheme.subhead),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.star,
                  ),
                  Text(': ${widget.dog.rating} / 10')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void initState() {
    super.initState();
    renderDogPic();
  }

  void renderDogPic() async {
    await dog.getImageUrl();
    if (mounted) {
      setState(() {
        renderUrl = dog.imageUrl;
      });
    }
  }

  showDogDetailPage() {
  // Navigator.of(context) accesses the current app's navigator.
  // Navigators can 'push' new routes onto the stack,
  // as well as pop routes off the stack.
  //
  // This is the easiest way to build a new page on the fly
  // and pass that page some state from the current page.
  Navigator.of(context).push(
    MaterialPageRoute(
      // builder methods always take context!
      builder: (context) {
        return DogDetailPage(dog);
      },
    ),
  );
}

  _DogCardState(this.dog);

  @override
  Widget build(BuildContext context) {
    // InkWell is a special Material widget that makes its children tappable
    // and adds Material Design ink ripple when tapped.
    return InkWell(
      // onTap is a callback that will be triggered when tapped.
      onTap: showDogDetailPage,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          height: 115.0,
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 50.0,
                child: dogCard,
              ),
              Positioned(top: 7.5, child: dogImage),
            ],
          ),
        ),
      ),
    );
  }
}
