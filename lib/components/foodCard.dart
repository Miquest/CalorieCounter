import 'package:flutter/material.dart';


class FoodCard extends StatelessWidget {


  final int amount;
  final String name;
  
  FoodCard({super.key, required this.name, required this.amount});

  final ImageProvider? imageProvider = NetworkImage("https://www.google.com/url?sa=i&url=https%3A%2F%2Ftheloopywhisk.com%2F2024%2F08%2F24%2Feasy-gluten-free-sandwich-bread%2F&psig=AOvVaw1qV4diaVHrWgs4b-bQp7af&ust=1754422068460000&source=images&cd=vfe&opi=89978449&ved=0CBUQjRxqFwoTCIiv6tTx8Y4DFQAAAAAdAAAAABAL");

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Card.outlined(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              minRadius: 30,
              maxRadius: 35,
              child: Icon(Icons.fastfood),
              //backgroundImage: imageProvider,
            ),

            SizedBox(height: 20),

            Text(name),

            SizedBox(height: 10),

            Text(
              "${amount}g",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
