exports.setCaretPosition = function(elem, caretPos) {
  elem.value = elem.value;

  if (elem !== null) {
    if (elem.createTextRange) {
      var range = elem.createTextRange();
      range.move('character', caretPos);
      range.select();
      return true;
    }
    else {
      if (elem.selectionStart || elem.selectionStart === 0) {
        elem.focus();
        elem.setSelectionRange(caretPos, caretPos);
        return true;
      }
      else {
        elem.focus();
        return false;
      }
    }
  }
}
