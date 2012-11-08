$(document).ready ->
	authHash = $.deparam.fragment()
	if authHash.access_token
		$.cookie("access_token", authHash.access_token, {expires: authHash.expires_in})
	else
		$.cookie("access_denied", true)
	window.location.replace("http://"+window.location.host+$.cookie('requested_url'))
