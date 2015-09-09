package com.soar.utils.log {
	import com.junkbyte.console.Cc;
	import com.junkbyte.console.Console;
	import common.IEvent;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class LogAlert extends Sprite {
		private var _isError:Boolean = false;
		
		private static var instance:LogAlert;
		public static function getInstance():LogAlert {return (instance ||= new LogAlert);}
		public function LogAlert() {
			if (instance) { throw new Error("Use LogAlert.getInstance()"); }
			
			//Cc.config.style.big();
			Cc.config.style.traceFontSize = 12;
			Cc.config.style.logHeaderColor = 0x833883;
			Cc.config.style.backgroundAlpha = 0.5;
			//Cc.config.style.backgroundColor = 0x666666;
			Cc.startOnStage(this, "`");
			Cc.remoting = true;
			Cc.config.remotingPassword = "remote";
			
			Cc.config.commandLineAllowed = true;
			Cc.height = 340;
			Cc.width = 340;
			trace("Flash Console (Cc) Version:", Console.VERSION);
		}
		
		public function set disable(bool:Boolean):void {
			this._isError = bool;
		}
		
		public function toLogCh(channel:String, ... Str):void {
			Cc.logch(channel, Str);
		}
		
		/**輸出文字內容*/
		public function toLog(... Str):void {
			//trace(Str[0]);
			if (Str[0] == "IView::****CtrlNGCollect***") {
				trace("Game.CtrlNGCollect>>>LogAlert.toLog >>> AS3Loader.onEnterCollect");
				this.dispatchEvent(new IEvent("onEnterCollect"));
			}
			//trace(Str);
			if (this._isError)
				return;
			Cc.logch("Normal", Str);
		}
	
	}
}