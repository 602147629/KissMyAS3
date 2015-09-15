package justFly.model {
	import com.junkbyte.console.Cc;
	import flash.net.SharedObject;
	import justFly.view.character.PlayerData;
	import justFly.utility.JustFightUtil;
	import justFly.view.master.MasterInformation;
	
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
		
		private var _masterInfo:MasterInformation;
		
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
		
		public function clearData():void {
			this._masterInfo = new MasterInformation();
			this._masterInfo.money = 100;
			this._masterInfo.goldNum = 125;
			this._masterInfo.lv = 1;
			this._masterInfo.exp = 2;
			this._masterInfo.nextLvExp = 30;
			this._masterInfo.minEnergy = 75;
			this._masterInfo.maxEnergy = 150;
			this.saveData(this._masterInfo);
		}
		
		public function create():void {
			this._masterInfo = new MasterInformation();
			this._masterInfo.uniqueId = this.so.data.uniqueId;
			this._masterInfo.charName = this.so.data.charName;
			this._masterInfo.money = this.so.data.money;
			this._masterInfo.goldNum = this.so.data.goldNum;
			this._masterInfo.lv = this.so.data.lv;
			this._masterInfo.exp = this.so.data.exp;
			this._masterInfo.nextLvExp = this.so.data.nextLvExp;
			this._masterInfo.minEnergy = this.so.data.minEnergy;
			this._masterInfo.maxEnergy = this.so.data.maxEnergy;
			Cc.logch(this, " =============================================== ");
			Cc.logch(this, " || 讀取人物資料...  ");
			Cc.logch(this, " =============================================== ");
		}
		
		public function newMaster():void {
			this._masterInfo = new MasterInformation();
			this._masterInfo.uniqueId = 12259527;
			this._masterInfo.charName = JustFightUtil.getInstance().createChineseName();
			this._masterInfo.money = 100;
			this._masterInfo.goldNum = 125;
			this._masterInfo.lv = 1;
			this._masterInfo.exp = 10;
			this._masterInfo.nextLvExp = 60;
			this._masterInfo.minEnergy = 75;
			this._masterInfo.maxEnergy = 150;
			this.saveData(this._masterInfo);
			Cc.logch(this, " =============================================== ");
			Cc.logch(this, " || 創建新人物資料  : " + this._masterInfo.charName);
			Cc.logch(this, " =============================================== ");
		}
		
		public function checkKey():Boolean {
			return this.so.data.uniqueId == undefined ? false : true;
		}
		
		public function saveData(data:MasterInformation):void {
			if (this.so == null) {
				this.so = SharedObject.getLocal("justFight", "/");
			}
			
			this.so.data.uniqueId = data.uniqueId;
			this.so.data.charName = data.charName;
			this.so.data.money = data.money;
			this.so.data.goldNum = data.goldNum;
			this.so.data.lv = data.lv;
			this.so.data.exp = data.exp;
			this.so.data.nextLvExp = data.nextLvExp;
			this.so.data.minEnergy = data.minEnergy;
			this.so.data.maxEnergy = data.maxEnergy;
			this.codeExe();
			this.so.flush();
			Cc.logch(this, " =============================================== ");
			Cc.logch(this, " || 記錄人物資料  ");
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
		
		public function get masterInfo():MasterInformation {
			return _masterInfo;
		}
	
	}
}