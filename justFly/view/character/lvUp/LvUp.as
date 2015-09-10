package justFly.view.character.lvUp {
	/**
	 * ...
	 * @author sam
	 */
	public class LvUp {
		
		public var upLv:int = 0;
		public var excNum:int = 0;
		
		public var LV0:int = 0;
		public var LV5:int = 50;
		public var LV10:int = 100;
		public var LV50:int = 500;
		public var LV100:int = 2000;
		public var LV300:int = 4000;
		public var LV600:int = 15000;
		public var LV1000:int = 40000;
		public var LV5000:int= 200000;
		
	
		private static var instance:LvUp;
		public static function getInstance():LvUp { return (instance ||= new LvUp); }
		public function LvUp() {if (instance) {throw new Error("Use LvUp.getInstance()");}}
		
		public function cmn(lv:int, gex:int, exc:int, max:int):int {
			var result:int = 0;
			var rank:int = Math.floor((exc + gex) / this["LV" + max]);
			
			if (lv + rank > max) {
				result = max - lv;
				trace("result : " + result);
				var _loc5:int = gex - result * this["LV" + max];
				trace("_loc5 : " + _loc5);
				result = result + this.getUpLv(lv + rank, _loc5, 0);
				trace("result : " + result);
			} else {
				result = rank;
				excNum = exc + gex - rank * this["LV" + max];
				trace("excNum : " + excNum);
			}
			
			return (result);
		}
		
		public function getUpLv(lv:int, gex:int, exc:int):int {
			if (lv < 5) {
				return (this.cmn(lv, gex, exc, 5));
			} else if (lv < 10) {
				return (this.cmn(lv, gex, exc, 10));
			} else if (lv < 50) {
				return (this.cmn(lv, gex, exc, 50));
			} else if (lv < 100) {
				return (this.cmn(lv, gex, exc, 100));
			} else if (lv < 300) {
				return (this.cmn(lv, gex, exc, 300));
			} else if (lv < 600) {
				return (this.cmn(lv, gex, exc, 600));
			} else if (lv < 1000) {
				return (this.cmn(lv, gex, exc, 1000));
			} else {
				return (this.cmn(lv, gex, exc, 5000));
			}
		}
	
	}

}