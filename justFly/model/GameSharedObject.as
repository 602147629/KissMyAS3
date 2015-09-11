package justFly.model {
	import com.junkbyte.console.Cc;
	import flash.net.SharedObject;
	import justFly.view.character.PlayerData;
	import justFly.view.util.JustFightUtil;
	
	/**
	 * ... 
	 * @copy        ：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author     ：g8sam « Just do it ™ »
	 * @since       ：2015/9/5 下午 12:03
	 * @version    ：1.0.2015_α(Alpha)
	 */
	
	public class GameSharedObject {
		public const KEY:int = 14;
		public const KEY2:int = 4;
		public const KEY_STR:String = "@";
		public const REGIST_TIME:int = 300000;
		
		public var so:SharedObject;
		
		private var _playerData:PlayerData;
		
		public function GameSharedObject() {
			try {
				if (this.so == null) {
					this.so = SharedObject.getLocal("justFight", "/");
					Cc.logch("GameSharedObject : " + this.so.data.charName);
				}
			} catch (e:Error) {
				Cc.logch(e.errorID);
			}
		}
		
		public function create():void {
			this._playerData = new PlayerData();
			this._playerData.id = this.so.data.id;
			this._playerData.charName = this.so.data.charName;
			this._playerData.money = this.so.data.money;
			this._playerData.lv = this.so.data.lv;
			this._playerData.exp = this.so.data.exp;
			Cc.logch(this, " =============================================== ");
			Cc.logch(this, " || create  ");
			Cc.logch(this, " =============================================== ");
		}
		
		public function newPlayer():void {
			this._playerData = new PlayerData();
			this._playerData.id = 1234567890;
			this._playerData.charName = JustFightUtil.getInstance().createChineseName();
			this._playerData.money = 0;
			this._playerData.lv = 1;
			this._playerData.exp = 0;
			this.saveData(this._playerData);
			Cc.logch(this, " =============================================== ");
			Cc.logch(this, " || 建立新人物  : " + this._playerData.charName);
			Cc.logch(this, " =============================================== ");
		}
		
		public function checkKey():Boolean {
			return this.so.data.id == undefined ? false : true;
		}
		
		public function saveData(data:PlayerData):void {
			if (this.so == null) {
				this.so = SharedObject.getLocal("justFight", "/");
			}
			
			this.so.data.id = data.id;
			this.so.data.charName = data.charName;
			this.so.data.money = data.money;
			this.so.data.lv = data.lv;
			this.so.data.exp = data.exp;
			this.codeExe();
			this.so.flush();
			Cc.logch(this, " =============================================== ");
			Cc.logch(this, " || saveData  ");
			Cc.logch(this, " =============================================== ");
		}
		
		public function codeExe():void {
			//Cc.log(this, " ============ codeExe ============ ");
			var dataCode:String = this.so.data.money + KEY2 + "," + (this.so.data.lv + KEY2) + "," + (this.so.data.exp + KEY2) + "," + (this.so.data.charName + KEY2);
			var code:String = "";
			for (var i:int = 0; i < dataCode.length; i++) {
				code = code + (dataCode.charCodeAt(i) + KEY + KEY_STR);
				
			}
			this.so.data.maru = code;
		}
		
		public function decodeExe(data:String):String {
			//Cc.log(this, " ============ decodeExe ============ ");
			
			var code:Array = data.split(KEY_STR);
			var decode:String = "";
			
			for (var i:int = 0; i < code.length - 1; i++) {
				var key:String = String(Number(code[i]) - KEY);
				decode = decode + String.fromCharCode(key);
			}
			
			return decode;
		}
		
		public function checkCode():Boolean {
			if (this.checkKey == false) {
				return true;
			}
			
			if (this.so.data.maru == undefined) {
				this.codeExe();
				return true;
			}
			
			var codeStr:String = this.decodeExe(this.so.data.maru);
			var codeAry:Array = codeStr.split(",");
			
			if (Number(codeAry[0]) - KEY2 == this.so.data.money && Number(codeAry[1]) - KEY2 == this.so.data.lv && Number(codeAry[2]) - KEY2 == this.so.data.exp) {
				return true;
			}
			
			return false;
		}
		
		public function get playerData():PlayerData {
			return _playerData;
		}
	
	}
}