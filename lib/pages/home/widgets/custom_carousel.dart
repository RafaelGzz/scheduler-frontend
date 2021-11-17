import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CustomCarousel extends StatelessWidget {
  const CustomCarousel({
    Key? key,
    required this.onPageChanged,
  }) : super(key: key);

  final Function(int) onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 200),
      child: CarouselSlider.builder(
        options: CarouselOptions(
          onPageChanged: (index, _) => onPageChanged(index),
          height: 800,
          aspectRatio: .5,
          autoPlay: true,
        ),
        itemCount: 8,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
            Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 100),
          margin: const EdgeInsets.symmetric(
            horizontal: 5.0,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                "https://source.unsplash.com/2000x1500/?hospital/$itemIndex",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
