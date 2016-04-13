function isALetter (char){
  return /^[a-zA-Z]*$/.test(char);
}

function caesarCipher (message, shift) {

  shift = typeof shift !== 'undefined' ? shift : -3;
  var result = "";
  for (var i = 0, length = message.length; i < length; i++) {
    if(!isALetter(message.charAt(i))) {
      result += message.charAt(i);
    }
    else {
      var a_code = "a".charCodeAt(0);
      var z_code = "z".charCodeAt(0);
      key = message.charCodeAt(i)
      if(key+shift < a_code){
        result += String.fromCharCode(z_code-(a_code-key+shift));
      }
      else if (key+shift > z_code) {
        result += String.fromCharCode(a_code-1+(key+shift-z_code));
      }
      else {
        result += String.fromCharCode(key+shift);
      }
    }
  }

  return result;
}

var encrypted = caesarCipher("Et tu, brute?", 6);

console.log(encrypted);
