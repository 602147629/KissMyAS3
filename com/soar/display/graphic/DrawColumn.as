package com.soar.display.graphic {
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class DrawColumn extends Sprite  {
		private var cri:ColumnTable;
		private var cbar:ColumnBar;
		
		public function DrawColumn( oneH:int , twoH:int , threeH:int):void {
			cri = new ColumnTable();
			this.addChild(cri);
			cri.x = 20;
			cri.y = 380;
			
			cbar = new ColumnBar( oneH , twoH , threeH );
			this.addChild(cbar);
			cbar.x = 90;
			cbar.y = 370;
			
			var numTxt:TextField = new TextField();
			numTxt.text = "9" + "\n" + "8" + "\n" + "7" + "\n" +"7" + "\n" + "6" + "\n" + "5" + "\n" + "4" + "\n" + "3" + "\n" + "2" + "\n" + "1" + "\n" + "0" + "\n";
			numTxt.defaultTextFormat = new TextFormat();
			addChild(numTxt);
		}
		
		public function getGrasp():BitmapData {
			var bmd:BitmapData = new BitmapData( 600 , 600, true, 0x00ffffff);
			bmd.draw(this);
			return bmd;
		}
	}
}