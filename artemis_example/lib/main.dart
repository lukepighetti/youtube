import 'package:artemis/artemis.dart';
import 'package:artemis_example/pokemon.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final client = ArtemisClient("https://graphql-pokemon.now.sh");
    final query = PokemonQuery();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: Center(
          child: FutureBuilder<GraphQLResponse<Pokemon$Query>>(
            future: client.execute(query),
            builder: (context, snapshot) {
              final response = snapshot.data;
              final pokemon = response.data.pokemon;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// Pikachu
                  Text(pokemon.name),
                  for (var attack in pokemon.attacks.special) Text(attack.name),
                  SizedBox(height: 20),

                  /// Raichu
                  for (var evolution in pokemon.evolutions) ...[
                    Text(evolution.name),
                    for (var attack in evolution.attacks.fast)
                      Text(attack.name),
                  ]
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
