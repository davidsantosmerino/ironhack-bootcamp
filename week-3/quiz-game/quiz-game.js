var read = require('read');

var User = function(name){
  this.name = name;
  this.currentQuestion = 0;
  this.points = 0;
}

var Question = function(id, text, answer) {
  this.id = id;
  this.text = text;
  this.answer = answer;
  this.points = 1;
}

var Quiz = function(questions){
  var users = [];
  var currentQuestion = 0;
  var points = 0;
  var setBonusQuestion = function() {
    var index = Math.floor(Math.random() * questions.length);
    questions[index].points *= 2;
  }

  var registerUser = function(){
    var options = {
        prompt: "What's your name?\n"
    }
    read(options, newUser);
    function newUser (err, username){
      users.push(new User(username));
      console.log("You've been registered!\n");
      start();
    }
  }

  var loginUser = function(){
    var options = {
        prompt: "Type your name...\n"
    }
    read(options, checkUser);
    function checkUser(err, username){
      var searchUser= users.filter(
        function(user){
          return user.name = username;
        }
      )
      if(searchUser.length > 0){
        start();
      }
      else{
        console.log("Uuups, we can't find any user with this name...\n");
        askLogin();
      }
    }
  }

  var askLogin = function(){
    var options = {
        prompt: "New user?\n"
    }
    read(options, checkRegistration);
    function checkRegistration (err, answer){
      if(answer === "y"){
        registerUser();
      }
      else {
        loginUser();
      }
    }
  }

  var askQuestion = function(){
    if(currentQuestion < questions.length){
      var options = {
          prompt: questions[currentQuestion].text + "\n"
      }
      read(options, checkAnswer);
      function checkAnswer (err, answer){
        if(questions[currentQuestion].answer === answer){
          points += questions[currentQuestion].points;
        }
        currentQuestion++;
        askQuestion();
        }
      }
    else{
      console.log("The quiz has finished!");
      console.log("Points: " + points);
    }
  }
  var start = function(){
    setBonusQuestion();
    askQuestion();
  }

  askLogin();
}

var q1 = new Question(1,"OK?","OK");
var q2 = new Question(2,"No?","No");
var quiz = new Quiz([q1,q2]);
