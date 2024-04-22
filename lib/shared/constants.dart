//api link collection
////////////

//GET
//POST
//UPDATE
//DELETE



void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) {
    print(match.group(0));
  });

}
//login or register token
String? token;

int currentInndex = 0 ;