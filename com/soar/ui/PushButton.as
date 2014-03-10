package com.soar.ui {
	import com.greensock.plugins.ColorTransformPlugin;
	import com.greensock.plugins.GlowFilterPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TweenLite;
	import com.soar.style.ColorTransform_IDE;
	import flash.display.DisplayObjectContainer;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	
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
		private var ellipse:int = 5;
		
		protected var _label:Label;
		protected var _labelText:String = "";
		protected var _back:Sprite;
		protected var _face:Sprite;
		protected var _over:Boolean = false;
		protected var _down:Boolean = false;
		protected var _selected:Boolean = false;
		protected var _toggle:Boolean = false;
		
		/**
		 *	jfidjfidosf
		 * @param	parent					:DisplayObjectContainer
		 * @param	width					:Number
		 * @param	height					:Number
		 * @param	label					:String
		 * @param	xpos						:Number
		 * @param	ypos						:Number
		 * @param	defaultHandler	:Function
		 */
		public function PushButton(	parent:DisplayObjectContainer = null, 
													width:Number = 0, 
													height:Number = 0, 
													label:String = "", 
													xpos:Number = 0, 
													ypos:Number = 0, 
													defaultHandler:Function = null
		):void {
			
			TweenPlugin.activate([GlowFilterPlugin]);
			TweenPlugin.activate([ColorTransformPlugin]);
			
			super(parent, xpos, ypos);
			setSize(width, height);
			
			if (defaultHandler != null) {
				this.addEventListener(MouseEvent.CLICK, defaultHandler);
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
			
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
		}
		
		private function mouseOutHandler(e:MouseEvent):void {
			this.removeEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			
			TweenLite.to(this, 0.3, { colorTransform:{tint:null, tintAmount:0.0} , glowFilter: {color: null, alpha: 0, blurX: 0, blurY: 0, strength: 0}});
		}
		
		private function mouseOverHandler(e:MouseEvent):void {
			this.removeEventListener(MouseEvent.MOUSE_OVER, mouseOutHandler);
			this.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
			
			this.transform.colorTransform = ColorTransform_IDE.Luminance(100);
			
			TweenLite.to(this, 0.16, { colorTransform:{tint:0xFFFFFF, tintAmount:0.2} , glowFilter: { color: Style.BUTTON_GLOW, alpha: 1, blurX: 5, blurY: 5, strength: 1.6 }} );
			
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////
		// public methods 公開方法
		/////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override public function draw():void {
			super.draw();
			this.graphics.lineStyle(1, Style.BUTTON_LINE_STYLE);
			matrix.createGradientBox(this.width, this.height, 90 / 180 * Math.PI, 0, 0);
			this.graphics.beginGradientFill(fillType, Style.BUTTON_GRADIENT, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio);
			//讓drawRoundRect抗鋸齒的最簡單的方法：讓x和y坐標為小數：
			this.graphics.drawRoundRect(0.5, 0.5, this.width, this.height, ellipse, ellipse);
			
			_label.text = _labelText;
			_label.draw();
			
			if (_label.width > _width - 4) {
				_label.width = _width - 4;
			}
			_label.draw();
			_label.move(_width / 2 - _label.width / 2, _height / 2 - _label.height / 2);
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////
		// getter / setters
		/////////////////////////////////////////////////////////////////////////////////////////////////////////
		
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