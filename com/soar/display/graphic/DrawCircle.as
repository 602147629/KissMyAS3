package com.soar.display.graphic {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class DrawCircle extends Sprite {
		private const cr1_color:uint = 0xB4D516;
		private const cr2_color:uint = 0x3FAEE3;
		private const cr3_color:uint = 0xF9AA29;
		private var cr1_radius:int;
		private var cr2_radius:int;
		private var cr3_radius:int;
		private var seed:int = 5;
		
		public function DrawCircle( radius1:int , radius2:int , radius3:int ):void {
			cr1_radius = radius1 * seed;
			cr2_radius = radius2 * seed;
			cr3_radius = radius3 * seed;
			
			var sqrt2:Number = Math.sqrt((cr1_radius * cr1_radius) - (cr2_radius * cr2_radius));
			var sqrt3:Number = Math.sqrt((cr1_radius * cr1_radius) - (cr3_radius * cr3_radius));
			var cr1:Bitmap = new Bitmap( drawCircleBmpd( cr1_radius , cr1_color) );
			this.addChild( cr1);
			cr1.x = 50;
			cr1.y = 0;
			
			var cr2:Bitmap = new Bitmap( drawCircleBmpd( cr2_radius , cr2_color ) );
			//cr2.x = (cr1.x + cr1_radius) * (1 + cr2_radius / 2000);
			cr2.x = (cr1.x + cr1_radius) *  ( 1+cr2_radius /1600);
			cr2.y = (cr1.y + cr1_radius + sqrt2) *  ( 1+cr2_radius /200);
			this.addChild( cr2 );
			
			var cr3:Bitmap = new Bitmap( drawCircleBmpd( cr3_radius , cr3_color ) );
			cr3.x = (cr1.x + cr1_radius - cr3_radius * 2) * (1 + cr3_radius / 1680);
			cr3.y = (cr1.y + cr1_radius + sqrt3) * (1 + cr3_radius / 300);
			this.addChild( cr3 );
			
			this.graphics.beginFill( 0xefefef , 1);
			this.graphics.drawRect( 0 , 0 , 200 , 200);
		}
		
		private function drawCircleBmpd( radius:int , color:uint  ):BitmapData {
			var sprite:Sprite = new Sprite();
			sprite.graphics.beginFill( color );
			sprite.graphics.drawCircle( radius, radius, radius );
			sprite.graphics.endFill();
			var bmd:BitmapData = new BitmapData( radius * 2 , radius * 2, true, 0x00ffffff);
			bmd.draw(sprite);
			return bmd;
		}
		
		public function getGrasp():BitmapData {
			var bmd:BitmapData = new BitmapData( 200 , 200, true, 0x00ffffff);
			bmd.draw(this);
			return bmd;
		}
	}
}