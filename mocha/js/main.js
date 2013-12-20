/*
 * A trivial snippet of code to put under test.
 */
function appendDiv(selector) {
    var element = document.querySelector(selector);
    return element.appendChild(document.createElement('div'));
}
