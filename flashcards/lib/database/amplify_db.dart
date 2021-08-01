import 'package:amplify_flutter/amplify.dart';
import 'package:flashcards/models/ModelProvider.dart';

class AmplifyDb {
  Future addDeckData(String deckname, String id) async {
    DeckListTable newPost =
        DeckListTable(deckName: deckname, CardsLists: [], logintableID: id);
    await Amplify.DataStore.save(newPost)
        .then((value) => print("data sent to aws"));
  }

  Future<List<DeckListTable>> getAllDeckData(String id) async {
    List<DeckListTable> deck = await Amplify.DataStore.query(
        DeckListTable.classType,
        where: DeckListTable.LOGINTABLEID.eq(id));
    return deck;
  }

  Future updateDeckData(String id, String text) async {
    DeckListTable deck = (await Amplify.DataStore.query(DeckListTable.classType,
        where: DeckListTable.ID.eq(id)))[0];
    await Amplify.DataStore.save(deck.copyWith(deckName: text));
  }

  Future<List<CardsListTable>> getAllCardData(String deckId, String id) async {
    List<CardsListTable> chatData = await Amplify.DataStore.query(
        CardsListTable.classType,
        where: CardsListTable.DECKLISTTABLEID
            .eq(deckId)
            .and(CardsListTable.LOGINTABLEID.eq(id)));
    return chatData;
  }

  Future deleteCardData(String id) async {
    List<CardsListTable> card = (await Amplify.DataStore.query(
        CardsListTable.classType,
        where: CardsListTable.ID.eq(id)));
    await Amplify.DataStore.delete(card[0]);
  }

  Future addCardData(String question, String answer, int conf, String deckNum,
      String id) async {
    CardsListTable newPost = CardsListTable(
        question: question,
        answer: answer,
        confidence: conf,
        decklisttableID: deckNum,
        logintableID: id);
    await Amplify.DataStore.save(newPost);
  }

  Future updateCardData(String id, String question, String ans) async {
    CardsListTable deck = (await Amplify.DataStore.query(
        CardsListTable.classType,
        where: CardsListTable.ID.eq(id)))[0];
    await Amplify.DataStore.save(
        deck.copyWith(answer: ans, question: question));
  }

  Future updateConfidenceData(String id, String question, String answer,
      int confidence, String deckNum) async {
    CardsListTable deck = (await Amplify.DataStore.query(
        CardsListTable.classType,
        where: CardsListTable.ID.eq(id)))[0];
    await Amplify.DataStore.save(deck.copyWith(
        answer: answer,
        question: question,
        confidence: confidence,
        decklisttableID: deckNum));
  }

  Future <List<CardsListTable>>getCardDataForReview(String deckId, String id)async{
    List<CardsListTable> chatData = await Amplify.DataStore.query(
        CardsListTable.classType,
        where: CardsListTable.DECKLISTTABLEID
            .eq(deckId)
            .and(CardsListTable.LOGINTABLEID.eq(id)));
    return chatData;
  }

  Future insertChart(String deckNum, double percentage, String id, int good,
      int ok, int bad) async {
    ChartListTable newPost = ChartListTable(
        percentage: percentage,
        good: good,
        bad: bad,
        ok: ok,
        cardslisttableID: id);
    await Amplify.DataStore.save(newPost);
  }

  Future<List<ChartListTable>> getChartList(String deckId, String id)async{
    List<ChartListTable> chatData = await Amplify.DataStore.query(
        ChartListTable.classType,
        where: ChartListTable.
            .eq(deckId)
            .and(CardsListTable.LOGINTABLEID.eq(id)));
  }
  Future<LoginTable> addLoginData(String username, String password) async {
    LoginTable login = LoginTable(userName: username, Password: password);
    return login;
  }

  Future<List<LoginTable>> checkLogin(String username, String password) async {
    List<LoginTable> login = await Amplify.DataStore.query(LoginTable.classType,
        where: LoginTable.USERNAME
            .eq(username)
            .and(LoginTable.PASSWORD.eq(password)));
    return login;
  }
}
