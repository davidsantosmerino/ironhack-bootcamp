
  var ACTIVE_CLASS = 'active';
  var ENTER_KEY = 13;
  var phrases = [
    'Hello world!',
    'Just testing',
    'Yeeep'
  ]

  var start = function(){
    renderPhrases();
    randomizePhrase();
  }

  var randomizePhrase = function(){
    var phraseElem = $('.phrase-container .phrase');
    var randomIndex = Math.floor(Math.random() * phrases.length);
    phraseElem.text(phrases[randomIndex]);
  }

  var renderPhrases = function(){
    var phrasesList = $('.phrases-list');
    phrasesList.empty();
    phrases.forEach(function(phrase){
      appendPhrase(phrase);
    });
  }

  var appendPhrase = function(phrase){
    var phrasesList = $('.phrases-list');
    var liElem = $('<li>');
    var spanPhraseElem = $('<span>').addClass('phrase').text(phrase);
    var iDeleteElem = $('<i>').addClass('delete fa fa-times');
    liElem.append(spanPhraseElem).append(iDeleteElem);
    phrasesList.append(liElem);
  }

$( document ).ready(function() {

  $('.js-btn-randomize-phrase').on('click', randomizePhrase);

  $('.js-input-phrase').on('keypress',function(e) {
    if (e.which == ENTER_KEY) {
      e.preventDefault();
      var inputValue = $(this).val();
      phrases.push(inputValue);
      $(this).val('');
      $('.preappend-phrase').empty();
      renderPhrases();
    }
  });

  $('.js-input-phrase').on('keyup',function(e) {
    $('.preappend-phrase').text($(this).val());
  });

  $('body').on('click', '.delete', function(){
    var parentElem = $(this).parent();
    var phrase = parentElem.children('.phrase').text();
    var phraseIndex = phrases.indexOf(phrase);
    phrases.splice(phraseIndex, 1);
    renderPhrases();
  });

  $('.phrases-list-toggle').on('click', function(){
    $(this).toggleClass(ACTIVE_CLASS);
    $('.phrases-list').toggle();
    var toggleText = $(this).hasClass(ACTIVE_CLASS) ? 'hide' : 'show';
    $(this).text(toggleText);
  });

  start();
});
