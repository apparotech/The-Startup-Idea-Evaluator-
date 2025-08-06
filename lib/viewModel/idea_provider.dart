import 'package:flutter/material.dart';
import 'package:idea_envalutor/model/Idea.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


/*
class IdeaProvider with ChangeNotifier {
  List<Idea> _ideas = [];
  List<Idea> get ideas => _ideas;

  // Track voted ideas (IDs or index)
  List<int> _votedIdeaIndexes = [];

  Future<void> loadIdeas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedIdeas = prefs.getStringList('ideas') ?? [];
    _ideas = savedIdeas.map((e) => Idea.fromMap(jsonDecode(e))).toList();

    // Load voted indexes
    _votedIdeaIndexes = prefs.getStringList('votedIdeas')?.map(int.parse).toList() ?? [];

    notifyListeners();
  }

  Future<void> addIdea(Idea idea) async {
    _ideas.add(idea);
    await _saveIdeas();
  }

  // ✅ New Upvote Method
  Future<void> upvoteIdea(int index) async {
    // Check if already voted
    if (_votedIdeaIndexes.contains(index)) {
      return; // Already voted, ignore
    }

    _ideas[index].votes++;
    _votedIdeaIndexes.add(index);
    await _saveIdeas();

    // Save voted indexes separately
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('votedIdeas', _votedIdeaIndexes.map((e) => e.toString()).toList());

    notifyListeners();
  }

  // Helper: Save idea list
  Future<void> _saveIdeas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      'ideas',
      _ideas.map((i) => jsonEncode(i.toMap())).toList(),
    );
  }

  bool hasVoted(int index) {
    return _votedIdeaIndexes.contains(index);
  }
}

 */



class IdeaProvider with ChangeNotifier {
  List<Idea> _ideas = [];
  List<int> _votedIdeaIndexes = [];

  List<Idea> get ideas => _ideas;

  Future<void> loadIdeas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Load ideas
    List<String> savedIdeas = prefs.getStringList('ideas') ?? [];
    _ideas = savedIdeas.map((e) => Idea.fromMap(jsonDecode(e))).toList();

    // Load voted indexes
    _votedIdeaIndexes = prefs.getStringList('votedIdeas')?.map(int.parse).toList() ?? [];

    notifyListeners();
  }

  Future<void> addIdea(Idea idea) async {
    _ideas.add(idea);
    await _saveIdeas();
    notifyListeners();
  }

  Future<void> upvoteIdea(int index) async {
    if (_votedIdeaIndexes.contains(index)) return; // Already voted
    _ideas[index].votes++;
    _votedIdeaIndexes.add(index);
    await _saveIdeas();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('votedIdeas', _votedIdeaIndexes.map((e) => e.toString()).toList());
    notifyListeners();
  }

  bool hasVoted(int index) => _votedIdeaIndexes.contains(index);

  Future<void> deleteIdea(int index) async {
    _ideas.removeAt(index);
    await _saveIdeas();
    notifyListeners();
  }

  Future<void> _saveIdeas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('ideas', _ideas.map((i) => jsonEncode(i.toMap())).toList());
  }
}
