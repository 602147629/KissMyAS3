package justFly.view.item {
	
	/**
	 * ... 道具資料
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class ItemData {
		
		private var _id:int = 0;
		private var _itemName:String = "";
		private var _amount:int = 0;
		private var _explain:String;
		private var _price:int;
		private var _sell:int;
		private var _type:String;
		private var _curLvl:int;
		private var _maxLvl:int;
		
		public function ItemData() {
		
		}
		
		/**
		 * 編號
		 */
		public function get id():int {
			return _id;
		}
		
		public function set id(value:int):void {
			_id = value;
		}
		
		/**
		 * 名稱
		 */
		public function get itemName():String {
			return _itemName;
		}
		
		public function set itemName(value:String):void {
			_itemName = value;
		}
		
		/**
		 * 數量
		 */
		public function get amount():int {
			return _amount;
		}
		
		public function set amount(value:int):void {
			_amount = value;
		}
		
		/**
		 * 說明
		 */
		public function get explain():String {
			return _explain;
		}
		
		public function set explain(value:String):void {
			_explain = value;
		}
		
		/**
		 * 價格
		 */
		public function get price():int {
			return _price;
		}
		
		public function set price(value:int):void {
			_price = value;
		}
		
		/**
		 * 賣價
		 */
		public function get sell():int {
			return _sell;
		}
		
		public function set sell(value:int):void {
			_sell = value;
		}
		
		/**
		 * 類型
		 */
		public function get type():String {
			return _type;
		}
		
		public function set type(value:String):void {
			_type = value;
		}
	
	}

}