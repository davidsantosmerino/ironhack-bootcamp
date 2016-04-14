var fs = require('fs');
function fileActions(err, file){
    if (err) {
      throw err;
    }
    var episodes = JSON.parse(file);
    episodes.forEach(function(episode){
      if(appearsCharacter(episode,"Jon Snow"))
        printEpisode(episode);
    });
}

function printEpisode(episode){
  console.log("Title: " + episode.title + " Episode #: " + episode.episode_number);
  console.log(episode.description);
  console.log("Rating: " + episode.rating + " " + ratingToStars(episode.rating) + "\n");
}

function ratingToStars(rating) {
  stars = "";
  for(var i = 1; i < rating; i++ ){
    stars += "*";
  }
  return stars;
}

function appearsCharacter(episode, character){
  if (episode.description.indexOf(character) == -1)
    return false;
  else
    return true;
}

fs.readFile("episodes.json", 'utf8', fileActions);
