var Utils = {
  randomNumber: function (min, max){
    return Math.floor(Math.random() * (max - min)) + min;
  },
  generateSaxons: function (){
    saxons = [];
    random = Utils.randomNumber(5,10);
    for (var i = 0; i < random; i++) {
      saxons.push(new Saxon());
    }
    return saxons;
  },
  attackSomeone: function (self, enemy) {
    enemy.health -= self.strength;
    console.log(self.name + " attacks " + enemy.name);
    if(enemy.health <= 0){
      enemy.alive = false;
      console.log(enemy.name + " dies");
    }
    else{
      console.log(enemy.name + " health: " + enemy.health);
    }
  },
  generateRandomWarCry: function(){
    var warCries = [
      "This is a good day for someone else to die!",
      "I'll feed your head to my dogs!",
      "It's clobberin' time!",
      "Entaro Tassadar!",
      "Al turróoooooon!",
      "Death and Glory!",
    ];
    var randomIndex = Utils.randomNumber(0,warCries.length);
    return warCries[randomIndex];
  }
};

var Side = function (name, members){
  this.name = name;
  this.members = members;
  this.initialMembers = members.length;
  this.getRandomFighterIndex = function() {
    return Utils.randomNumber(0, this.members.length);
  }
  this.removeADied = function(index){
    this.members.splice(index, 1);
  }
  this.casualtiesPercentage = function(){
    return (this.members.length / this.initialMembers) * 100;
  }
}

var Viking = function (name, health, strength) {
  this.alive = true;
  this.name = name;
  this.health = health;
  this.strength = strength;
  this.warCry = Utils.generateRandomWarCry();
  this.attack = function(enemy) {
    Utils.attackSomeone(this, enemy);
  }
};

var Saxon = function () {
  var min_health = 10;
  var max_health = 40;
  var min_strength = 6;
  var max_strength = 14;
  this.alive = true;
  this.name = "a saxon";
  this.health = Utils.randomNumber(min_health,max_health);
  this.strength = Utils.randomNumber(min_strength, max_strength);
  this.attack = function(enemy) {
    Utils.attackSomeone(this, enemy);
  }
};

var VikingPit = function (vikings) {
  var min_turns = 5;
  var max_turns = 8;
  this.gameOver = false;
  this.vikings = vikings;
  this.currentTurn = 0;
  this.turns = Utils.randomNumber(min_turns, max_turns)
  this.closeToDeath = function(){
    return vikings[0].strength > vikings[1].health &&
      vikings[1].strength > vikings[0].health
  }
  this.nextTurn = function(){
    if(this.currentTurn < this.turns && !this.closeToDeath()){
      vikings[0].attack(vikings[1]);
      vikings[1].attack(vikings[0]);
      this.currentTurn++;
    }
    else {
      this.gameOver = true;
      console.log("Stop!!! Stop!!! This is just a preparation!");
    }
  }
  this.simulate = function() {
    while(!this.gameOver){
      this.nextTurn();
    }
  }
};

var Assault = function(vikings){
  var min_turns = 5;
  var max_turns = 8;
  this.gameOver = false;
  this.winner = function(sides){
    var sorted = sides.sort(
      function(a, b){
        return b.casualtiesPercentage()-a.casualtiesPercentage();
      });
    return sorted[0];
  }
  this.saxonsSide = new Side("Saxons",Utils.generateSaxons());
  this.vikingsSide = new Side("Vikings",vikings);
  this.currentTurn = 0;
  this.turns = Utils.randomNumber(min_turns, max_turns);
  this.vikingsShouts = function(){
    console.log("The real battle starts now!!!");
    this.vikingsSide.members.forEach(function(viking){
      console.log(viking.name +": '" + viking.warCry + "'");
    });
  }
  this.nextTurn = function(){
    var saxonIndex = this.saxonsSide.getRandomFighterIndex();
    var vikingIndex = this.vikingsSide.getRandomFighterIndex();
    if(this.currentTurn < this.turns
      && this.vikingsSide.members.length > 0
      && this.saxonsSide.members.length > 0){
      this.vikingsSide.members[vikingIndex].attack(this.saxonsSide.members[saxonIndex]);
      if(!this.saxonsSide.members[saxonIndex].alive){
        this.saxonsSide.removeADied(saxonIndex);
      }
      else{
        this.saxonsSide.members[saxonIndex].attack(this.vikingsSide.members[vikingIndex]);
        if(!this.vikingsSide.members[vikingIndex].alive){
          this.vikingsSide.removeADied(vikingIndex);
        }
      }
      this.currentTurn++;
    }
    else {
      this.gameOver = true;
      console.log("The assault has finished!");
      console.log(this.winner([this.saxonsSide,this.vikingsSide]).name + " win!");
    }
  }
  this.simulate = function() {
    this.vikingsShouts();
    while(!this.gameOver){
      this.nextTurn();
    }
  }
}

var Game = function (battles) {
  this.battles  = battles;
  this.simulate = function(){
    battles.forEach(function(battle){
      battle.simulate();
    });
  }
}

var david = new Viking("David",100,10);
var oriol = new Viking("Oriol",90,12);
var charlie = new Viking("Charlie",50,22);
var matias = new Viking("Matias",70,13);
var vikings = [david, oriol, charlie, matias];
var vikingPit = new VikingPit(vikings);
var assault = new Assault(vikings);
var game = new Game([vikingPit,assault]);
game.simulate();
