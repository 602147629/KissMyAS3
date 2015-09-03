package  {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.describeType;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class EventMapper {
		private var _eventDispatcher:EventDispatcher;
		private var _eventClass:Class;
		private var _callBack:Function;
		private var _activeEvents:Vector.<String>;
		
		public function EventMapper(eventDispatcher:EventDispatcher, event:Class, callBack:Function) {
			initialize(eventDispatcher, event, callBack);
		}
		
		public function hasEvent(event:String):Boolean {
			return (_eventDispatcher && _eventDispatcher.hasEventListener(event) && _activeEvents.lastIndexOf(event) > -1);
		}
		
		public function destroy():void {
			var key:String;
			for each (key in _activeEvents) {
				if (_eventDispatcher.hasEventListener(key)) {
					try {
						_eventDispatcher.removeEventListener(key, _callBack);
					} catch (e:Error) {
					}
				}
			}
			
			while (_activeEvents.length)
				_activeEvents.pop();
			
			_activeEvents = null;
			_callBack = null;
			_eventClass = null;
			_eventDispatcher = null;
		}
		
		protected function initialize(eventDispatcher:EventDispatcher, event:Class, callBack:Function):void {
			_activeEvents = new Vector.<String>();
			_eventDispatcher = eventDispatcher;
			_eventClass = event;
			_callBack = callBack;
			
			registerEvents();
		}
		
		protected function registerEvents():void {
			const eventInfo:XML = describeType(_eventClass);
			const constants:XMLList = new XMLList(eventInfo.constant);
			
			var constant:XML;
			var constantName:String;
			var event:String;
			for each (constant in constants) {
				constantName = constant.@name.toString();
				event = _eventClass[constantName];
				
				_eventDispatcher.addEventListener(event, callbackBridge);
				_activeEvents.push(event);
			}
		}
		
		protected function callbackBridge(event:Event):void {
			if (_omissions.lastIndexOf(event.type) == -1) {
				_callBack(event);
			}
		}
		
		public function map(event:String, eventCallback:Function):void {
			if (_eventDispatcher.hasEventListener(event))
				_eventDispatcher.removeEventListener(event, _callBack);
			
			_eventDispatcher.addEventListener(event, eventCallback);
		}
		
		private var _omissions:Vector.<String> = new Vector.<String>();
		
		public function omit(event:String):void {
			_omissions.push(event);
		}
		
		public function clearOmissions():void {
			while (_omissions.length)
				_omissions.pop();
		}
	}
}