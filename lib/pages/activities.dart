import 'package:flutter/material.dart';

class ActivitiesButton extends StatelessWidget {
  const ActivitiesButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: GridTile(
        footer: const Padding(
          padding: EdgeInsets.only(
            bottom: 6.0,
            left: 10.0,
          ),
          child: Text(
            'Activities',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage(
                'assets/images/home/now-in-kolkata.png',
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0),
                  Colors.black.withOpacity(0.8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
