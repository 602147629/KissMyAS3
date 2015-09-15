package justFly.utility {
	import flash.display.DisplayObjectContainer;
	import flash.geom.Matrix;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2015/9/5 下午 12:03
	 * @version	：1.0.2
	 */
	
	public class ShakeSwing {
		
		private var _target:DisplayObjectContainer;
		private var _swingWidth:int;
		private var _swingHeight:int;
		private var _waitTime:Number;
		private var _time:Number;
		private var _rot:Number;
		private var _mtx:Matrix;
		
		public function ShakeSwing(target:DisplayObjectContainer, swingW:int, swingH:int) {
			this._target = target;
			this._swingWidth = swingW;
			this._swingHeight = swingH;
			this._rot = 0;
		}
		
		public function release():void {
			if (this._target != null) {
				this._target.transform.matrix = this._mtx.clone();
			}
			this._target = null;
		}
		
		public function control(param1:Number):void {
			var matrix:Matrix = new Matrix();
			//var radian:int = this._rot * Math.PI / 180;
			var radian:int = param1 * Math.PI / 180;
			matrix.translate(this._swingWidth * Math.cos(radian), this._swingHeight * Math.sin(radian));
			var matrix2:Matrix = this._mtx.clone();
			this._mtx.clone().concat(matrix);
			this._target.transform.matrix = matrix2;
			this._rot = this._rot + 122;
		}
	
	}

}