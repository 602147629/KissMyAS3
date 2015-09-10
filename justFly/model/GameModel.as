package justFly.model {
	import justFly.view.character.PlayerData;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2015/9/5 下午 12:03
	 * @version	：1.0.2
	 */
	
	public class GameModel {
		
		private var _playerData:PlayerData = new PlayerData();
		
		public function GameModel() {
		}
		
		public function get playerData():PlayerData {
			return _playerData;
		}
		
		public function set playerData(value:PlayerData):void {
			_playerData = value;
		}
	
	}

}