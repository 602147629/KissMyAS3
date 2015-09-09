
/**
 * 批次更改圖片屬性的品質
 *
 * Flash IDE > 命令 > 執行命令
 *
 * 放到Commands目录：
 *	C:\Documents and Settings\Administrator\Local Settings\Application Data\Adobe\Flash CS5\en_US\Configuration\Commands
 * 在Commands菜单下就可以看到刚加入的命令了
 */

var doc = fl.getDocumentDOM();
var lib = doc.library;
var len = lib.items.length;

for(var i=0, i< len; i++){
	var item = lib.items[i];
	
	if(item.itemType === "bitmap"){
		/*
		item.compressionType = "photo";
		item.useImportedJPEGQuality = false;
		item.quality = 50;
		item.useDeblocking = true;//啟用消除馬賽克
		item.allowSmoothing = true; //允許平滑化
		*/
		
		// 壓縮品質 lossless:無損 , 
		item.compressionType = "lossless";//
	}
}