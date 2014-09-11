package com.lab.tutorials.codeSnippets {
	import com.greensock.easing.Back;
	import com.greensock.plugins.ColorTransformPlugin;
	import com.greensock.plugins.GlowFilterPlugin;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/8/13 上午 11:15
	 * @version	：1.0.12
	 */
	
	public class TweenLiteSample extends Sprite {
		private var myTweenLite:TweenLite;
		private var square:Sprite;
		
		public function TweenLiteSample() {
			TweenPlugin.activate([GlowFilterPlugin , ColorTransformPlugin]);
			
			this.square = new Sprite();
			this.square.graphics.beginFill( 0xD58080 , 1);
			this.square.graphics.lineStyle(1 , 0xe4afaf);
			this.addChild( this.square);
			
			oneSpecies();
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		//	onComplete
		////////////////////////////////////////////////////////////////////////////////////////////////////
		public function oneSpecies():void {
			myTweenLite = new TweenLite.to( this.square, 0.15 , { 
				x:100 , 
				y:100 , 
				alpha:1  , 
				ease:Back.easeOut, 
				onComplete:onFinishTween , 
				onCompleteParams:[this.square]
			} );
		}
		
		private function onFinishTween( param1:Sprite):void {
			trace( "param1 : " + param1);
			myTweenLite.kill();
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		//	colorTransform & glowFilter
		////////////////////////////////////////////////////////////////////////////////////////////////////
		private function twoSpecies():void {
			myTweenLite = new  TweenLite.to(this, 0.16, { colorTransform:{tint:0xFFFFFF, tintAmount:0.2} , glowFilter: { color: 0x2284D1, alpha: 1, blurX: 5, blurY: 5, strength: 1.6 }} );
		}
		
	}

}