/**
 * windowName transport plugin 0.9.1 for jQuery
 *
 * Thanks to Kris Zyp <http://www.sitepen.com/blog/2008/07/22/windowname-transport/>
 * for the original idea and some code. Original BSD license below.
 *
 * Licensed under GPLv3: http://www.gnu.org/licenses/gpl-3.0.txt
 * @author Marko Mrdjenovic <jquery@friedcellcollective.net>
 *
**/
/*
 Copyright (c) 2004-2008, The Dojo Foundation
 All Rights Reserved.

 Licensed under the Academic Free License version 2.1 or above OR the
 modified BSD license. For more information on Dojo licensing, see:

 http://dojotoolkit.org/license
*/
(function ($) {
	$ = $ || window.jQuery;
	var origAjax = $.ajax, idx = 0;
	$.extend({
		ajax: function (s) {
			var remote = /^(?:\w+:)?\/\/([^\/?#]+)/,
				data = '', status = '', requestDone = false,
				xhr = null, type = s.type.toUpperCase(), ival = setTimeout(function () {}, 0),
				onreadystatechange = null, success = null, complete = null,
				localdom = remote.exec(s.url);
			if (s.windowname || (type === 'POST' && localdom && localdom[1] !== location.host)) {
				xhr = function () {
					var url = '',
						frameName = '',
						defaultName = 'jQuery.windowName.transport.frame',
						wnival = setTimeout(function () {}, 0),
						frame = null, form = null,
						u = {};
					function cleanup() {
						clearTimeout(wnival);
						try {
							delete window.jQueryWindowName[frameName];
						} catch (er) {
							window.jQueryWindowName[frameName] = function () {};
						}
						setTimeout(function () {
							$(frame).remove();
							$(form).remove();
						}, 100);
					}
					function setData() {
						try {
							var data = frame.contentWindow.name;
							if (typeof data === 'string') {
								if (data === defaultName) {
									u.status = 501;
									u.statusText = 'Not Implemented';
								} else {
									u.status = 200;
									u.statusText = 'OK';
									u.responseText = data;
								}
								u.readyState = 4; // we are done now
								u.onreadystatechange();
								cleanup();
							}
						} catch (er) {}
					}
					u = {
						abort: function () {
							cleanup();
						},
						getAllResponseHeaders: function () {
							return '';
						},
						getResponseHeader: function (key) {
							return '';
						},
						open: function (m, u) {
							url = u;
							this.readyState = 1;
							this.onreadystatechange();
						},
						send: function (data) {
							if (data.indexOf('windowname=') < 0) { // tell the server we want windowname transport
								data += (data === ''? '' : '&') + 'windowname=' + (s.windowname || 'true');
							}
							// prepare frame
							frameName = "jQueryWindowName" + ('' + Math.random()).substr(2, 8);
							window.jQueryWindowName = window.jQueryWindowName || {};
							window.jQueryWindowName[frameName] = function () {};
							var fmethod = null, faction = null, ftarget = null, fsubmit = null,
								local = window.location.href.substr(0, window.location.href.indexOf('/', 8)),
								locallist = ['/robots.txt', '/crossdomain.xml'];
							form = document.createElement('form');
							if ($.browser.msie) {
								try {
									frame = document.createElement('<iframe name="' + frameName + '" onload="jQueryWindowName[\'' + frameName + '\']()">');
									$('body')[0].appendChild(frame);
								} catch (er) {
								}
							}
							if (!frame) {
								frame = document.createElement('iframe');
							}
							frame.style.display = 'none';
							window.jQueryWindowName[frameName] = frame.onload = function (interval) {
								function get_local(next) {
									var file = '';
									if (next) {
										idx += 1;
									}
									file = s.localfile? s.localfile : locallist[idx]? local + locallist[idx] : null;
									if (!file) {
										file = location.href;
									}
									return file;
								}
								function is_local() {
									var c = false;
									try {
										c = !!frame.contentWindow.location.href;
										// try to get location - if we can we're still local and have to wait some more...
									} catch (er) {
										// if we're at foreign location we're sure we can proceed
									}
									return c;
								}
								try {
									if (frame.contentWindow.location.href === 'about:blank') {
										return;
									}
								} catch (er) {}
								if (u.readyState === 3) {
									if (is_local()) {
										clearInterval(wnival);
										setData();
									} else { // if not local try other local
										frame.contentWindow.location = get_local(true);
									}
								}
								if (u.readyState === 2 && (s.windowname || !is_local())) {
									u.readyState = 3;
									u.onreadystatechange();
									frame.contentWindow.location = get_local();
								}
							};
							setTimeout(function () { // stop after 2 mins
								cleanup();
							}, 120000);
							frame.name = frameName;
							frame.id = frameName;
							if (!frame.parentNode) {
								$('body')[0].appendChild(frame);
							}
							if (type === 'GET') {
								frame.contentWindow.location.href = url + (url.indexOf('?') >= 0? '&' : '?') + data;
							} else {
								// prepare form
								function queryToObject(q) {
									var r = {},
										d = decodeURIComponent;
									$.each(q.split("&"), function (k, v) {
										if (v.length) {
											var parts = v.split('='),
												n = d(parts.shift()),
												curr = r[n];
											v = d(parts.join('='));
											if (typeof curr === 'undefined') {
												r[n] = v;
											} else {
												if (curr.constructor === Array) {
													r[n].push(v);
												} else {
													r[n] = [curr].concat(v);
												}
											}
										}
									});
									return r;
								}
								form.style.display = 'none';
								$('body')[0].appendChild(form);
								// make references to the proper stuff
								fmethod = form.method;
								faction = form.action;
								ftarget = form.target;
								fsubmit = form.submit;
								form.method = 'POST';
								form.action = url;
								form.target = frameName;
								$.each(queryToObject(data.replace(/\+/g, '%20')), function (k, v) {
									function setVal(k, v) {
										var input = document.createElement("input");
										input.type = 'hidden';
										input.name = k;
										input.value = v;
										form.appendChild(input);
									}
									if (v.constructor === Array) {
										$.each(v, function (i, v) {
											setVal(k, v);
										});
									} else {
										setVal(k, v);
									}
								});
								try {
									fmethod = form.method = 'POST';
									faction = form.action = url;
									ftarget = form.target = frameName;
								} catch (er2) {}
								frame.contentWindow.location = 'about:blank'; // opera likes this
								try {
									fsubmit();
								} catch (er3) {
									fsubmit.call(form);
								}
							}
							this.readyState = 2;
							this.onreadystatechange();
							if (frame.contentWindow) {
								frame.contentWindow.name = defaultName;
							}
						},
						setRequestHeader: function (key, value) {
						},
						onreadystatechange: function () {},
						readyState: 0,
						responseText: '',
						responseXML: null,
						status: null,
						statusText: null
					};
					return u;
				}();
				s = $.extend(true, s, $.extend(true, {}, $.ajaxSettings, s));
				if (s.data && s.processData && typeof s.data !== 'string') {
					s.data = $.param(s.data);
				}
				xhr.open(type, s.url);
				if (s.beforeSend && s.beforeSend(xhr, s) === false) {
					if (s.global) {
						$.active -= 1;
					}
					xhr.abort();
					return false;
				}
				if (s.global) {
					$.event.trigger("ajaxSend", [xhr, s]);
				}
				onreadystatechange = function (isTimeout) {
					if (!requestDone && xhr && (xhr.readyState === 4 || isTimeout === "timeout")) {
						requestDone = true;
						if (ival) {
							clearInterval(ival);
							ival = null;
						}
						status = isTimeout === 'timeout' && 'timeout' || !$.httpSuccess(xhr) && "error" || 'success';
						if (status === 'success') {
							try {
								data = $.httpData(xhr, s.dataType, s.dataFilter);
							} catch (er) {
								status = 'parsererror';
							}
						}
						if (status === 'success') {
							success();
						} else {
							$.handleError(s, xhr, status);
						}
						complete();
						xhr = null;
					}
				};
				ival = setInterval(onreadystatechange, 13);
				if (s.timeout > 0) {
					setTimeout(function () {
						if (xhr) {
							xhr.abort();
							if (!requestDone) {
								onreadystatechange("timeout");
							}
						}
					}, s.timeout);
				}
				try {
					xhr.send(s.data);
				} catch (er) {
					$.handleError(s, xhr, null, er);
				}
				success = function () {
					if (s.success) {
						s.success(data, status);
					}
					if (s.global) {
						$.event.trigger('ajaxSuccess', [xhr, s]);
					}
				};
				complete = function () {
					if (s.complete) {
						s.complete(xhr, status);
					}
					if (s.global) {
						$.event.trigger('ajaxComplete', [xhr, s]);
					}
					$.active -= 1;
					if (s.global && !$.active) {
						$.event.trigger('ajaxStop');
					}
				};
				return xhr;
			} else {
				return origAjax.apply(this, arguments);
			}
		}
	});
})();
