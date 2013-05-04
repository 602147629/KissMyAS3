package com.soar.ui {
	import com.greensock.plugins.GlowFilterPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TweenLite;
	import flash.display.DisplayObjectContainer;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 05:34
	 * @version	：1.0.12
	 */
	
	public class PushButton extends Component {
		//beginGradientFill
		private var fillType:String = GradientType.LINEAR;
		private var alphas:Array = [1, 1];
		private var ratios:Array = [75, 255];
		private var matrix:Matrix = new Matrix();
		private var spreadMethod:String = "reflect";
		private var interpolationMethod:String = "LINEAR_RGB";
		private var focalPointRatio:Number = 1;
		private var ellipse:int = 10;
		
		protected var _label:Label;
		protected var _labelText:String = "";
		protected var _back:Sprite;
		protected var _face:Sprite;
		protected var _over:Boolean = false;
		protected var _down:Boolean = false;
		protected var _selected:Boolean = false;
		protected var _toggle:Boolean = false;
		
		public function PushButton(parent:DisplayObjectContainer = null, width:Number = 0, height:Number = 0, label:String = "", xpos:Number = 0, ypos:Number = 0, defaultHandler:Function = null):void {
			TweenPlugin.activate([GlowFilterPlugin]);
			super(parent, xpos, ypos);
			setSize(width, height);
			
			if (defaultHandler != null) {
				addEventListener(MouseEvent.CLICK, defaultHandler);
			}
			
			this.label = label;
		}
		
		override protected function init():void {
			super.init();
			buttonMode = true;
			useHandCursor = true;
		}
		
		override protected function addChildren():void {
			_label = new Label();
			addChild(_label);
			
			addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
		}
		
		private function mouseOutHandler(e:MouseEvent):void {
			TweenLite.to(this, 0.3, {glowFilter: {color: null, alpha: 0, blurX: 0, blurY: 0}});
		}
		
		private function mouseOverHandler(e:MouseEvent):void {
			TweenLite.to(this, 0.3, {glowFilter: {color: Style.BUTTON_GLOW, alpha: 1, blurX: 6, blurY: 6}});
		}
		
		///////////////////////////////////
		// public methods 公開方法
		///////////////////////////////////
		
		override public function draw():void {
			super.draw();
			this.graphics.lineStyle(1, Style.BUTTON_LINE_STYLE);
			matrix.createGradientBox(this.width, this.height, 90 / 180 * Math.PI, 0, 0);
			this.graphics.beginGradientFill(fillType, Style.BUTTON_GRADIENT, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio);
			this.graphics.drawRoundRect(0, 0, this.width, this.height, ellipse, ellipse);
			
			_label.text = _labelText;
			_label.draw();
			if (_label.width > _width - 4) {
				_label.width = _width - 4;
			}
			_label.draw();
			_label.move(_width / 2 - _label.width / 2, _height / 2 - _label.height / 2);
		}
		
		///////////////////////////////////
		// getter / setters
		///////////////////////////////////
		
		/**
		 * Sets / gets the label text shown on this Pushbutton.
		 */
		public function set label(str:String):void {
			_labelText = str;
			draw();
		}
		
		public function get label():String {
			return _labelText;
		}
		
		public function set selected(value:Boolean):void {
			if (!_toggle) {
				value = false;
			}
			
			_selected = value;
			_down = _selected;
			_face.filters = [getShadow(1, _selected)];
		}
		
		public function get selected():Boolean {
			return _selected;
		}
		
		public function set toggle(value:Boolean):void {
			_toggle = value;
		}
		
		public function get toggle():Boolean {
			return _toggle;
		}
	}

}