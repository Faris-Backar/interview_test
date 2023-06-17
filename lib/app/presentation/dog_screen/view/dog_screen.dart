import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:interview_test/app/presentation/dog_screen/controller/dog_controller.dart';

class DogScreen extends StatefulWidget {
  const DogScreen({super.key});

  @override
  State<DogScreen> createState() => _DogScreenState();
}

class _DogScreenState extends State<DogScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder(
              future: DogController().getRandomDogImages(),
              builder: (context, snapshot) {
                final imageData = json.decode(snapshot.data.toString());
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Container(
                        height: size.height * .5,
                        width: size.width * .9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                              image: NetworkImage(
                                imageData["message"],
                              ),
                              fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () => setState(() {}),
                        child: Container(
                          height: 50,
                          width: size.width * .5,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey[300],
                          ),
                          child: const Text(
                            "Refresh",
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                return const SizedBox.shrink();
              }),
        ),
      ),
    );
  }
}
