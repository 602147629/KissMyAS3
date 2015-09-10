package com.soar.tip {
	
	import com.soar.events.GeneralEvent;
	import com.soar.ui.component.PushButton;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.GradientType;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ... 警告視窗
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */

	public class Alert extends Sprite {
		private var _msg:String;
		private var _msg_fmt:TextFormat;
		private var _bmp:Bitmap;
		private var _bmpD:BitmapData;
		private var _msg_Tf:TextField;
		private var _enterBtn:PushButton;
		private var _obj:DisplayObjectContainer;
		
		private var _msgBox:Sprite;
		
		//beginGradientFill
		private var _fillType:String = GradientType.LINEAR;
		private var _alphas:Array = [1, 1 , 1 ,1 ,  1];
		private var _ratios:Array = [ 0, 4 , 41,42 ,255];
		private var _colors:Array = [0x787878 , 0x484848 , 0x252525 , 0x959699, 0x515359]
		private var _matrix:Matrix = new Matrix();
		private var _spreadMethod:String = "reflect";
		private var _interpolationMethod:String = "LINEAR_RGB";
		private var _focalPointRatio:Number = 1;
		private var _ellipse:int = 10;
		
		/** 	視窗標題	**/
		private var _messageTitleStr:String = "";
		private var _mesage_tf:TextField ;
		private var _message_fmt:TextFormat;
		
		/** 	彈出視窗大小	**/
		private var _msgW:int;
		private var _msgH:int;
		
		/** 	場景大小 	**/
		private var _alertWidth:int;
		private var _alertHeight:int;
		
		/** 是否派發事件	**/
		private var _isEvent:Boolean = false;
		
		private static var instance:Alert;
		public static function getInstance():Alert {return (instance ||= new Alert);}
		public function Alert() { if (instance) { throw new Error("Use Alert.getInstance()"); }}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//	Public Method
		//
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		/**
		 * 設定場景大小
		 * @param	width	:	int
		 * @param	height	:	int
		 */
		public function setAlertSize( width:int , height:int ):void {
			this._alertWidth = width;
			this._alertHeight = height;
		}
		
		/**
		 * 設定彈出窗大小
		 * @param	width	:	int
		 * @param	height	:	int
		 */
		public function setMsgSize(width:int , height:int ):void {
			this._msgW = width;
			this._msgH = height;
		}
		
		/**
		 * 設定視窗標題
		 * @param	str
		 */
		public function setMsgTitle( str:String ):void {
			this._messageTitleStr = str;
		}
		
		/**
		 * 顯示警告視窗
		 * @param	_parent	上層容器
		 * @param	_msg		顯示文字內容
		 * @param	isEvent		事件開啟並開起按鈕
		 * @param	_width		警告窗體寬
		 * @param	_height	警告窗體高
		 */
		public function show( _parent:DisplayObjectContainer = null  , _msg:String = null , isEvent:Boolean = false , _width:int = 0 , _height:int = 0 ):void {
			this._obj = _parent;
			this._obj.addChild(this);
			this._msg = _msg;
			this._isEvent = isEvent;
			
			if (_width != 0  && _height != 0) {
				this._msgW = _width;
				this._msgH = _height;
			} 
			
			this.message( this._msgW , this._msgH );
			
			this._bmpD = new BitmapData( this._alertWidth , this._alertHeight , false , 0x000000);
			this._bmp = new Bitmap(this._bmpD);
			this._bmp.alpha = 0.6;
			this.addChild(this._bmp);
			
			this._msg_Tf = new TextField();
			this._msg_fmt = new TextFormat("微軟正黑體", 20, 0xcc0000, true, null, null, null, null, "center");
			this._msg_fmt.letterSpacing = 2;
			this._msg_Tf.defaultTextFormat = this._msg_fmt;
			this._msg_Tf.selectable = false;
			this._msg_Tf.mouseEnabled = false;
			this._msg_Tf.autoSize = TextFieldAutoSize.CENTER;
			this._msg_Tf.antiAliasType = AntiAliasType.ADVANCED;
			this._msg_Tf.text = this._msg;
			this._msg_Tf.width = 400;
			this.addChild(this._msg_Tf);
			this._msg_Tf.x = (this._alertWidth - this._msg_Tf.width) * 0.5;
			this._msg_Tf.y = (this._alertHeight - this._msg_Tf.height) * 0.5-10;
			
			if (this._isEvent) {
				this._enterBtn = new PushButton(this  , 70 , 26 , "确定" , 0, 0 , this.closeShowHandler );
				this.addChild(this._enterBtn);
				this._enterBtn.x = (this._alertWidth - this._enterBtn.width) * 0.5;
				this._enterBtn.y = (_alertHeight - this._enterBtn.height) * 0.5 +46;
				this._enterBtn.addEventListener( MouseEvent.CLICK , this.closeShowHandler);
			}
			
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		//	Private Method
		//
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		private function message( width:int , height:int ):void {
			this._msgBox = new Sprite();
			this._msgBox.graphics.lineStyle(1, 0x333333);
			this._matrix.createGradientBox(width, height, 90 / 180 * Math.PI, 0, 0);
			this._msgBox.graphics.beginGradientFill( this._fillType , this._colors , this._alphas, this._ratios, this._matrix, this._spreadMethod, this._interpolationMethod, this._focalPointRatio);
			//讓drawRoundRect抗鋸齒的最簡單的方法：讓x和y坐標為小數：
			this._msgBox.graphics.drawRoundRect(0.5, 0.5, width, height, this._ellipse, this._ellipse);
			this._msgBox.graphics.moveTo(0 , 30);
			this._msgBox.graphics.lineTo(width , 30);
			this.addChild(this._msgBox);
			this._msgBox.x = (this._alertWidth - width) * 0.5;
			this._msgBox.y = (this._alertHeight - height) * 0.5;
			//msgBox.alpha = 0.8;
			
			var shadow:DropShadowFilter = new DropShadowFilter();
			shadow.distance = 1;
			shadow.angle = 16;
			this._msgBox.filters = [shadow];
			
			this._mesage_tf = new TextField();
			this._message_fmt = new TextFormat("微軟正黑體", 20, 0xdddddd, true, null, null, null, null, "center");
			this._message_fmt.letterSpacing = 2;
			this._mesage_tf.defaultTextFormat = this._message_fmt;
			this._mesage_tf.selectable = false;
			this._mesage_tf.mouseEnabled = false;
			this._mesage_tf.autoSize = TextFieldAutoSize.CENTER;
			this._mesage_tf.antiAliasType = AntiAliasType.ADVANCED;
			
			if (this._messageTitleStr != "") {
				this._mesage_tf.text = this._messageTitleStr;
				this._mesage_tf.x = (this._alertWidth - this._mesage_tf.width)*0.5;
				this._mesage_tf.y = this._msgBox.y;
				this._mesage_tf.filters = [shadow];
				this.addChild(this._mesage_tf);
			}
		}
		
		/**	自己銷毀 **/
		private function closeShowHandler(e:MouseEvent ):void {
			if(this._isEvent ) {
				this.dispatchEvent( new GeneralEvent("ALERT_ENTER_EVENT" ));
			}
			
			this.kill();
		}
		
		private function kill():void {
			if (this._enterBtn) {
				this._enterBtn.removeEventListener( MouseEvent.CLICK , this.closeShowHandler);
				this.removeChild(this._enterBtn);
				this._enterBtn = null;
			}
			
			this.removeChild(this._msg_Tf);
			this._bmpD.dispose();
			this._bmpD = null;
			this.removeChild(this._bmp);
			this.removeChild(this._mesage_tf);
			this.removeChild(this._msgBox);
			
			this._msg_Tf = null;
			this._msg_fmt = null;
			this._msg = null;
			
			this._bmp = null;
			this._mesage_tf = null;
			this._message_fmt = null;
			this._msgBox.filters = null;
			this._msgBox = null;
			
			this._obj.removeChild(this);
			this._obj = null;
		}
		
	}

}