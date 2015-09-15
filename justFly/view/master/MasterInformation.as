package justFly.view.master {
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2015/9/5 下午 12:03
	 * @version	：1.0.2
	 */
	
	public class MasterInformation {
		
		private var _uniqueId:int = 0;
		private var _charName:String = ""; //人物名稱
		
		private var _lv:int = 1;
		
		private var _exp:int = 0;
		private var _nextLvExp:int = 0;
		
		private var _money:int = 0;
		private var _goldNum:int = 0;//金元寶
		
		private var _minEnergy:int = 0; // 能量
		private var _maxEnergy:int = 0; // 能量
		
		//private var _headImage:String; // 代表頭像
		//private var _itemList:ItemList; // 道具清單
		//private var _equipList:EquipList; // 裝備清單
		//private var _charaterList:CharaterList; // 人物清單
		
		public function MasterInformation() {
		}
		
		/**
		 * 等級
		 */
		public function get lv():int {
			return _lv;
		}
		
		public function set lv(value:int):void {
			_lv = value;
		}
		
		/**
		 * 目前經驗值
		 */
		public function get exp():int {
			return _exp;
		}
		
		public function set exp(value:int):void {
			_exp = value;
		}
		
		/**
		 * 下一等級總經驗值
		 */
		public function get nextLvExp():int {
			return _nextLvExp;
		}
		
		public function set nextLvExp(value:int):void {
			_nextLvExp = value;
		}
		
		/**
		 * 銀幣
		 */
		public function get money():int {
			return _money;
		}
		
		public function set money(value:int):void {
			_money = value;
		}
		
		/**
		 * 金元寶
		 */
		public function get goldNum():int {
			return _goldNum;
		}
		
		public function set goldNum(value:int):void {
			_goldNum = value;
		}
		
		/**
		 * 主人公名稱
		 */
		public function get charName():String {
			return _charName;
		}
		
		public function set charName(value:String):void {
			_charName = value;
		}
		
		/**
		 * 獨特 identity
		 */
		public function get uniqueId():int {
			return _uniqueId;
		}
		
		public function set uniqueId(value:int):void {
			_uniqueId = value;
		}
		
		/**
		 *目前能量
		 */
		public function get minEnergy():int {
			return _minEnergy;
		}
		
		public function set minEnergy(value:int):void {
			_minEnergy = value;
		}
		
		/**
		 * 最大能量
		 */
		public function get maxEnergy():int {
			return _maxEnergy;
		}
		
		public function set maxEnergy(value:int):void {
			_maxEnergy = value;
		}
	
	}

}