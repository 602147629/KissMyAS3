package com.lab.debug {
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	
	
	/**
	 * Flash 控制台日誌輸出類。
	 * <ul>
	 * <li>等效於C#中的Console類和Java中的System類。具有向控制台輸出調試信息的能力。</li>
	 * <li>此類為靜態類。您只需要調用Console.log方法，它就會向外發送日誌。</li>
	 * <li>要顯示Console.log輸出的日誌，需要一個日誌顯示器，如：
	 * http://as4game.com/console這個頁面就是一個日誌輸出器</li>
	 * </ul>
	 * 示例：
	 * <p>
	 * <code>Console.log("this a msg!");</code><br/>
	 * <code>Console.log("this a msg!","info");</code><br/>
	 * <code>Console.log("this a msg!","warn");</code><br/>
	 * <code>Console.log("this a msg!","error");</code><br/>
	 * </p>
	 * @author as4game@gmail.com
	 */
	public class Console {
		public static const CONNECT_NAME_LOGGEROUT:String = "_loggerOut";
		public static const CONNECT_NAME_LOGGERIN:String = "_loggerIn";
		
		//日誌的最大數目：能存放多少句話。
		public static var MAX_LOG_COUNT:int = 500;
		
		//實例。本類為單例模式。
		private static var _instance:Console;
		
		//本地連接對象。
		private var _lc:LocalConnection;
		//存儲調試信息
		private var _msgs:Array;
		
		/**
		 * 構造函數。
		 */
		public function Console() {
			_msgs = new Array();
			_lc = new LocalConnection();
			_lc.client = this;
			_lc.addEventListener(StatusEvent.STATUS, onStatus);
			_lc.allowDomain("*");
			try {
				_lc.connect(CONNECT_NAME_LOGGERIN);
			} catch (e:ArgumentError) {
				trace(e);
			}
		}
		
		private function onStatus(event:StatusEvent):void {
			switch (event.level) {
				case "status": 
					trace("LocalConnection.send() succeeded");
					break;
				case "error": 
					trace("LocalConnection.send() failed");
					break;
			}
		}
		
		private static function getInstance():Console {
			if (!_instance) {
				_instance = new Console();
			}
			return _instance;
		}
		
		/**
		 * 發出日誌。
		 * @param content 日誌內容。
		 * @param type 日誌類型。可選。可以為"info","warn","error"3種。默認為"info"類型。
		 * @param source 日誌來源。可選。
		 */
		public static function log(content:*, type:String = "info", source:String = null):void {
			var ins:Console = getInstance();
			var msg:Object = {content: content, type: type, source: source};
			ins._lc.send(CONNECT_NAME_LOGGEROUT, "log", msg);
			
			//記錄消息。
			ins._msgs.push(msg);
			//記錄的消息個數有上限。
			if (ins._msgs.length > MAX_LOG_COUNT) {
				ins._msgs.shift();
			}
		}
		
		/**
		 * private
		 * 此函數提供給 控制台顯示器使用。
		 * 提供給外部的回調。用於一次性獲取所有的日誌信息。日誌顯示器通常在開始會掉用此函數，
		 * 因為日誌顯示程序有可能在程序執行之後才打開，這樣可以先調用一次getLogs()來獲取已經
		 * 打印的日誌信息。
		 */
		public function getLogs():void {
			var ins:Console = getInstance();
			ins._lc.send(CONNECT_NAME_LOGGEROUT, "log", msgs);
		}
		
		/**
		 * 獲取日誌信息。
		 */
		private static function get msgs():Array {
			var ins:Console = getInstance();
			return (ins._msgs);
		}
	}
}
