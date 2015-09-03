package soar.utils.file {
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	/**
	 * 數據導出 txt 檔
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class DataExport {
		private var dataMsg:String = "";
		
		private static var instance:DataExport;
		public static function getInstance():DataExport {return (instance ||= new DataExport);}
		
		/**
		 * 初始化
		 */
		public function init():void {
			dataMsg = "";
		}
		
		/**
		 * 增加一段文字
		 * @param	文字
		 * @param	是否換行
		 */
		public function addDataTxt(str:Object = "", blen:Boolean = true):void {
			if (blen) {
				dataMsg = addTxt(str + "\n");
			} else {
				dataMsg = addTxt(str);
			}
		}
		
		private function addTxt(str:Object):String {
			return dataMsg += str;
		}
		
		/**
		 * 取得文字資料
		 * @return	String
		 */
		public function getDataSource():String {
			return dataMsg;
		}
		
		/**
		 * 寫入文字檔
		 * @param String
		 */
		public function writeTxtData(fileName:String):void {
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