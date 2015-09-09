package com.soar.ui.component {
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class KS_Scrollbar extends Sprite {
		/**需進行滾動的對象 */
		public var _obj:Sprite;
		/** 遮罩對像*/
		public var _scrollmask:Sprite;
		/** 滾動條高度*/
		public var _scrollheight:Number;
		/** 文本顯示行數*/
		public var _scrolltextnum:int;
		/** 文本滾動速度（行/像素）*/
		public var _textspeed:int;
		/** 自定義滾動條對像*/
		public var _Scroll:Sprite;
		/** 滑塊*/
		public var _bar:Sprite;
		/** 向上按鈕*/
		public var _up:Sprite;
		/** 向下按鈕*/
		public var _down:Sprite;
		/** 滑槽*/
		public var _bg:Sprite;
		/**接受stage，必須傳入*/
		public var _displayobject:Stage;
		/** 計算滑塊高度所用*/
		public var _num:int;
		/** 滑塊可滑動距離*/
		private var _bars:Number;
		/** 滑塊可拖動範圍*/
		private var _rect:Rectangle;
		
		private var _i:int = 0;
		private var _n:Number;
		
		public function KS_Scrollbar():void {}
		
		public function init():void {
			if (this.checkhide()) {
				this.addEventListeners();
			} else {
				this._bar.visible = false;
			}
			this.setxy();
		}
		
		/** 判斷是否顯示滾動條等 **/
		private function checkhide():Boolean {
			if (this._Scroll != null) {
				if (this._obj.height <= this._scrollmask.height) {
					return false;
				}
				return true;
			}
			return false;
		}
		
		/** 設置滾動條高度，對像遮罩等 **/
		private function setxy():void {
			this._up.y = 1;
			this._bg.y = this._up.height;
			this._bar.x = 1.2;
			this._bar.y = this._bg.y;
			
			if (this._bar.height >= 10) {
				this._n = (this._obj.height - this._scrollmask.height) / (this._num + 20);
				this._bar.height = this._scrollmask.height - (this._obj.height - this._scrollmask.height) / this._n;
			}
			this._bg.height = this._scrollheight;
			this._down.y = this._bg.y + this._bg.height;
			this._bars = this._bg.height - this._bar.height;
			this._obj.mask = this._scrollmask;
			this._rect = new Rectangle(this._bar.x , this._bg.y , 0 , this._bg.height - this._bar.height );
		}
		
		/** 當被滾動對像更新時，而需要改變滾動條狀態，調用此方法 **/
		public function update(num:int):void {
			if (this.checkhide()) {
				this._i++;
				
				if (_bar.height >= 10) {
					this._n = (this._obj.height - this._scrollmask.height) / (num + 20);
					this._bar.height = this._scrollmask.height - (this._obj.height - this._scrollmask.height) / this._n;
				}
				
				this._bar.y = this._bg.y + this._bg.height - this._bar.height;
				this._bar.y += this._bars * this._textspeed / (this._obj.height - this._scrollmask.height);
				this._obj.y = this._scrollmask.y - this._obj.height + this._scrollmask.height;
				
				this.objrun(this._textspeed);
				this.updatebar();
				
				this._bars = this._bg.height - this._bar.height;
				this._rect = new Rectangle(this._bar.x, this._bg.y, 0, this._bg.height - this._bar.height);
				
				if (this._i == 1) {
					this._bar.visible = true;
					this.addEventListeners();
				}
			}
		}
		
		/** 為滾動條添加監聽事件 **/
		private function addEventListeners():void {
			this._bar.addEventListener(MouseEvent.MOUSE_DOWN, barclick);
			this._bar.addEventListener(MouseEvent.MOUSE_UP, barup);
			this._displayobject.addEventListener(MouseEvent.MOUSE_UP, barup);
			this._up.addEventListener(MouseEvent.MOUSE_DOWN, upclick);
			this._down.addEventListener(MouseEvent.MOUSE_DOWN, downclick);
			this._Scroll.addEventListener(MouseEvent.MOUSE_WHEEL, mousewheel);
			this._obj.addEventListener(MouseEvent.MOUSE_WHEEL, mousewheel);
		}
		
		/** 鼠標點擊滑塊方法 **/
		private function barclick(evt:MouseEvent):void {
			this._bar.startDrag(false, _rect);
			this._bar.addEventListener(Event.ENTER_FRAME, bar_enter_frame);
		}
		
		/** 鼠標點擊滑塊釋放方法 **/;
		private function barup(evt:MouseEvent):void {
			this._bar.stopDrag();
			this.delevent();
		}
		
		/** 鼠標點擊向上按鈕方法 **/
		private function upclick(evt:MouseEvent):void {
			if (this.checkbar()) {
				//滑塊移動的距離=滾動對像滾動的像素*滑塊可移動的總距離/(被滾動對象的高度-遮罩的高度（即顯示範圍的高度))
				this._bar.y -= this._bars * this._textspeed / (this._obj.height - this._scrollmask.height); 
				this._objrun(0 - this._textspeed);
				//調用方法移動對像;
				this.updatebar(); //校正滑塊位置
			}
		}
		
		/** 鼠標點擊向下按鈕方法 **/
		private function downclick(evt:MouseEvent):void {
			if (this.checkbar()) {
				this._bar.y += this._bars * this._textspeed / (this._obj.height - this._scrollmask.height);
				this.objrun(this._textspeed);
				this.updatebar();
			}
		}
		
		/** 鼠標滑輪事件 **/
		private function mousewheel(evt:MouseEvent):void {
			if (evt.delta > 0) {
				if (this.checkbar()) {
					this._bar.y -= this._bars * this._textspeed / (this._obj.height - this._scrollmask.height);
					this.objrun(-this._textspeed);
					this.updatebar();
				}
			} else {
				if (this.checkbar()) {
					this._bar.y += this._bars * this._textspeed / (this._obj.height - this._scrollmask.height);
					this.objrun(this._textspeed);
					this.updatebar();
				}
			}
		}
		
		private function bar_enter_frame(evt:Event):void {
			obj.y = scrollmask.y - (bar.y - bg.y) * (obj.height - scrollmask.height) / bars;
			if (obj.y > scrollmask.y) {
				obj.y = scrollmask.y;
			} else if (obj.y < (scrollmask.y - obj.height + scrollmask.height)) {
				obj.y = scrollmask.y - obj.height + scrollmask.height;
			}
		}
		
		private function objrun(i:Number):void {
			this._obj.y -= this._i;
			if (this._obj.y > this._scrollmask.y) {
				this._obj.y = this._scrollmask.y;
			} else if (this._obj.y < (this._scrollmask.y - this._obj.height + this._scrollmask.height)) {
				this._obj.y = this._scrollmask.y - this._obj.height + this._scrollmask.height;
			}
		}
		
		private function checkbar():Boolean {
			if (this._bar.y >= this._bg.y && this._bar.y <= (this._bars + this._bg.y)) {
				return true;
			}
			return false;
		}
		
		/** 刪除卸載事件偵聽 **/
		private function updatebar():void {
			if (this._bar.y < this._bg.y) {
				this._bar.y = this._bg.y;
			} else if (this._bar.y > (this._bg.y + this._bg.height - this._bar.height)) {
				this._bar.y = this._bg.y + this._bg.height - this._bar.height;
			}
		}
		
		private function delevent():void {
			this._bar.addEventListener(Event.ENTER_FRAME, bar_enter_frame);
		}
		
		//http://www.cnblogs.com/zhoujunfeng2011/archive/2011/07/15/2106989.html
	
	}
}