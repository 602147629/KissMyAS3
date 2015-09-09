package justFly.model {
	import com.junkbyte.console.Cc;
	import flash.net.SharedObject;
	import justFly.view.character.PlayerData;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2015/9/5 下午 12:03
	 * @version	：1.0.2
	 */
	
	public class GameSharedObject {
		public const KEY:int = 14;
		public const KEY2:int = 4;
		public const KEY_STR:String = "@";
		public const REGIST_TIME:int = 300000;
		
		public var _so:SharedObject;
		
		public function GameSharedObject() {
			this._so = SharedObject.getLocal("justFight", "/");
			this._so.data.id = "12259";
			this._so.data.charName = "Soar";
			this._so.data.money = 1000;
			this._so.data.lv = 19;
			this._so.data.exp = 12;
			this._so.flush();
			Cc.log(this.checkCode() ? " 資料正確 ": " 資料錯誤 ");
		}
		
		public function create(data:PlayerData):void {
			this._so = SharedObject.getLocal("justFight", "/");
			this._so.data.id = data.id;
			this._so.data.charName = data.charName;
			this._so.data.money = data.money;
			this._so.data.lv = data.lv;
			this._so.data.exp = data.exp;
			this._so.flush();
		}
		
		public function checkKey():Boolean {
			return this._so.data.id == undefined ? false : true;
		}
		
		public function saveData(data:PlayerData):void {
			this._so = SharedObject.getLocal("justFight");
			this._so.data.id = data.id;
			this._so.data.charName = data.charName;
			this._so.data.money = data.money;
			this._so.data.lv = data.lv;
			this._so.data.exp = data.exp;
			this._so.flush();
			
			this.codeExe();
			this.decodeExe(this._so.data.maru);
			Cc.log(this.checkCode() ? " 資料正確 ": " 資料錯誤 ");
		}
		
		public function loadData():void {
			trace("loadData : ");
		}
		
		public function clearData(data:PlayerData):void {
			trace("clearData : ");
		}
		
		public function codeExe():void {
			trace(" ============ codeExe ============ ");
			var dataCode:String = this._so.data.money + KEY2 + "," + (this._so.data.lv + KEY2) + "," + (this._so.data.exp + KEY2) + "," + (this._so.data.charName + KEY2);
			Cc.log("dataCode : " + dataCode);
			
			var code:String = "";
			for (var i:int = 0; i < dataCode.length; i ++ ) {
				trace( "dataCode.charCodeAt(i) : " + dataCode.charCodeAt(i) );
				code = code + (dataCode.charCodeAt(i) + KEY + KEY_STR);
				
			}
			Cc.log("Code : " + code);
			this._so.data.maru = code;
			trace(" ============ codeExe ============ ");
		}
		
		public function decodeExe(data:String):String {
			trace(" ============ decodeExe ============ ");
			
			var code:Array = data.split(KEY_STR);
			Cc.log("Code : " + code);
			var decode:String = "";
			
			for (var i:int = 0; i < code.length-1; i ++) {
				trace( "code[i] : " + code[i] );
				var key:String = String(Number(code[i]) - KEY);
				decode = decode + String.fromCharCode(key);
			}
			
			Cc.log("decode : " + decode);
			
			trace(" ============ decodeExe ============ ");
			return decode;
		}
		
		public function checkCode():Boolean {
			if (this.checkKey == false) {
				return true;
			}
			
			if (this._so.data.maru == undefined) {
				this.codeExe();
				return true;
			}
			
			var codeStr:String = this.decodeExe(this._so.data.maru);
			var codeAry:Array = codeStr.split(",");
			
			Cc.log("codeAry : " + codeAry);
			Cc.log("codeAry [0] : " + (Number(codeAry[0]) - KEY2) + " @ " + this._so.data.money);
			Cc.log("codeAry [1] : " + (Number(codeAry[1]) - KEY2) + " @ " + this._so.data.lv);
			Cc.log("codeAry [2] : " +(Number(codeAry[2]) - KEY2) + " @ " + this._so.data.exp);
			
			if (Number(codeAry[0]) - KEY2 == this._so.data.money && 
				Number(codeAry[1]) - KEY2 == this._so.data.lv &&
				Number(codeAry[2]) - KEY2 == this._so.data.exp) {
				return true;
			}
			
			return false;
		}
	
	}
}