package com.soar.dataGrild {
	import flash.display.Shape;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/4/24 下午 02:39
	 * @version	：1.0.12
	 */
	
	public class GridCanvars{
		private static var instance:GridCanvars;
		public static function getInstance():GridCanvars {return (instance ||= new GridCanvars);}
		public function GridCanvars() {if (instance) {throw new Error("Use GridCanvars.getInstance()");}}
		
		public function drawGirdCanvars(squareW:int, squareH:int, cols:int, rows:int):Shape {
			var gird:Shape = new Shape();
			var canWidth:int = squareW * cols;
			var canHeight:int = squareW * rows;
			
			gird.graphics.beginFill(0xffffff);
			gird.graphics.drawRect(0, 0, canWidth, canHeight);
			gird.graphics.lineStyle(1, 0x555555);
			
			var n:int = 0;
			var m:int = 0;
			
			//列
			for (n = 0; n <= cols; n++) {
				gird.graphics.moveTo(n * squareW, 0);
				gird.graphics.lineTo(n * squareW, rows * squareW);
				
				//行
				for (m = 0; m <= rows; m++) {
					gird.graphics.moveTo(0, m * squareW);
					gird.graphics.lineTo(cols * squareW, m * squareW);
				}
			}
			
			return gird;
		}
	
	}

}