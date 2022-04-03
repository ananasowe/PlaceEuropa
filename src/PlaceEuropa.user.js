// ==UserScript==
// @name         r/PlaceEuropa overlay
// @namespace    http://tampermonkey.net/
// @version      1.2
// @description  r/PlaceEuropa + r/PlaceEU joined effort to create a map of Europe!
// @author       Ananas (original code from other subreddits, modified)
// @match        https://hot-potato.reddit.com/embed*
// @icon         https://raw.githubusercontent.com/nowe-konto/PlaceEuropa/main/resources/logo.png
// @updateURL    https://raw.githubusercontent.com/nowe-konto/PlaceEuropa/main/src/PlaceEuropa.user.js
// @downloadURL  https://raw.githubusercontent.com/nowe-konto/PlaceEuropa/main/src/PlaceEuropa.user.js
// @grant        none
// ==/UserScript==
if (window.top !== window.self) {
    window.addEventListener('load', () => {
            document.getElementsByTagName("mona-lisa-embed")[0].shadowRoot.children[0].getElementsByTagName("mona-lisa-canvas")[0].shadowRoot.children[0].appendChild(
              (function () {
                  const i = document.createElement("img");
                  i.src = "https://raw.githubusercontent.com/nowe-konto/PlaceEuropa/main/resources/map.png";
                  i.setAttribute("class", "placeeuropa_overlay");
                  i.style = "position: absolute; left: 0; top: 0; image-rendering: pixelated; width: 2000px; height: 2000px;";
                  console.log(i);
                  return i;
              })());
    }, false);
  
    document.onkeydown = function(e) {
      const overlay = document.getElementsByTagName("mona-lisa-embed")[0].shadowRoot.children[0].getElementsByTagName("mona-lisa-canvas")[0].shadowRoot.children[0].getElementsByClassName("placeeuropa_overlay")[0];
      if (e.key == "h") {
          if (overlay.style.display) {
            overlay.style.removeProperty('display');
          } else {
            overlay.style.display = "none";
          }
      }
    }
}
