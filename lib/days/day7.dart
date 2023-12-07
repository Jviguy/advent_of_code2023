import 'dart:collection';

import '../calendar.dart';

enum HandType {
  noValue,
  highCard,
  onePair,
  twoPair,
  threeOfAKind,
  fullHouse,
  fourOfAKind,
  fiveOfAKind
}

Map<String, int> cardMap = {
  "2": 0,
  "3": 1,
  "4": 2,
  "5": 3,
  "6": 4,
  "7": 5,
  "8": 6,
  "9": 7,
  "T": 8,
  "J": 9,
  "Q": 10,
  "K": 11,
  "A": 12
};

class Card implements Comparable<Card> {
  String card;
  Card(this.card);
  @override
  int compareTo(Card other) {
    return cardMap[card]!.compareTo(cardMap[other.card]!);
  }
}

class Hand implements Comparable<Hand> {
  List<Card> cards;
  int bid;
  Hand(this.cards, this.bid);

  factory Hand.fromString(String cardString, int bid) {
    List<Card> cards = [];
    for (String card in cardString.split("")) {
      cards.add(Card(card));
    }
    return Hand(cards, bid);
  }
  
  @override
  int compareTo(Hand other) {
    if (other.handType() == handType()) {
      for (int i = 0; i < cards.length; i++) {
        // if they aren't equal than we can return this comp value.
        if (cards[i].compareTo(other.cards[i])!=0) {
          return cards[i].compareTo(other.cards[i]);
        }
      }
    }
    return handType().compareTo(other.handType());
  }

  int handType() {
    HashMap<String, int> countMap = HashMap();
    for (Card card in cards) {
      countMap.update(card.card, (value) => value+1, ifAbsent: () => 1);
    }
    int pairs = 0;
    int threes = 0;
    int fours = 0;
    int fives = 0;
    for (int count in countMap.values) {
      switch (count) {
        case 2:
          pairs++;
        case 3:
          threes++;
        case 4:
          fours++;
        case 5:
          fives++;
      }
    }
    if (pairs == 1) {
      if (threes == 1) {
        return HandType.fullHouse.index;
      }
      return HandType.onePair.index;
    } else if (pairs == 2) {
      return HandType.twoPair.index;
    } else if (threes == 1) {
      return HandType.threeOfAKind.index;
    } else if (fours == 1) {
      return HandType.fourOfAKind.index;
    } else if (fives == 1) {
      return HandType.fiveOfAKind.index;
    // high card check.
    } else if (countMap.values.length == cards.length) {
      return HandType.highCard.index;
    } else {
      return HandType.noValue.index;
    }
  }
}

class Day7Solution extends DaySolution {
  @override
  int part1(String input) {
    List<Hand> hands = [];
    for (String line in input.split("\n")) {
      var [cards, bidString] = line.split(" ");
      hands.add(Hand.fromString(cards, int.parse(bidString)));
    }
    hands.sort();
    int r = 0;
    for (int i = 0; i < hands.length; i++) {
      r += hands[i].bid * (i+1);
    }
    return r;
  }


  @override
  int part2(String input) {
    List<HandPT2> hands = [];
    for (String line in input.split("\n")) {
      var [cards, bidString] = line.split(" ");
      hands.add(HandPT2.fromString(cards, int.parse(bidString)));
    }
    hands.sort();
    int r = 0;
    for (int i = 0; i < hands.length; i++) {
      r += hands[i].bid * (i+1);
    }
    return r;
  }
}


class CardPT2 implements Comparable<CardPT2> {
  String card;
  CardPT2(this.card);
  @override
  int compareTo(CardPT2 other) {
    return cardMapPT2[card]!.compareTo(cardMapPT2[other.card]!);
  }

  @override
  String toString() {
    // TODO: implement toString
    return card;
  }
}

class HandPT2 implements Comparable<HandPT2> {
  List<CardPT2> cards;
  int bid;
  HandPT2(this.cards, this.bid);

  factory HandPT2.fromString(String cardString, int bid) {
    List<CardPT2> cards = [];
    for (String card in cardString.split("")) {
      cards.add(CardPT2(card));
    }
    return HandPT2(cards, bid);
  }

  @override
  int compareTo(HandPT2 other) {
    if (other.handType() == handType()) {
      for (int i = 0; i < cards.length; i++) {
        // if they aren't equal than we can return this comp value.
        if (cards[i].compareTo(other.cards[i])!=0) {
          return cards[i].compareTo(other.cards[i]);
        }
      }
    }
    return handType().compareTo(other.handType());
  }

  int handType() {
    HashMap<String, int> countMap = HashMap();
    for (CardPT2 card in cards) {
      countMap.update(card.card, (value) => value+1, ifAbsent: () => 1);
    }
    // we can be greedy with our wildcard J's now.
    int? jCount = countMap["J"];
    if (jCount != null) {
      // we know we have J's.
      // add them to the index with the highest number.
      String maxKey = "";
      int mV = 0;
      countMap.forEach((key, value) {
        if (value > mV && key != "J") {
          mV = value;
          maxKey = key;
        }
      });
      if (maxKey != "") {
        // means there wasn't only J's.
        countMap.remove("J");
        countMap.update(maxKey, (value) => value+jCount);
      }
    }
    int pairs = 0;
    int threes = 0;
    int fours = 0;
    int fives = 0;
    for (int count in countMap.values) {
      switch (count) {
        case 2:
          pairs++;
        case 3:
          threes++;
        case 4:
          fours++;
        case 5:
          fives++;
      }
    }
    if (pairs == 1) {
      if (threes == 1) {
        return HandType.fullHouse.index;
      }
      return HandType.onePair.index;
    } else if (pairs == 2) {
      return HandType.twoPair.index;
    } else if (threes == 1) {
      return HandType.threeOfAKind.index;
    } else if (fours == 1) {
      return HandType.fourOfAKind.index;
    } else if (fives == 1) {
      return HandType.fiveOfAKind.index;
      // high card check.
    } else if (countMap.values.length == cards.length) {
      return HandType.highCard.index;
    } else {
      return HandType.noValue.index;
    }
  }

  @override
  String toString() {
    return cards.toString();
  }
}

Map<String, int> cardMapPT2 = {
  "J": 0,
  "2": 1,
  "3": 2,
  "4": 3,
  "5": 4,
  "6": 5,
  "7": 6,
  "8": 7,
  "9": 8,
  "T": 9,
  "Q": 10,
  "K": 11,
  "A": 12
};