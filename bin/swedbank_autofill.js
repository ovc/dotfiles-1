// ==UserScript==
// @name        swedbank_autofill
// @namespace   https://internetbank.swedbank.se/idp/portal
// @version     1
// ==/UserScript==

// This will fill in my person number and submit the form when visinting https://internetbank.swedbank.se/bviPrivat/privat?ns=1
document.getElementById('auth:kundnummer').value = '199010211192';
document.getElementById('auth:fortsett_knapp').click();
//document.getElementsByTagName('form:challengeResponse').focus();
