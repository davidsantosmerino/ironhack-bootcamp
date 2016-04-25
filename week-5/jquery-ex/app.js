
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
    var phraseElem = $('.main-container p');
    var randomIndex = Math.trunc(Math.random() * phrases.length);
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
    var liElement = '<li><span class="phrase">' + phrase + '</span><span class="delete"> x </span></li>'
    phrasesList.append(liElement);
  }

$( document ).ready(function() {

  $('.js-btn-randomize-phrase').on('click', randomizePhrase);

  $('.js-input-phrase').on('keypress',function(e) {
    if (e.which == 13) {
      e.preventDefault();
      var inputValue = $(this).val();
      phrases.push(inputValue);
      $(this).val('');
      $('.preappend-phrase').text('');
      renderPhrases();
    }
  });

  $('.js-input-phrase').on('input',function(e) {
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
    $(this).toggleClass('active');
    $('.phrases-list').toggle();
    var toggleText = $(this).hasClass('active') ? 'hide' : 'show';
    $(this).text(toggleText);
  });

  start();
});
