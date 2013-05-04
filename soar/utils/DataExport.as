package soar.utils {
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class DataExport {
		private static var dataMsg:String = "";
		
		public static function init():void {
			dataMsg = "";
		}
		
		public static function addDataTxt(str:Object = "", blen:Boolean = true):void {
			if (blen) {
				dataMsg = addTxt(str + "\n");
			} else {
				dataMsg = addTxt(str);
			}
		}
		
		private static function addTxt(str:Object):String {
			return dataMsg += str;
		}
		
		public static function getDataSource():String {
			return dataMsg;
		}
		
		//寫入文字檔
		public static function writeTxtData(fileName:String):void {
			var _bytearray:ByteArray = new ByteArray;
			_bytearray.writeMultiByte(dataMsg, "");
			var fileRef:FileReference = new FileReference();
			
			try {
				trace("save:" + fileName);
				fileRef.save(_bytearray, fileName + ".txt");
			} catch (e:Error) {
				trace("save:" + "_" + fileName);
				return writeTxtData("_" + fileName);
			}
		}
	}
}