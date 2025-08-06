
import 'package:flutter/material.dart';
import 'package:idea_envalutor/utils/toast_util.dart';
import 'package:idea_envalutor/viewModel/idea_provider.dart';
import 'package:idea_envalutor/viewModel/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';

import '../model/Idea.dart';
import '../utils/snackbar_utils.dart';

class IdeaListingScreen extends StatefulWidget {
  const IdeaListingScreen({super.key});

  @override
  State<IdeaListingScreen> createState() => _IdeaListingScreenState();
}

class _IdeaListingScreenState extends State<IdeaListingScreen> {
  String _sortBy = "rating";

  @override
  Widget build(BuildContext context) {
    final ideaProvider = Provider.of<IdeaProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;

    // List with original index
    List<Map<String, dynamic>> sortedIdeas = List.generate(
      ideaProvider.ideas.length,
          (i) => {"idea": ideaProvider.ideas[i], "originalIndex": i},
    );

    // Sorting
    sortedIdeas.sort((a, b) {
      if (_sortBy == "rating") {
        return b["idea"].rating.compareTo(a["idea"].rating);
      } else {
        return b["idea"].votes.compareTo(a["idea"].votes);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Startup Ideas"),
        backgroundColor: isDark ? Colors.purple : Colors.blue,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/leaderboard');
              },
              icon: const Icon(Icons.emoji_events, color: Colors.yellow, size: 30,)
          ),
          
          DropdownButton<String>(
            value: _sortBy,
            dropdownColor: isDark ? Colors.purple : Colors.blue,
            iconEnabledColor: Colors.white,
            underline: const SizedBox(),
            onChanged: (value) {
              setState(() {
                _sortBy = value!;
              });
            },
            items: const [
              DropdownMenuItem(value: "rating", child: Text("Sort by Rating",
                  style: TextStyle(
                      color: Colors.white
                  ),
              )),
              DropdownMenuItem(value: "votes", child: Text("Sort by Votes",
              style: TextStyle(
                color: Colors.white
              ),
              )),
            ],
          ),
        ],
      ),
      body: sortedIdeas.isEmpty
          ? const Center(child: Text("No ideas submitted yet"))
          : ListView.builder(
        itemCount: sortedIdeas.length,
        itemBuilder: (context, index) {
          var idea = sortedIdeas[index]["idea"] as Idea;
          var originalIndex = sortedIdeas[index]["originalIndex"] as int;
          bool isExpanded = false;

          return StatefulBuilder(
            builder: (context, setLocalState) {
              return
                Dismissible(
                    key: Key(idea.name),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (_) {
                      ideaProvider.deleteIdea(originalIndex);
                      showCustomSnackBar(context, "Idea deleted", bgColor: Colors.red);
                    },
                    child:

                Card(
                margin: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name
                      Text(
                        idea.name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),

                      // Tagline
                      Text(
                        idea.tagline,
                        style: const TextStyle(color: Colors.grey),
                      ),

                      const SizedBox(height: 8),

                      // Rating & Votes
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("⭐ Rating: ${idea.rating}"),
                          Text("👍 Votes: ${idea.votes}"),
                          ElevatedButton(
                            onPressed: ideaProvider.hasVoted(originalIndex)
                                ? null
                                : () {
                              ideaProvider.upvoteIdea(originalIndex);
                              showCustomSnackBar(context, "Thanks for voting!", bgColor: Colors.green);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isDark ? Colors.purple : Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text("Upvote"),
                          ),
                          IconButton(
                              onPressed: () {
                                Share.share(
                                    "Check out this idea: ${idea.name}\n${idea.tagline}\nRating: ${idea.rating}⭐"
                                );
                              },
                              icon:  Icon(Icons.share,
                                  color:  isDark
                                      ? Colors.purple
                                      : Colors.blue
                              ),
                          )
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Description
                  const SizedBox(height: 8,),
                      Text(
                        idea.description,
                        maxLines: isExpanded ? null : 1,
                        overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                      ),

                      InkWell(
                        onTap: () {
                          setLocalState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        child: Text(
                          isExpanded ? "Read Less" : "Read More..",
                          style:  TextStyle(
                              color:isDark
                                  ? Colors.purple
                                  : Colors.blue
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor:const Color(0xFF00897B),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          "Add Idea",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/ideaSubmission'); // Navigate to submission screen
        },
      ),

    );
  }
}
