package com.soar.display.graphic {
	
	import flash.display.Sprite;
	/**
	 * ... 參考線類 (棋盤型)
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */

	public class  ReferenceLine extends Sprite {
		private var bWidth:int = 20;
		private var bHeight:int = 20;
		private var HLine:int = 10;
		private var WLine:int = 18;
		private var lineColor:uint = 0x999999;
		
		private var timeSpace_ary:Array = [ "0" , "2.5" , "3" , "4" , "5" , "6" , "7" , "8" , "9" , "10"];	//時間間隔 * 3
		private var level_ary:Array = [];
		
		public function ReferenceLine():void {
			
			//成績
			for ( var s:int = 0; i < WLine; i++  ) {
				level_ary.push( int(Math.random()*9));
			}
			
			//縱軸 -->等級
			for ( var i:int = 0; i < WLine ; i ++ ) {
				this.graphics.lineStyle( 1 , lineColor , 1 );
				this.graphics.moveTo( bWidth*i , 0 );
				this.graphics.lineTo(  bWidth * i , bHeight * (HLine-1) );
			}
			
			//橫軸 -->時間
			for ( var j:int = 0; j < HLine ; j ++ ) {
				this.graphics.lineStyle( 1 , lineColor ,1 );
				this.graphics.moveTo(  0, bHeight*j );
				this.graphics.lineTo(  bWidth * (WLine-1) , bHeight * j  );
			}
			
			//畫點
			for ( var k:int = 0; k < level_ary.length; k ++ ) {
				this.graphics.beginFill(0xFF6633 , 1);
				this.graphics.drawCircle(  k*bWidth , ((bHeight*(HLine-1)) - (level_ary[k]*bHeight)) , 4);
			}
		}
		
	}
}