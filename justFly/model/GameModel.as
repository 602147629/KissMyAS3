package justFly.model {
	import justFly.view.master.MasterInformation;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2015/9/5 下午 12:03
	 * @version	：1.0.2
	 */
	
	public class GameModel {
		
		private var _masterInfo:MasterInformation = new MasterInformation();
		
		public function GameModel() {
		}
		
		public function get masterInfo():MasterInformation {
			return _masterInfo;
		}
		
		public function set masterInfo(value:MasterInformation):void {
			_masterInfo = value;
		}
	
	}

}