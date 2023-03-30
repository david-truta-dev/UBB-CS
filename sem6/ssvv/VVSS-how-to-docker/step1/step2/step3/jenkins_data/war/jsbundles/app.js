/******/ (function() { // webpackBootstrap
/******/ 	"use strict";
/******/ 	var __webpack_modules__ = ({

/***/ 6508:
/***/ (function(__unused_webpack_module, __unused_webpack___webpack_exports__, __webpack_require__) {


;// CONCATENATED MODULE: ./src/main/js/util/symbols.js
const INFO = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path d="M256 56C145.72 56 56 145.72 56 256s89.72 200 200 200 200-89.72 200-200S366.28 56 256 56zm0 82a26 26 0 11-26 26 26 26 0 0126-26zm48 226h-88a16 16 0 010-32h28v-88h-16a16 16 0 010-32h32a16 16 0 0116 16v104h28a16 16 0 010 32z" fill='currentColor' /></svg>`;
const SUCCESS = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path d="M256 48C141.31 48 48 141.31 48 256s93.31 208 208 208 208-93.31 208-208S370.69 48 256 48zm108.25 138.29l-134.4 160a16 16 0 01-12 5.71h-.27a16 16 0 01-11.89-5.3l-57.6-64a16 16 0 1123.78-21.4l45.29 50.32 122.59-145.91a16 16 0 0124.5 20.58z" fill='currentColor'/></svg>`;
const WARNING = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path d="M449.07 399.08L278.64 82.58c-12.08-22.44-44.26-22.44-56.35 0L51.87 399.08A32 32 0 0080 446.25h340.89a32 32 0 0028.18-47.17zm-198.6-1.83a20 20 0 1120-20 20 20 0 01-20 20zm21.72-201.15l-5.74 122a16 16 0 01-32 0l-5.74-121.95a21.73 21.73 0 0121.5-22.69h.21a21.74 21.74 0 0121.73 22.7z" fill='currentColor'/></svg>`;
const ERROR = `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><path d="M256 48C141.31 48 48 141.31 48 256s93.31 208 208 208 208-93.31 208-208S370.69 48 256 48zm0 319.91a20 20 0 1120-20 20 20 0 01-20 20zm21.72-201.15l-5.74 122a16 16 0 01-32 0l-5.74-121.94v-.05a21.74 21.74 0 1143.44 0z" fill='currentColor'/></svg>`;
;// CONCATENATED MODULE: ./src/main/js/util/dom.js
function createElementFromHtml(html) {
  const template = document.createElement("template");
  template.innerHTML = html.trim();
  return template.content.firstElementChild;
}
function toId(string) {
  return string.trim().replace(/[\W_]+/g, "-").toLowerCase();
}
;// CONCATENATED MODULE: ./src/main/js/components/notifications/index.js


function init() {
  window.notificationBar = {
    OPACITY: 1,
    DELAY: 3000,
    // milliseconds to auto-close the notification
    div: null,
    // the main 'notification-bar' DIV
    token: null,
    // timer for cancelling auto-close
    defaultIcon: INFO,
    defaultAlertClass: "jenkins-notification",
    SUCCESS: {
      alertClass: "jenkins-notification jenkins-notification--success",
      icon: SUCCESS
    },
    WARNING: {
      alertClass: "jenkins-notification jenkins-notification--warning",
      icon: WARNING
    },
    ERROR: {
      alertClass: "jenkins-notification jenkins-notification--error",
      icon: ERROR,
      sticky: true
    },
    init: function () {
      if (this.div == null) {
        this.div = document.createElement("div");
        this.div.id = "notification-bar";
        document.body.insertBefore(this.div, document.body.firstElementChild);
        const self = this;
        this.div.onclick = function () {
          self.hide();
        };
      } else {
        this.div.innerHTML = "";
      }
    },
    // cancel pending auto-hide timeout
    clearTimeout: function () {
      if (this.token) {
        window.clearTimeout(this.token);
      }
      this.token = null;
    },
    // hide the current notification bar, if it's displayed
    hide: function () {
      this.clearTimeout();
      this.div.classList.remove("jenkins-notification--visible");
      this.div.classList.add("jenkins-notification--hidden");
    },
    // show a notification bar
    show: function (text, options) {
      options = options || {};
      this.init();
      this.div.appendChild(createElementFromHtml(options.icon || this.defaultIcon));
      const message = this.div.appendChild(document.createElement("span"));
      message.appendChild(document.createTextNode(text));
      this.div.className = options.alertClass || this.defaultAlertClass;
      this.div.classList.add("jenkins-notification--visible");
      this.clearTimeout();
      const self = this;
      if (!options.sticky) {
        this.token = window.setTimeout(function () {
          self.hide();
        }, this.DELAY);
      }
    }
  };
}
/* harmony default export */ var notifications = ({
  init
});
;// CONCATENATED MODULE: ./src/main/js/util/keyboard.js
/**
 * @param {Element} container - the container for the items
 * @param {function(): NodeListOf<Element>} itemsFunc - function which returns the list of items
 * @param {string} selectedClass - the class to apply to the selected item
 */
function makeKeyboardNavigable(container, itemsFunc, selectedClass) {
  window.addEventListener("keydown", e => {
    let items = itemsFunc();
    let selectedItem = Array.from(items).find(a => a.classList.contains(selectedClass));
    const isVisible = window.getComputedStyle(container).visibility === "visible";

    // Only navigate through the list of items if the container is active on the screen
    if (container && isVisible) {
      if (e.key === "ArrowDown") {
        var _selectedItem;
        if (selectedItem) {
          selectedItem.classList.remove(selectedClass);
          const next = selectedItem.nextSibling;
          if (next) {
            selectedItem = next;
          } else {
            selectedItem = items[0];
          }
        } else {
          selectedItem = items[0];
        }
        (_selectedItem = selectedItem) === null || _selectedItem === void 0 ? void 0 : _selectedItem.classList.add(selectedClass);
      } else if (e.key === "ArrowUp") {
        var _selectedItem2;
        if (selectedItem) {
          selectedItem.classList.remove(selectedClass);
          const previous = selectedItem.previousSibling;
          if (previous) {
            selectedItem = previous;
          } else {
            selectedItem = items[items.length - 1];
          }
        } else {
          selectedItem = items[items.length - 1];
        }
        (_selectedItem2 = selectedItem) === null || _selectedItem2 === void 0 ? void 0 : _selectedItem2.classList.add(selectedClass);
      } else if (e.key === "Enter") {
        var _selectedItem3;
        (_selectedItem3 = selectedItem) === null || _selectedItem3 === void 0 ? void 0 : _selectedItem3.click();
      }
    }
  });
}
;// CONCATENATED MODULE: ./src/main/js/util/security.js
function xmlEscape(str) {
  return str.replace(/[<>&'"]/g, match => {
    switch (match) {
      case "<":
        return "&lt;";
      case ">":
        return "&gt;";
      case "&":
        return "&amp;";
      case "'":
        return "&apos;";
      case '"':
        return "&quot;";
    }
  });
}

;// CONCATENATED MODULE: ./src/main/js/components/search-bar/index.js



const SELECTED_CLASS = "jenkins-search__results-item--selected";
function search_bar_init() {
  const searchBarInputs = document.querySelectorAll(".jenkins-search__input");
  Array.from(searchBarInputs).filter(searchBar => searchBar.suggestions).forEach(searchBar => {
    const searchWrapper = searchBar.parentElement.parentElement;
    const searchResultsContainer = createElementFromHtml(`<div class="jenkins-search__results-container"></div>`);
    searchWrapper.appendChild(searchResultsContainer);
    const searchResults = createElementFromHtml(`<div class="jenkins-search__results"></div>`);
    searchResultsContainer.appendChild(searchResults);
    searchBar.addEventListener("input", () => {
      const query = searchBar.value.toLowerCase();

      // Hide the suggestions if the search query is empty
      if (query.length === 0) {
        hideResultsContainer();
        return;
      }
      showResultsContainer();
      function appendResults(container, results) {
        results.forEach((item, index) => {
          container.appendChild(createElementFromHtml(`<a class="${index === 0 ? SELECTED_CLASS : ""}" href="${item.url}"><div>${item.icon}</div>${xmlEscape(item.label)}</a>`));
        });
        if (results.length === 0 && container === searchResults) {
          container.appendChild(createElementFromHtml(`<p class="jenkins-search__results__no-results-label">No results</p>`));
        }
      }

      // Filter results
      const results = searchBar.suggestions().filter(item => item.label.toLowerCase().includes(query)).slice(0, 5);
      searchResults.innerHTML = "";
      appendResults(searchResults, results);
      searchResultsContainer.style.height = searchResults.offsetHeight + "px";
    });
    function showResultsContainer() {
      searchResultsContainer.classList.add("jenkins-search__results-container--visible");
    }
    function hideResultsContainer() {
      searchResultsContainer.classList.remove("jenkins-search__results-container--visible");
      searchResultsContainer.style.height = "1px";
    }
    searchBar.addEventListener("keydown", e => {
      if (e.key === "ArrowUp" || e.key === "ArrowDown") {
        e.preventDefault();
      }
    });
    makeKeyboardNavigable(searchResultsContainer, () => searchResults.querySelectorAll("a"), SELECTED_CLASS);

    // Workaround: Firefox doesn't update the dropdown height correctly so
    // let's bind the container's height to it's child
    // Disabled in HtmlUnit
    if (!window.isRunAsTest) {
      new ResizeObserver(() => {
        searchResultsContainer.style.height = searchResults.offsetHeight + "px";
      }).observe(searchResults);
    }
    searchBar.addEventListener("focusin", () => {
      if (searchBar.value.length !== 0) {
        searchResultsContainer.style.height = searchResults.offsetHeight + "px";
        showResultsContainer();
      }
    });
    document.addEventListener("click", event => {
      if (searchWrapper.contains(event.target)) {
        return;
      }
      hideResultsContainer();
    });
  });
}
/* harmony default export */ var search_bar = ({
  init: search_bar_init
});
// EXTERNAL MODULE: ./.yarn/cache/tippy.js-npm-6.3.7-424f946d38-cac955318a.zip/node_modules/tippy.js/dist/tippy.esm.js + 16 modules
var tippy_esm = __webpack_require__(1590);
;// CONCATENATED MODULE: ./src/main/js/util/behavior-shim.js
function specify(selector, id, priority, behavior) {
  // eslint-ignore-next-line
  Behaviour.specify(selector, id, priority, behavior);
}
/* harmony default export */ var behavior_shim = ({
  specify
});
;// CONCATENATED MODULE: ./src/main/js/components/tooltips/index.js


const TOOLTIP_BASE = {
  arrow: false,
  theme: "tooltip",
  animation: "tooltip",
  appendTo: document.body
};

/**
 * Registers tooltips for the given element
 * If called again, destroys any existing tooltip for the element and
 * registers them again (useful for progressive rendering)
 * @param {HTMLElement} element - Registers the tooltips for the given element
 */
function registerTooltip(element) {
  if (element._tippy) {
    element._tippy.destroy();
  }
  if (element.hasAttribute("tooltip") && !element.hasAttribute("data-html-tooltip")) {
    (0,tippy_esm/* default */.ZP)(element, Object.assign({
      content: element => element.getAttribute("tooltip").replace(/<br[ /]?\/?>|\\n/g, "\n"),
      onCreate(instance) {
        instance.reference.setAttribute("title", instance.props.content);
      },
      onShow(instance) {
        instance.reference.removeAttribute("title");
      },
      onHidden(instance) {
        instance.reference.setAttribute("title", instance.props.content);
      }
    }, TOOLTIP_BASE));
  }
  if (element.hasAttribute("data-html-tooltip")) {
    (0,tippy_esm/* default */.ZP)(element, Object.assign({
      content: element => element.getAttribute("data-html-tooltip"),
      allowHTML: true,
      onCreate(instance) {
        instance.props.interactive = instance.reference.getAttribute("data-tooltip-interactive") === "true";
      }
    }, TOOLTIP_BASE));
  }
}

/**
 * Displays a tooltip for three seconds on the provided element after interaction
 * @param {string} text - The tooltip text
 * @param {HTMLElement} element - The element to show the tooltip
 */
function hoverNotification(text, element) {
  const tooltip = (0,tippy_esm/* default */.ZP)(element, Object.assign({
    trigger: "hover",
    offset: [0, 0],
    content: text,
    onShow(instance) {
      setTimeout(() => {
        instance.hide();
      }, 3000);
    }
  }, TOOLTIP_BASE));
  tooltip.show();
}
function tooltips_init() {
  behavior_shim.specify("[tooltip], [data-html-tooltip]", "-tooltip-", 1000, element => {
    registerTooltip(element);
  });
  window.hoverNotification = hoverNotification;
}
/* harmony default export */ var tooltips = ({
  init: tooltips_init
});
;// CONCATENATED MODULE: ./src/main/js/app.js



notifications.init();
search_bar.init();
tooltips.init();

/***/ })

/******/ 	});
/************************************************************************/
/******/ 	// The module cache
/******/ 	var __webpack_module_cache__ = {};
/******/ 	
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/ 		// Check if module is in cache
/******/ 		var cachedModule = __webpack_module_cache__[moduleId];
/******/ 		if (cachedModule !== undefined) {
/******/ 			return cachedModule.exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = __webpack_module_cache__[moduleId] = {
/******/ 			// no module.id needed
/******/ 			// no module.loaded needed
/******/ 			exports: {}
/******/ 		};
/******/ 	
/******/ 		// Execute the module function
/******/ 		__webpack_modules__[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/ 	
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/ 	
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = __webpack_modules__;
/******/ 	
/************************************************************************/
/******/ 	/* webpack/runtime/chunk loaded */
/******/ 	!function() {
/******/ 		var deferred = [];
/******/ 		__webpack_require__.O = function(result, chunkIds, fn, priority) {
/******/ 			if(chunkIds) {
/******/ 				priority = priority || 0;
/******/ 				for(var i = deferred.length; i > 0 && deferred[i - 1][2] > priority; i--) deferred[i] = deferred[i - 1];
/******/ 				deferred[i] = [chunkIds, fn, priority];
/******/ 				return;
/******/ 			}
/******/ 			var notFulfilled = Infinity;
/******/ 			for (var i = 0; i < deferred.length; i++) {
/******/ 				var chunkIds = deferred[i][0];
/******/ 				var fn = deferred[i][1];
/******/ 				var priority = deferred[i][2];
/******/ 				var fulfilled = true;
/******/ 				for (var j = 0; j < chunkIds.length; j++) {
/******/ 					if ((priority & 1 === 0 || notFulfilled >= priority) && Object.keys(__webpack_require__.O).every(function(key) { return __webpack_require__.O[key](chunkIds[j]); })) {
/******/ 						chunkIds.splice(j--, 1);
/******/ 					} else {
/******/ 						fulfilled = false;
/******/ 						if(priority < notFulfilled) notFulfilled = priority;
/******/ 					}
/******/ 				}
/******/ 				if(fulfilled) {
/******/ 					deferred.splice(i--, 1)
/******/ 					var r = fn();
/******/ 					if (r !== undefined) result = r;
/******/ 				}
/******/ 			}
/******/ 			return result;
/******/ 		};
/******/ 	}();
/******/ 	
/******/ 	/* webpack/runtime/define property getters */
/******/ 	!function() {
/******/ 		// define getter functions for harmony exports
/******/ 		__webpack_require__.d = function(exports, definition) {
/******/ 			for(var key in definition) {
/******/ 				if(__webpack_require__.o(definition, key) && !__webpack_require__.o(exports, key)) {
/******/ 					Object.defineProperty(exports, key, { enumerable: true, get: definition[key] });
/******/ 				}
/******/ 			}
/******/ 		};
/******/ 	}();
/******/ 	
/******/ 	/* webpack/runtime/global */
/******/ 	!function() {
/******/ 		__webpack_require__.g = (function() {
/******/ 			if (typeof globalThis === 'object') return globalThis;
/******/ 			try {
/******/ 				return this || new Function('return this')();
/******/ 			} catch (e) {
/******/ 				if (typeof window === 'object') return window;
/******/ 			}
/******/ 		})();
/******/ 	}();
/******/ 	
/******/ 	/* webpack/runtime/hasOwnProperty shorthand */
/******/ 	!function() {
/******/ 		__webpack_require__.o = function(obj, prop) { return Object.prototype.hasOwnProperty.call(obj, prop); }
/******/ 	}();
/******/ 	
/******/ 	/* webpack/runtime/runtimeId */
/******/ 	!function() {
/******/ 		__webpack_require__.j = 143;
/******/ 	}();
/******/ 	
/******/ 	/* webpack/runtime/jsonp chunk loading */
/******/ 	!function() {
/******/ 		// no baseURI
/******/ 		
/******/ 		// object to store loaded and loading chunks
/******/ 		// undefined = chunk not loaded, null = chunk preloaded/prefetched
/******/ 		// [resolve, reject, Promise] = chunk loading, 0 = chunk loaded
/******/ 		var installedChunks = {
/******/ 			143: 0
/******/ 		};
/******/ 		
/******/ 		// no chunk on demand loading
/******/ 		
/******/ 		// no prefetching
/******/ 		
/******/ 		// no preloaded
/******/ 		
/******/ 		// no HMR
/******/ 		
/******/ 		// no HMR manifest
/******/ 		
/******/ 		__webpack_require__.O.j = function(chunkId) { return installedChunks[chunkId] === 0; };
/******/ 		
/******/ 		// install a JSONP callback for chunk loading
/******/ 		var webpackJsonpCallback = function(parentChunkLoadingFunction, data) {
/******/ 			var chunkIds = data[0];
/******/ 			var moreModules = data[1];
/******/ 			var runtime = data[2];
/******/ 			// add "moreModules" to the modules object,
/******/ 			// then flag all "chunkIds" as loaded and fire callback
/******/ 			var moduleId, chunkId, i = 0;
/******/ 			if(chunkIds.some(function(id) { return installedChunks[id] !== 0; })) {
/******/ 				for(moduleId in moreModules) {
/******/ 					if(__webpack_require__.o(moreModules, moduleId)) {
/******/ 						__webpack_require__.m[moduleId] = moreModules[moduleId];
/******/ 					}
/******/ 				}
/******/ 				if(runtime) var result = runtime(__webpack_require__);
/******/ 			}
/******/ 			if(parentChunkLoadingFunction) parentChunkLoadingFunction(data);
/******/ 			for(;i < chunkIds.length; i++) {
/******/ 				chunkId = chunkIds[i];
/******/ 				if(__webpack_require__.o(installedChunks, chunkId) && installedChunks[chunkId]) {
/******/ 					installedChunks[chunkId][0]();
/******/ 				}
/******/ 				installedChunks[chunkId] = 0;
/******/ 			}
/******/ 			return __webpack_require__.O(result);
/******/ 		}
/******/ 		
/******/ 		var chunkLoadingGlobal = self["webpackChunkjenkins_ui"] = self["webpackChunkjenkins_ui"] || [];
/******/ 		chunkLoadingGlobal.forEach(webpackJsonpCallback.bind(null, 0));
/******/ 		chunkLoadingGlobal.push = webpackJsonpCallback.bind(null, chunkLoadingGlobal.push.bind(chunkLoadingGlobal));
/******/ 	}();
/******/ 	
/******/ 	/* webpack/runtime/nonce */
/******/ 	!function() {
/******/ 		__webpack_require__.nc = undefined;
/******/ 	}();
/******/ 	
/************************************************************************/
/******/ 	
/******/ 	// startup
/******/ 	// Load entry module and return exports
/******/ 	// This entry module depends on other loaded chunks and execution need to be delayed
/******/ 	var __webpack_exports__ = __webpack_require__.O(undefined, [216], function() { return __webpack_require__(6508); })
/******/ 	__webpack_exports__ = __webpack_require__.O(__webpack_exports__);
/******/ 	
/******/ })()
;
//# sourceMappingURL=app.js.map