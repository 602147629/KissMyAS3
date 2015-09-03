package com.soar.events {
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author		：g8sam « Just do it ™ »
	 * @修改者	 : Paladin
	 * @since		：2013/7/30 上午 10:19
	 * @version	：1.0.12
	 */
	
	public class EventFactory {
		/** 添加事件總數*/ 
		private static var eventCount:int = 0;
		/** 事件ID*/
		private var _dispatchers:Dictionary = new Dictionary(true);
		
		private static var instance:EventFactory;
		public static function getInstance():EventFactory { return (instance ||= new EventFactory); }
		public function EventFactory():void {if (instance) {throw new Error(" Error : Use EventFactory.getInstance() !!! ");}}
		
		/**
		 * 增加一個事件物件
		 * @param	evtObj		: EventDispatcher
		 * @param	evtType	: String
		 * @param	evtFunc	: Function
		 * @param	evtID		: String
		 */
		public function addEvent(evtObj:EventDispatcher, evtType:String, evtFunc:Function, isForeign:Boolean = false):void {
			var eventInfo:EventInfo = new EventInfo(evtType, evtFunc, isForeign);
			//儲存監聽資訊
			if (evtObj in this._dispatchers) {
				if (this.checkReAdded(this._dispatchers[evtObj], eventInfo)) {
					//LogAlert.getInstance().toLog(" EventFactory Warning : TWICE REGISTER With type >" + evtType);
					return;
				}
				this._dispatchers[evtObj].push(eventInfo);
			} else {
				this._dispatchers[evtObj] = [eventInfo];
			}
			
			eventCount++;
			this.eventProcess(evtObj, eventInfo, true);
		}
		
		/**
		 * 刪除一個 obj 指定的事件
		 * @param	evtObj		: EventDispatcher
		 * @param	evtType	: String
		 * @param	evtFunc	: Function
		 */
		public function delEventFn(evtObj:EventDispatcher, evtType:String, evtFunc:Function):void {
			if (evtObj in this._dispatchers) {
				var aryInfo:Array = this._dispatchers[evtObj];
				var leng:int = aryInfo.length;
				var info:EventInfo;
				for (var i:int = 0; i < leng; i++) {
					info = aryInfo[i];
					if (info.checkSame(evtType, evtFunc)) {
						this.eventProcess(evtObj, info, false);
						info.Destroy();
						leng > 0 ? aryInfo.splice(i, 1) : delete this._dispatchers[evtObj];
						break;
					}
				}
				eventCount--;
			}
		}
		
		/** 刪除一個obj所有的事件 */
		public function delAllEvent(evtObj:EventDispatcher, isForeign:Boolean = false):void {
			var aryInfo:Array = this._dispatchers[evtObj];
			if (aryInfo) {
				var eventInfo:EventInfo;
				var leng:int = aryInfo.length;
				for (var i:int = leng - 1; i >= 0; i--) {
					eventInfo = aryInfo[i];
					if (isForeign == eventInfo._isForeign) {
						this.eventProcess(evtObj, eventInfo, false);
						eventInfo.Destroy();
						aryInfo.splice(i, 1);
						eventCount--;
						if (aryInfo.length == 0)
							delete this._dispatchers[evtObj];
					}
				}
			}
		}
		
		/** 刪除所有對象的 所有事件 */
		public function delAllObjectAllListener():void {
			var eventInfo:EventInfo;
			var aryInfo:Array;
			var leng:int;
			for (var target:*in this._dispatchers) {
				aryInfo = this._dispatchers[target];
				leng = aryInfo.length;
				for (var i:int = leng - 1; i >= 0; i--) {
					eventInfo = aryInfo[i];
					this.eventProcess(target, eventInfo, false);
					eventInfo.Destroy();
					aryInfo.splice(i, 1);
				}
				delete this._dispatchers[target];
			}
			eventCount = 0;
		}
		
		/** 檢查重複註冊相同TYPE (131206)*/
		private function checkReAdded(targetArray:Array, info:EventInfo):Boolean {
			var leng:int = targetArray.length;
			for (var i:int = 0; i < leng; i++) {
				if (EventInfo(targetArray[i]).checkSame(info._type, info._funNotify))
					return true;
			}
			return false;
		}
		
		/** 監聽處理 */
		private function eventProcess(target:EventDispatcher, info:EventInfo, isAdd:Boolean):void {
			target[isAdd ? "addEventListener" : "removeEventListener"](info._type, info._funNotify);
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		//
		// Getter / Setter
		//
		////////////////////////////////////////////////////////////////////////////////////////////////////
		/** 當前緩存對像個數 */
		public function get instanceNum():int {
			var count:int;
			for (var name:String in this._dispatchers) {
				count++;
			}
			return count;
		}
		
		public function showListenerLog(objID:String = null):void {
			//trace("_objKey 有 : " + _objKey + " , 剩餘 : " + _objKey.length + "個");
			//trace(" 刪除後 >>> objID : " + objID + " 是 : " + _dispatchers[objID]);
			trace("剩餘事件數量 >> " + eventCount);
		}
	}
}

class EventInfo {
	public var _type:String;
	public var _funNotify:Function;
	public var _isForeign:Boolean;
	
	public function EventInfo(type:String, funNotify:Function, isForeign:Boolean):void {
		this._type = type;
		this._funNotify = funNotify;
		this._isForeign = isForeign;
	}
	
	public function checkSame(type:String, funNotify:Function):Boolean {
		return this._type == type ? this._funNotify == funNotify ? true : false : false;
	}
	
	public function Destroy():void {
		this._funNotify = null;
	}

}
