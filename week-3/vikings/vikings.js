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
  }
};

var Viking = function (name, health, strength) {
  this.alive = true;
  this.name = name;
  this.health = health;
  this.strength = strength;
  this.attack = function(enemy) {
    enemy.health -= this.strength;
    console.log(this.name + " attacks " + enemy.name);
    if(enemy.health <= 0){
      enemy.alive = false;
      console.log(enemy.name + " dies");
    }
    else{
      console.log(enemy.name + " health: " + enemy.health);
    }
  }
};

var Saxon = function () {
  var min_health = 10;
  var max_health = 40;
  var min_strength = 2;
  var max_strength = 5;
  this.alive = true;
  this.name = "a saxon";
  this.health = Utils.randomNumber(min_health,max_health);
  this.strength = Utils.randomNumber(min_strength, max_strength);
  this.attack = function(enemy) {
    enemy.health -= this.strength;
    console.log(this.name + " attacks " + enemy.name);
    if(enemy.health <= 0){
      enemy.alive = false;
      console.log(enemy.name + " dies");
    }
    else{
      console.log(enemy.name + " health: " + enemy.health);
    }
  }
};

var VikingPit = function (vikings) {
  var min_turns = 5;
  var max_turns = 8;
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
      console.log("Stop!!! Stop!!! This is just a preparation!");
    }
  }
};

var Assault = function(vikings){
  var min_turns = 5;
  var max_turns = 8;
  this.saxons = Utils.generateSaxons();
  this.vikings = vikings;
  this.currentTurn = 0;
  this.turns = Utils.randomNumber(min_turns, max_turns);
  this.nextTurn = function(){
    var saxonIndex = Utils.randomNumber(0, this.saxons.length);
    var vikingIndex = Utils.randomNumber(0, this.vikings.length);
    if(this.currentTurn < this.turns
      && this.vikings.length > 0
      && this.saxons.length > 0){
      this.vikings[vikingIndex].attack(this.saxons[saxonIndex]);
      if(!this.saxons[saxonIndex].alive){
        this.saxons.splice(saxonIndex, 1);
      }
      else{
        this.saxons[saxonIndex].attack(vikings[vikingIndex]);
        if(!this.vikings[vikingIndex].alive)
          this.vikings.splice(vikingIndex, 1);
      }
      this.currentTurn++;
    }
    else {
      console.log("The asssault has finished!");
      console.log("Vikings alive: " + this.vikings.length );
      console.log("Saxons alive: " + this.saxons.length );
    }
  }
}

var Game = function (battle) {
  this.battle  = battle;
  this.nextTurn = function(){
    this.battle.nextTurn();
    }
  }

var david = new Viking("David",100,10);
var oriol = new Viking("Oriol",90,12);
var vikings = [david, oriol];
var vikingPit = new VikingPit(vikings);
var assault = new Assault(vikings);
var game = new Game(assault);
