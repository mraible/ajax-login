/* --------------------------------------------------------------------------------
 * Stylesheets Switcher
 * Version 0.2
 * Author: Martin Str&ouml;m, [martin at burnfield dot com]
 * Based on a script by Paul Sowden (http://alistapart.com/stories/alternate)
 * Requires Prototype JavaScript library (http://prototype.conio.net/)
 * -------------------------------------------------------------------------------- */

var StyleSheetSwitcher = {
	initialize: function() {
		this.setActive(Cookies.read("style") || this.getPreferred());
		Event.observe(window, 'unload', this.unloadHandler.bindAsEventListener(this));
	},

	unloadHandler: function() {
		Cookies.create("style", this.getActive(), 365);
	},

	setActive: function(title) {
		$$("link").each(function(link) {
			if (link && link.getAttribute("rel").indexOf("style") != -1 && link.getAttribute("title")) {
				link.disabled = true;
				if (link.getAttribute("title") == title) link.disabled = false;
			}
		});
	},

	getActive: function() {
		var element = $$("link").detect(function(link) {
			return (
				link.getAttribute("rel").indexOf("style") != -1 &&
				link.getAttribute("title") && !link.disabled);
		});
		return element? element.getAttribute("title") : "";
	},
	
	getPreferred: function() {
		var element = $$("link").detect(function(link) {
			return (
				link.getAttribute("rel").indexOf("style") != -1 && 
				link.getAttribute("rel").indexOf("alt") == -1 &&
				link.getAttribute("title"));
		});
		return element? element.getAttribute("title") : "";
	}
};


/* --------------------------------------------------------------------------------
 * Cookies
 * -------------------------------------------------------------------------------- */

var Cookies = {
	create: function(name, value, days) {
		var string = name + "=" + value;
		if (days) {
			var date = new Date();
			date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
			string += "; expires=" + date.toGMTString();
		}
		document.cookie = string + "; path=/";
	},
	
	read: function(name) {
		var nameEQ = name + "=";
		return (document.cookie.split(/;\s*/).detect(function(cookie) {
			return (cookie.indexOf(nameEQ) == 0);
		}) || "").substr(nameEQ.length);
	},
	
	exists: function(name) {
		return this.read(name) !== "";
	}
}