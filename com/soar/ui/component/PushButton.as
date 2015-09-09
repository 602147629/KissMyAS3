package com.soar.ui.component {
	import com.greensock.plugins.ColorTransformPlugin;
	import com.greensock.plugins.GlowFilterPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TweenLite;
	import com.soar.filter.KS_ColorTransform_IDE;
	import com.soar.ui.style.Style;
	import flash.display.DisplayObjectContainer;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class PushButton extends Component {
		//beginGradientFill
		private var _fillType:String = GradientType.LINEAR;
		private var _alphas:Array = [1, 1];
		private var _ratios:Array = [75, 255];
		private var _matrix:Matrix = new Matrix();
		private var _spreadMethod:String = "reflect";
		private var _interpolationMethod:String = "LINEAR_RGB";
		private var _focalPointRatio:Number = 1;
		private var _ellipse:int = 5;
		
		protected var _label:Label;
		protected var _labelText:String = "";
		protected var _back:Sprite;
		protected var _face:Sprite;
		protected var _over:Boolean = false;
		protected var _down:Boolean = false;
		protected var _selected:Boolean = false;
		protected var _toggle:Boolean = false;
		
		/**
		 *	PushButton
		 * @param	parent					:DisplayObjectContainer
		 * @param	width					:Number
		 * @param	height					:Number
		 * @param	label						:String
		 * @param	xpos						:Number
		 * @param	ypos						:Number
		 * @param	defaultHandler		:Function
		 */
		public function PushButton( parent:DisplayObjectContainer = null, 
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
			this.setSize(width, height);
			
			if (defaultHandler != null) {
				this.addEventListener(MouseEvent.CLICK, defaultHandler);
			}
			
			this.label = label;
		}
		
		override protected function init():void {
			super.init();
			this.buttonMode = true;
			this.useHandCursor = true;
		}
		
		override protected function addChildren():void {
			this._label = new Label();
			this.addChild(this._label);
			
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
			this.transform.colorTransform = KS_ColorTransform_IDE.getInstance().Luminance(100);
			
			TweenLite.to(this, 0.16, { colorTransform:{tint:0xFFFFFF, tintAmount:0.2} , glowFilter: { color: Style.BUTTON_GLOW, alpha: 1, blurX: 5, blurY: 5, strength: 1.6 }} );
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////
		// public methods 公開方法
		/////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override public function draw():void {
			super.draw();
			
			this.graphics.lineStyle(1, Style.BUTTON_LINE_STYLE);
			this._matrix.createGradientBox(this.width, this.height, 90 / 180 * Math.PI, 0, 0);
			this.graphics.beginGradientFill(this._fillType, Style.BUTTON_GRADIENT, this._alphas, this._ratios, this._matrix, this._spreadMethod, this._interpolationMethod, this._focalPointRatio);
			
			//讓drawRoundRect抗鋸齒的最簡單的方法：讓x和y坐標為小數：
			this.graphics.drawRoundRect(0.5, 0.5, this.width, this.height, this._ellipse, this._ellipse);
			
			this._label.text = this._labelText;
			this._label.draw();
			
			if (this._label.width > this._width - 4) {
				this._label.width = this._width - 4;
			}
			
			this._label.draw();
			this._label.move(this._width / 2 - this._label.width / 2, this._height / 2 - this._label.height / 2);
		}
		
		private function toggleColorTransform(toggle:Boolean):void {
			var ct:ColorTransform = new ColorTransform();
			ct.redMultiplier = ct.greenMultiplier = ct.blueMultiplier = toggle ? 1 : 0.5;
			this._label.transform.colorTransform = ct;
			//this._label.filters = ColorTransform_IDE.getInstance().GRAY_FILTERS;
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////////////////
		// getter / setters
		/////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * Sets / gets the label text shown on this Pushbutton.
		 */
		public function set label(str:String):void {
			this._labelText = str;
			this.draw();
		}
		
		public function get label():String {
			return this._labelText;
		}
		
		public function set selected(value:Boolean):void {
			if (!this._toggle) {
				value = false;
			}
			
			this._selected = value;
			this._down = this._selected;
			this._face.filters = [getShadow(1, this._selected)];
		}
		
		public function get selected():Boolean {
			return this._selected;
		}
		
		public function set toggle(value:Boolean):void {
			this._toggle = value;
		}
		
		public function get toggle():Boolean {
			return this._toggle;
		}
		
		public function set enable(value:Boolean):void {
			this.toggleColorTransform(value);
		}
	}

}