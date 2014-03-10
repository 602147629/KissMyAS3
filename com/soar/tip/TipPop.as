package com.soar.tip {
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/5/17 下午 05:22
	 * @version	：1.0.12
	 */
	
	 /**
	  * @example	EXAMPLE:
	  * var $TipPop:TipPop = new TipPop();
	  * addChild($TipPop);
	  * $TipPop.x = 500;
	  * $TipPop.y = 60;
	  * $TipPop.show( "User Name");
	  */
	public class TipPop extends Sprite {
		private var tipMsg:TextField;
		private var msg_fmt:TextFormat;
		
		private var alphas:Array = [1, 1 , 1 ,1 ];
		private var ratios:Array = [ 0, 125 , 125,255];
		private var colors:Array = [0x333333 , 0x000000 , 0x000000 , 0x000000];
		private var matrix:Matrix = new Matrix();
		private var spreadMethod:String = "reflect";
		private var interpolationMethod:String = "LINEAR_RGB";
		private var focalPointRatio:Number = 1;
		
		private var cornerRadius:int = 8;//4角半徑
		private var arrowOffSet:int = 40;//箭頭
		private var arrowSize:int = 4;
		private var w:Number;
		private var h:Number;
		
		private var bgBlock:Sprite = new Sprite();
		
		public function TipPop():void {
			this.mouseChildren = false;
			this.mouseEnabled = false;
			this.tabChildren = false;
			this.tabEnabled = false;
		}
		
		public function show( msg:String):void {
			settingTxt(msg);
			drawBG();
			addChild(tipMsg);
		}
		
		private function settingTxt(msg:String):void {
			tipMsg = new TextField();
			msg_fmt = new TextFormat("Arial" , 12 , 0xFFFFFF , true , null , null , null , null , TextFieldAutoSize.CENTER);
			tipMsg.defaultTextFormat = msg_fmt;
			tipMsg.text = msg;
			tipMsg.selectable = false;
			tipMsg.mouseEnabled = false;
			tipMsg.height = 24;
			tipMsg.y = (tipMsg.height - tipMsg.textHeight)*0.4;
			
			w = tipMsg.width; 
			h = tipMsg.height;
			arrowOffSet = w * 0.5;
		}
		
		private function drawBG():void {
			bgBlock.graphics.clear();
			var xp:Number = 0.5;
			var yp:Number = 0.5;
			
			var fillType:String = GradientType.LINEAR;
			var radians:Number = 90 * Math.PI / 180;
			matrix.createGradientBox(w, h, radians, 0, 0);
			
			
			bgBlock.graphics.lineStyle(1, 0x000000, 1);
			bgBlock.graphics.beginGradientFill(fillType, colors, alphas, ratios, matrix, spreadMethod , interpolationMethod , focalPointRatio);
			
			bgBlock.graphics.moveTo(xp + cornerRadius, yp);
			bgBlock.graphics.lineTo(xp + w - cornerRadius, yp);
			bgBlock.graphics.curveTo(xp + w, yp, xp + w, yp + cornerRadius);
			bgBlock.graphics.lineTo(xp + w, yp + h - cornerRadius);
			bgBlock.graphics.curveTo(xp + w, yp + h, xp + w - cornerRadius, yp + h);
			
			//hook
			bgBlock.graphics.lineTo(xp + arrowOffSet + arrowSize, yp + h);
			bgBlock.graphics.lineTo(xp + arrowOffSet, yp + h + arrowSize);
			bgBlock.graphics.lineTo(xp + arrowOffSet - arrowSize, yp + h);
			bgBlock.graphics.lineTo(xp + cornerRadius, yp + h);
			
			bgBlock.graphics.curveTo(xp, yp + h, xp, yp + h - cornerRadius);
			bgBlock.graphics.lineTo(xp, yp + cornerRadius);
			bgBlock.graphics.curveTo(xp, yp, xp + cornerRadius, yp);
			bgBlock.graphics.endFill();
			addChild(bgBlock);
			bgBlock.alpha = 0.9;
			//bgGlow();
			bgDropShadow();
		}
		
		private function bgDropShadow():void {
			var bmpFilter:DropShadowFilter = new DropShadowFilter(1,90,0x000000,1,2,2,1,15);  
			bgBlock.filters = [bmpFilter];
		}
		
		private function bgGlow():void {
			var color:Number = 0x000000;
            var alpha:Number = 0.20;
            var blurX:Number = 5;
            var blurY:Number = 5;
            var strength:Number = 1;
            var inner:Boolean = false;
            var knockout:Boolean = false;
            var quality:Number = BitmapFilterQuality.HIGH;

           var filter:GlowFilter = new GlowFilter(color,
                                  alpha,
                                  blurX,
                                  blurY,
                                  strength,
                                  quality,
                                  inner,
                                  knockout);
            var myFilters:Array = new Array();
            myFilters.push(filter);
            bgBlock.filters = myFilters;
		}
	
	}
}