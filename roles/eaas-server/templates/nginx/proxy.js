"use strict";

var fs = require("fs");
var crypto = require("crypto");
var atob = s => String.bytesFrom(s, "base64");
var hash = s => crypto.createHash("sha256").update(s).digest("hex");

function imageId(r)
{
	var uri = r.variables.request_uri;
  var ids = uri.split("/");
  return ids.length > 0 ? ids[ids.length - 1] : uri;
}

function token(r)
{
  var auth = r.headersIn['Authorization'];
  if(!auth)
        return "";

  var auth2 = atob(auth.split(/\s+/)[1]).match(/(.*?):(.*)/).slice(1);
  if (auth2[0] !== "jwt") throw undefined;
  var token = "Bearer " + auth2[1];
  // r.log("token: " + token);

  return token;
}

function destURL(r) {
  var uri = r.variables.request_uri;
  // r.log("destUrl ");
  // r.log(uri.match(/\/(https?:\/\/.+)$/)[1]);
  return uri.match(/\/(https?:\/\/.+)$/)[1];
}

