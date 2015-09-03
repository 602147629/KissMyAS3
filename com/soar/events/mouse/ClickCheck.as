
package {
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	
	/**
	 * 頻繁點擊檢測類：ClickCheck
	 */
	public class ClickCheck {
		private var oldClickTime:Number = 0;
		private var clickNum:uint = 0;
		private var totalNum:uint;
		private var timeOff:Number;
		private static var instance:ClickCheck;
		
		public function ClickCheck() {
		}
		
		public static function toCheck(_target:Sprite, _totalNum:uint = 3, _timeOff:Number = 0.4):void {
			if (instance == null) {
				instance = new ClickCheck();
			}
			instance.totalNum = _totalNum;
			instance.timeOff = _timeOff;
			_target.addEventListener(MouseEvent.CLICK, instance.cClick);
		}
		
		private function cClick(evt:MouseEvent):void {
			var clickTime:Number = getTimer() * 0.001;
			if (oldClickTime != 0 && (clickTime - oldClickTime) <= instance.timeOff) {
				trace("[one fast click]");
				if (clickNum < instance.totalNum) {
					clickNum++;
				}
				if (clickNum == instance.totalNum) {
					trace("[----no more fast click]");
					clickNum = 0;
				}
			} else {
				clickNum = 0;
			}
			oldClickTime = clickTime;
		}
	}
}