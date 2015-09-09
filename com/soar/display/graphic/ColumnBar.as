package com.soar.display.graphic {
	
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class ColumnBar extends Sprite {
		
		private var oneColor_ary:Array = [  [ 209 , 237 , 82 ] , [ 180 , 213 , 22 ] , [ 130 , 154 , 16 ] ];
		private var twoColor_ary:Array = [  [ 250 , 182 , 69 ] , [ 249 , 170 , 41 ] , [ 166 , 105 , 4 ] ];
		private var threeColor_ary:Array = [  [ 88 , 184 , 231 ] , [ 63 , 174 , 227 ] , [ 27 , 107 , 149 ] ];
		
		public function ColumnBar( oneH:int , twoH:int , threeH:int ):void {
			var oneBar:Bar = new Bar( oneH , oneColor_ary[0] , oneColor_ary[1] , oneColor_ary[2] );
			addChild(oneBar);
			
			var twoBar:Bar = new Bar( twoH , twoColor_ary[0] , twoColor_ary[1] , twoColor_ary[2] );
			addChild(twoBar);
			twoBar.x  = oneBar.x + oneBar.width *1.68;
			
			var threeBar:Bar = new Bar( threeH , threeColor_ary[0] , threeColor_ary[1] , threeColor_ary[2] );
			addChild(threeBar);
			threeBar.x  = twoBar.x + oneBar.width * 1.68;
			
		}
	}
}