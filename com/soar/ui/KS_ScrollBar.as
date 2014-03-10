package ui {
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/8/31 上午 11:45
	 * @version	：1.0.12
	 */
	
	public class KS_Scrollbar extends Sprite {
		
		public var obj:Sprite; //需進行滾動的對象
		public var scrollmask:Sprite; //遮罩對像
		public var scrollheight:Number; //滾動條高度
		public var scrolltextnum:int; //文本顯示行數
		public var textspeed:int; //文本滾動速度（行/像素）
		public var Scroll:Sprite; //自定義滾動條對像
		public var bar:Sprite; //滑塊
		public var up:Sprite; //向上按鈕
		public var down:Sprite; //向下按鈕
		public var bg:Sprite; //滑槽
		public var displayobject:Stage; //接受stage，必須傳入
		public var num:int; //計算滑塊高度所用
		
		private var bars:Number; //滑塊可滑動距離
		private var rect:Rectangle; //滑塊可拖動範圍
		private var i:int = 0;
		private var n:Number;
		
		public function KS_Scrollbar():void {
		}
		
		public function init():void {
			if (checkhide()) {
				addEventListeners();
			} else {
				bar.visible = false;
			}
			setxy();
		}
		
		/** 判斷是否顯示滾動條等 **/
		private function checkhide():Boolean {
			if (Scroll != null) {
				if (obj.height <= scrollmask.height) {
					return false;
				}
				return true;
			}
			return false;
		}
		
		/** 設置滾動條高度，對像遮罩等 **/
		private function setxy():void {
			up.y = 1;
			bg.y = up.height;
			bar.x = 1.2;
			bar.y = bg.y;
			if (bar.height >= 10) {
				n = (obj.height - scrollmask.height) / (num + 20);
				bar.height = scrollmask.height - (obj.height - scrollmask.height) / n;
			}
			bg.height = scrollheight;
			down.y = bg.y + bg.height;
			bars = bg.height - bar.height;
			obj.mask = scrollmask;
			rect = new Rectangle(bar.x, bg.y, 0, bg.height - bar.height);
		}
		
		/** 當被滾動對像更新時，而需要改變滾動條狀態，調用此方法 **/
		public function update(num:int):void {
			if (checkhide()) {
				i++;
				if (bar.height >= 10) {
					n = (obj.height - scrollmask.height) / (num + 20);
					bar.height = scrollmask.height - (obj.height - scrollmask.height) / n;
				}
				bar.y = bg.y + bg.height - bar.height;
				bar.y += bars * textspeed / (obj.height - scrollmask.height);
				obj.y = scrollmask.y - obj.height + scrollmask.height;
				objrun(textspeed);
				updatebar();
				bars = bg.height - bar.height;
				rect = new Rectangle(bar.x, bg.y, 0, bg.height - bar.height);
				if (i == 1) {
					bar.visible = true;
					addEventListeners();
				}
			}
		}
		
		/** 為滾動條添加監聽事件 **/
		private function addEventListeners():void {
			bar.addEventListener(MouseEvent.MOUSE_DOWN, barclick);
			bar.addEventListener(MouseEvent.MOUSE_UP, barup);
			displayobject.addEventListener(MouseEvent.MOUSE_UP, barup);
			up.addEventListener(MouseEvent.MOUSE_DOWN, upclick);
			down.addEventListener(MouseEvent.MOUSE_DOWN, downclick);
			Scroll.addEventListener(MouseEvent.MOUSE_WHEEL, mousewheel);
			obj.addEventListener(MouseEvent.MOUSE_WHEEL, mousewheel);
		}
		
		/** 鼠標點擊滑塊方法 **/;
		private function barclick(evt:MouseEvent):void {
			bar.startDrag(false, rect);
			bar.addEventListener(Event.ENTER_FRAME, bar_enter_frame);
		}
		
		/** 鼠標點擊滑塊釋放方法 **/;
		private function barup(evt:MouseEvent):void {
			bar.stopDrag();
			delevent();
		}
		
		/** 鼠標點擊向上按鈕方法 **/
		private function upclick(evt:MouseEvent):void {
			if (checkbar()) {
				bar.y -= bars * textspeed / (obj.height - scrollmask.height); //滑塊移動的距離=滾動對像滾動的像素*滑塊可移動的總距離/(被滾動對象的高度-遮罩的高度（即顯示範圍的高度))
				objrun(0 - textspeed);
				//調用方法移動對像;
				updatebar(); //校正滑塊位置
			}
		}
		
		/** 鼠標點擊向下按鈕方法 **/
		private function downclick(evt:MouseEvent):void {
			if (checkbar()) {
				bar.y += bars * textspeed / (obj.height - scrollmask.height);
				objrun(textspeed);
				updatebar();
			}
		}
		
		/** 鼠標滑輪事件 **/
		private function mousewheel(evt:MouseEvent):void {
			if (evt.delta > 0) {
				if (checkbar()) {
					bar.y -= bars * textspeed / (obj.height - scrollmask.height);
					objrun(-textspeed);
					updatebar();
				}
			} else {
				if (checkbar()) {
					bar.y += bars * textspeed / (obj.height - scrollmask.height);
					objrun(textspeed);
					updatebar();
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
			obj.y -= i;
			if (obj.y > scrollmask.y) {
				obj.y = scrollmask.y;
			} else if (obj.y < (scrollmask.y - obj.height + scrollmask.height)) {
				obj.y = scrollmask.y - obj.height + scrollmask.height;
			}
		}
		
		private function checkbar():Boolean {
			if (bar.y >= bg.y && bar.y <= (bars + bg.y)) {
				return true;
			}
			return false;
		}
		
		/** 刪除卸載事件偵聽 **/
		private function updatebar():void {
			if (bar.y < bg.y) {
				bar.y = bg.y;
			} else if (bar.y > (bg.y + bg.height - bar.height)) {
				bar.y = bg.y + bg.height - bar.height;
			}
		}
		
		private function delevent():void {
			bar.addEventListener(Event.ENTER_FRAME, bar_enter_frame);
		}
		
		//http://www.cnblogs.com/zhoujunfeng2011/archive/2011/07/15/2106989.html
	
	}
}