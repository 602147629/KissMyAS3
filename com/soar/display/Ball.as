package com.soar.display {
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class Ball extends Sprite {
		
		private var _fillType:String = GradientType.RADIAL;
		private var _color:Array = [ 0xcccccc , 0xaaaaaa, 0x888888 , 0x555555];
		private var _alphas:Array = [1 , 1,  1 , 1 ];
		private var _ratios:Array = [20 , 60, 180 , 255];
		private var _matrix:Matrix = new Matrix();
		private var _spreadMethod:String = "reflect";
		
		public function Ball() {
			this.graphics.lineStyle(2, 0x222222);
			this._matrix.createGradientBox(18, 18, 45 / 180 * Math.PI, -8, -8);
			this.graphics.beginGradientFill(this._fillType, this._color, this._alphas, this._ratios, this._matrix, this._spreadMethod, "rgb", 0.7);
			this.graphics.drawCircle(0, 0, 10);
		}
	
	}

}