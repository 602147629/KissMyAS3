package justFly.view.util {
	import com.greensock.easing.Back;
	import com.greensock.TweenLite;
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2015/9/5 下午 12:03
	 * @version	：1.0.2
	 */
	
	public class TipInforMain extends Sprite{
		
		private var _dispaly:DisplayObject;
		
		/** 提示文字 */
		private var _tipMsg:TextField = new TextField();
		private var _msg_fmt:TextFormat;
		
		private var _alphas:Array = [1, 1 , 1 ,1 ];
		private var _ratios:Array = [ 0, 125 , 125,255];
		private var _colors:Array = [0x333333 , 0x000000 , 0x000000 , 0x000000];
		private var _matrix:Matrix = new Matrix();
		private var _spreadMethod:String = "reflect";
		private var _interpolationMethod:String = "LINEAR_RGB";
		private var _focalPointRatio:Number = 1;
		private var _dropFilter:DropShadowFilter = new DropShadowFilter(1 , 90 , 0x000000 , 1 , 2 , 2 , 1 , BitmapFilterQuality.HIGH);
		private var _glowFilter:GlowFilter = new GlowFilter(0x000000 , 0.2 , 5 , 5 , 1 , BitmapFilterQuality.HIGH);
		
		/** 4角半徑 */
		private var _cornerRadius:int = 8;
		/** 箭頭 */
		private var _arrowOffSet:int = 40;
		private var _arrowSize:int = 4;
		private var _w:Number;
		private var _h:Number;
		
		private var _bgBlock:Sprite = new Sprite();
		
		private static var instance:TipInforMain;
		public static function getInstance():TipInforMain {return (instance ||= new TipInforMain);}
		public function TipInforMain() { if (instance) { throw new Error("Use TipInforMain.getInstance()"); }}
		
		public function show( display:DisplayObject , msg:String , w:Number = 240 , h:Number = 460 , x:Number=0  , y:Number = 0):void {
			this._w = w;
			this._h = h;
			
			this._dispaly = display;
			this.settingTxt(msg);
			this.drawBG();
			this.addChild(this._tipMsg);
			
			this.x = x;
			this.y = y + this._tipMsg.height;
			this.alpha = 0;
			this.visible = true;
			this._dispaly.stage.addChild(this);
			
			TweenLite.to(this , 0.4 ,{y:y , alpha:1 , ease:Back.easeInOut , onComplete: onFadeOutFun});
		}
		
		//漸消; 淡出
		private function onFadeOutFun():void {
			TweenLite.to(this , 12 ,{y:y , alpha:0 , ease:Back.easeInOut , onComplete: onDisableFun});
		}
		
		private function onDisableFun():void {
			this.visible = false;
			this.disable();
		}
		
		public function disable():void {
			this._dispaly.stage.removeChild(this);
			
			this.removeChild(this._tipMsg);
			this._tipMsg.text = "";
			
			this._bgBlock.graphics.clear();
			this._bgBlock.filters = [];
			this.removeChild(this._bgBlock);
		}
		
		private function settingTxt(msg:String):void {
			this._msg_fmt = new TextFormat("Arial" , 12 , 0xFFFFFF , true , null , null , null , null , TextFieldAutoSize.CENTER);
			this._tipMsg.defaultTextFormat = this._msg_fmt;
			this._tipMsg.text = msg;
			this._tipMsg.selectable = false;
			this._tipMsg.mouseEnabled = false;
			this._tipMsg.height = 24;
			this._tipMsg.y = (this._tipMsg.height - this._tipMsg.textHeight)*0.4;
			
			//this._w = this._tipMsg.width; 
			//this._h = this._tipMsg.height;
			this._arrowOffSet = this._w * 0.5;
		}
		
		private function drawBG():void {
			this._bgBlock.graphics.clear();
			var xp:Number = 0.5;
			var yp:Number = 0.5;
			
			var fillType:String = GradientType.LINEAR;
			var radians:Number = 90 * Math.PI / 180;
			this._matrix.createGradientBox(this._w, this._h, radians, 0, 0);
			
			this._bgBlock.graphics.lineStyle(1, 0x000000, 1);
			this._bgBlock.graphics.beginGradientFill(fillType, this._colors, this._alphas, this._ratios, this._matrix, this._spreadMethod , this._interpolationMethod , this._focalPointRatio);
			
			this._bgBlock.graphics.moveTo(xp + this._cornerRadius, yp);
			this._bgBlock.graphics.lineTo(xp + this._w - this._cornerRadius, yp);
			this._bgBlock.graphics.curveTo(xp + this._w, yp, xp + this._w, yp + this._cornerRadius);
			this._bgBlock.graphics.lineTo(xp + this._w, yp + this._h - this._cornerRadius);
			this._bgBlock.graphics.curveTo(xp + this._w, yp + this._h, xp + this._w - this._cornerRadius, yp + this._h);
			
			//hook
			this._bgBlock.graphics.lineTo(xp + this._arrowOffSet + this._arrowSize, yp + this._h);
			this._bgBlock.graphics.lineTo(xp + this._arrowOffSet, yp + this._h + this._arrowSize);
			this._bgBlock.graphics.lineTo(xp + this._arrowOffSet - this._arrowSize, yp + this._h);
			this._bgBlock.graphics.lineTo(xp + this._cornerRadius, yp + this._h);
			
			this._bgBlock.graphics.curveTo(xp, yp + this._h, xp, yp + this._h - this._cornerRadius);
			this._bgBlock.graphics.lineTo(xp, yp + this._cornerRadius);
			this._bgBlock.graphics.curveTo(xp, yp, xp + this._cornerRadius, yp);
			this._bgBlock.graphics.endFill();
			this.addChild(this._bgBlock);
			this._bgBlock.alpha = 0.9;
			
			//Glow
			//this._bgBlock.filters = [this._glowFilter];
			this._bgBlock.filters = [this._dropFilter];
		}
	
	}

}