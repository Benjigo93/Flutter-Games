import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef ChangePlayersCount = void Function(int count);

class MCPlayerSelection extends StatelessWidget {
  const MCPlayerSelection({Key? key, required this.onPlayersCount}) : super(key: key);

  final ChangePlayersCount onPlayersCount;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 25.0),
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.70,
                child: const Text(
                  'How many players ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w600
                  ),
                )
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.50,
            child: TextField(
              textAlign: TextAlign.center,
              style:const TextStyle(
                fontSize: 25.0
              ),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '1',
                labelText: 'Players',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              textInputAction: TextInputAction.go,
              onSubmitted: (value) {
                if (double.tryParse(value) != null) {
                  onPlayersCount(int.parse(value));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                            'Please choose a correct number of player !',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15.0,
                            )
                        ),
                        backgroundColor: Colors.red.withOpacity(0.7),
                        duration: const Duration(seconds: 1),
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                      )
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
