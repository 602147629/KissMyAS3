
var doc = fl.getDocumentDOM();
var lib = doc.library;

for(var i=0, item, len=lib.items.length; i< len; i++){
	item = lib.items[i];
	
	if(item.itemType === "bitmap"){
		/*
		item.compressionType = "photo";
		item.useImportedJPEGQuality = false;
		item.quality = 50;
		*/
		item.compressionType = "lossless";
	}
}