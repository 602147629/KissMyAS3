var doc = fl.getDocumentDOM();
var lib = doc.library;
var len = lib.items.length;

for(var i = 0; i < len ; i ++){
	var items = lib.items[i];
	
	if(items.itemType == "bitmap"){
		items.compressionType = "photo";
		items.useImportedJPEGQuality = false;
		items.quality = 50;
		items.useDeblocking = true;
	}
}