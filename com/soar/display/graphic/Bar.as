package com.soar.display.graphic{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class Bar extends Sprite {
		
		private var LWidth:Number = 36;
		private var LHeight:Number = 32;
		private var LColor:uint;
		private var MColor:uint;
		private var HColor:uint;
		private var _u:Number = 16;
		private var _v:Number = 7;
		
		public function Bar( _height:int  , lc:Array , mc:Array , hc:Array ):void {
			LHeight = LHeight * _height;
			LColor = ChangeHEX( lc);
			MColor = ChangeHEX( mc);
			HColor = ChangeHEX( hc);
			
			this.graphics.beginFill( LColor , 1);
			this.graphics.moveTo( 0 , -LHeight);
			this.graphics.lineTo( LWidth , -LHeight );
			this.graphics.lineTo( LWidth + _u , ( -LHeight - _v) );
			this.graphics.lineTo( _u ,( -LHeight - _v) );
			this.graphics.lineTo( 0 , -LHeight);
			this.graphics.endFill();
			
			this.graphics.beginFill( MColor , 1);
			this.graphics.drawRect(0 , 0 , LWidth , -LHeight);
			this.graphics.endFill();
			
			this.graphics.beginFill( HColor, 1 );
			this.graphics.moveTo( LWidth , 0);
			this.graphics.lineTo( LWidth , -LHeight );
			this.graphics.lineTo( LWidth +_u , ( -LHeight - _v) );
			this.graphics.lineTo( LWidth +_u , ( -LHeight - _v) + LHeight );
			this.graphics.lineTo( LWidth , 0);
			
			var ttf:TextField = new TextField();
			ttf.width = 16;
			ttf.text = String(_height);
			addChild(ttf);
			ttf.x = LWidth * 0.4;
			ttf.y = -LHeight;
		}
		
		public function ChangeHEX( rgb:Array ):uint {
			var hex:uint = rgb[0] << 16 ^ rgb[1] << 8 ^ rgb[2];
			return hex;
		}
		
	}
}