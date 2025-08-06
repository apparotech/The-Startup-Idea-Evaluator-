

import 'dart:math';

int generateSmartFakeRating(String ideaName, String description) {
  Random random = Random();


  int baseScore = (ideaName.length + description.length) % 50; // 0–49


  int randomBoost = random.nextInt(51); // 0–50


  int keywordBonus = 0;
  List<String> goodKeywords = [
    "AI", "tech", "startup", "app", "automation", "eco", "health", "smart", "data"
  ];

  for (var keyword in goodKeywords) {
    if (ideaName.toLowerCase().contains(keyword.toLowerCase()) ||
        description.toLowerCase().contains(keyword.toLowerCase())) {
      keywordBonus += 5; // +5 per keyword
    }
  }


  int rating = baseScore + randomBoost + keywordBonus;


  return rating.clamp(0, 100);
}
