import 'package:flutter/material.dart';
import 'package:idea_envalutor/viewModel/theme_provider.dart';
import 'package:provider/provider.dart';

import '../model/Idea.dart';
import '../viewModel/idea_provider.dart';
class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {

  String _sortBy = "votes";

  @override
  Widget build(BuildContext context) {
    final ideaProvider = Provider.of<IdeaProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;


    List<Map<String, dynamic>> leaderboard = List.generate(
      ideaProvider.ideas.length,
          (i) => {"idea": ideaProvider.ideas[i]},
    );

    leaderboard.sort((a, b) {
      if (_sortBy == "votes") {
        return b["idea"].votes.compareTo(a["idea"].votes);
      } else {
        return b["idea"].rating.compareTo(a["idea"].rating);
      }
    });

    leaderboard = leaderboard.take(5).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("🏆 Leaderboard"),
        backgroundColor: isDark ? Colors.purple : Colors.blue,

        actions: [
          DropdownButton<String>(
            value: _sortBy,
            dropdownColor: isDark ? Colors.purple : Colors.blue,
            underline: const SizedBox(),
            iconEnabledColor: Colors.white,
            onChanged: (value) {
              setState(() {
                _sortBy = value!;
              });
            },
            items: const [
              DropdownMenuItem(value: "votes", child: Text("Sort by Votes",style: TextStyle(
                color: Colors.white
              ),)),
              DropdownMenuItem(value: "rating", child: Text("Sort by Rating",style: TextStyle(
                  color: Colors.white
              ),
              )),
            ],
          ),
        ],
      ),

      body:
      leaderboard.isEmpty
          ? const Center(child: Text("No ideas available"))
      : ListView.builder(
          itemCount: leaderboard.length,
          itemBuilder: (context, index) {
            Idea idea = leaderboard[index]["idea"];

            return Card(
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,

              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors:
                      isDark
                          ? [
                        Colors.purple.shade300,
                        Colors.purple.shade50,
                      ]
                          : [
                        Colors.blue.shade200,
                        Colors.blue.shade50,
                      ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(padding:const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Text(
                      _getRankEmoji(index),
                          style:  TextStyle(
                              fontSize: 24,
                            color: isDark ? Colors.purple.shade900 : Colors.blue.shade900,
                          )
                      ),
                      const SizedBox(width: 10,),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text( idea.name,
                              style:  TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                color: isDark ? Colors.purple.shade900 : Colors.blue.shade900,
                              )
                          ),

                          Text(
                            idea.tagline,
                            style:
                            const TextStyle(color: Colors.black54),
                          )
                        ],
                      )
                      ),
                      Text(
                        _sortBy == "votes"
                            ? "👍 ${idea.votes}"
                            : "⭐ ${idea.rating}",

                        style:  TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16,
                          color: isDark ? Colors.purple.shade900 : Colors.blue.shade900,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
      )
    );
  }

  String _getRankEmoji(int index) {
    switch (index) {
      case 0:
        return "🥇";
      case 1:
        return "🥈";
      case 2:
        return "🥉";
      default:
        return "${index + 1}.";
    }
  }
}
