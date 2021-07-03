/**
 * SxW Tools
 * Date: Jun 10 2012
 * Some Playground Tools...
 */

/** Check if the userContent.css is already registered. If so,
 * unregister and re-register it so that changes are applied to the
 * running firefox
 */
function reloadUserStyle() {

	// stylesheet service
	var sss = Components.classes["@mozilla.org/content/style-sheet-service;1"].
		getService(Components.interfaces.nsIStyleSheetService);

	// io service to access the file
	var ios = Components.classes["@mozilla.org/network/io-service;1"].
		getService(Components.interfaces.nsIIOService);

	// directory service to access the user chrome path ("UChrm")
	var chromePath = Components.classes["@mozilla.org/file/directory_service;1"].
		getService(Components.interfaces.nsIProperties).
		get("UChrm", Components.interfaces.nsIFile);

	// build the path
	var userChromePath = 'file://' + chromePath.path + '/userChrome.css';

	// URI
	var uri = ios.newURI( userChromePath, null, null );

	// if registered unregister first
	if ( sss.sheetRegistered( uri, sss.USER_SHEET ) ) {
		sss.unregisterSheet( uri, sss.USER_SHEET );
	}

	// then load and register as USER_SHEET
	sss.loadAndRegisterSheet( uri, sss.USER_SHEET );
}

reloadUserStyle();
