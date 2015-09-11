package justFly.view.loading {
	import com.bit101.components.ProgressBar;
	import com.bit101.components.Style;
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author sam
	 */
	public class Loading extends Sprite {
		
		private var _width:Number;
        private var _height:Number;
		private var _progressBar:ProgressBar;
		private var _infoLB1:TextField;
		
		public function Loading() {
			_progressBar = new ProgressBar(this, 5, _height - 20);
            _progressBar.width = _width - 10;
            _progressBar.height = 16;
            //_progressBar.color = 563443;
            //_progressBar.gradientFillDirection = 0;
            //_progressBar.subColor = 12320767;
			addChild(_progressBar);
			
			//_infoLB1 = Config.getSimpleTextField();
            //_infoLB1.textColor = Style.WINDOW_FONT;
            //_infoLB1.filters = [new GlowFilter(0, 1, 3, 3, 1, 3)];
            //_infoLB1.x = int((_width - _infoLB1.width) / 2);
            //_infoLB1.y = _progressBar.y - 1;
			//addChild(_infoLB1);
		}
		
		public function setProgress(param1, param2) {
			var _loc_3:* = false;
			var _loc_4:* = undefined;
			var _loc_5:* = undefined;
			var _loc_6:* = undefined;
			var _loc_7:* = null;
			var _loc_8:* = null;
			var _loc_9:* = null;
			var _loc_10:* = null;
			var _loc_11:* = null;
			var _loc_12:* = undefined;
			var _loc_13:* = undefined;
			var _loc_14:* = undefined;
			var _loc_15:* = null;
			
			if (this != null) {
				_loc_3 = false;
				//if (_bgURL == "stuff/pic/loading/1.jpg" || _bgURL == "stuff/pic/loading/2.jpg" || _bgURL == "stuff/pic/loading/3.jpg") {
					//_loc_3 = true;
				//}
				if (!_loc_3) {
					_loc_4 = param1 / param2;
					_loc_5 = _loc_4 * 200;
					_loc_6 = Math.floor((_loc_5 - 20) / _loc_5 * 255);
					_loc_7 = GradientType.RADIAL;
					_loc_8 = [16711680, 16711680];
					_loc_9 = [1, 0];
					_loc_10 = [_loc_6, 255];
					_loc_11 = new Matrix();
					_loc_12 = int((-_loc_5) / 2);
					_loc_13 = 2;
					_loc_14 = int((-_loc_13) / 2);
					_loc_11.createGradientBox(_loc_5, _loc_13, 0, _loc_12, _loc_14);
					_loc_15 = SpreadMethod.PAD;
					_progressBar.value = _loc_4;
					//_infoLB1.text = "Loading " + int(_loc_4 * 100) + " %";
					//_infoLB1.x = int((_width - _infoLB1.width) / 2);
				} else {
					//_barMask.scaleX = param1 / param2;
				}
			}
			return;
		}
	
	}

}