package soar.display {
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	/**
	 * ...
	 * @author g8sam « Just do it ™ »
	 */
	public class Ball extends Sprite {
		private var _fillType:String = GradientType.RADIAL;
		private var _alphas:Array = [1 , 1,  1 , 1 ];
		private var _ratios:Array = [20 , 60, 180 , 255];
		private var _matrix:Matrix = new Matrix();
		private var _spreadMethod:String = "reflect";
		
		public function Ball() {
			this.graphics.lineStyle(2, 0x222222);
			this._matrix.createGradientBox(18, 18, 45 / 180 * Math.PI, -8, -8);
			this.graphics.beginGradientFill(this._fillType, [ 0xcccccc , 0xaaaaaa, 0x888888 , 0x555555], this._alphas, this._ratios, this._matrix, this._spreadMethod, "rgb", 0.7);
			this.graphics.drawCircle(0, 0, 10);
		}
	
	}

}