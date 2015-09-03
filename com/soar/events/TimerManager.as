package com.soar.events {
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.getTimer;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class TimerManager extends Sprite {
		private var delay:Number;
		private var repeat:int;
		private var gTimer:Timer;
		private var event:String;
		
		protected var time:Number // user time in ms since Uinx epoch
		private var regulatorAcc:int // ms accumulated since last 'tick'
		private var regulatorCache:int = 0 // previous value of getTimer()
		
		public function TimerManager(_delay:int, _rept:int, event:String):void {
			this.delay = _delay;
			this.repeat = _rept;
			this.event = event;
			this.init();
		}
		
		public function init():void {
			this.regulatorAcc = 0;
			this.setRealTimeValue();
			this.gTimer = new Timer(this.delay, this.repeat);
			//trace( "You have " + ((delay * repeat) / 1000) + " seconds to enter your response.");
			this.gTimer.addEventListener(TimerEvent.TIMER, timerHandler);
			this.gTimer.addEventListener(TimerEvent.TIMER_COMPLETE, completeHandler);
		}
		
		// convenient 'real time' functions
		public function setRealTimeValue():void {
			var d:Date = new Date();
			this.time = d.valueOf();
		}
		
		public function startTimer():void {
			if (this.gTimer == null) {
				this.init();
			}
			this.regulatorCache = getTimer();
			this.gTimer.start();
		}
		
		private function timerHandler(e:TimerEvent):void {
			repeat--;
			//trace(  ((delay * repeat) / 1000) + " seconds left." );
			var regulatorNew:int = getTimer(); // get system timer value
			var regulatorDelta:int = regulatorNew - regulatorCache; // calculate elapsed time since last 'tick'
			regulatorAcc += regulatorDelta; // increment accumulator
			
			//trace ( "regulator accumulator = " + regulatorAcc );
			// check for a tick
			if (regulatorAcc > delay) {
				regulatorAcc -= delay; // reset accumulator
				if (delay - regulatorAcc > 0) {
					//trace("delay:" + (delay - regulatorAcc));
					gTimer.delay = delay - regulatorAcc;
						//trace( "大" );
				}
			} else {
				regulatorAcc = 0;
				gTimer.delay = delay;
					//trace( "小" );
			}
			//trace("regulatorDelta:" + regulatorDelta);
			//trace("regulatorAcc:" + regulatorAcc);
			regulatorCache = regulatorNew // cache previous regulator	value
			this.dispatchEvent(new GeneralEvent(event));
		}
		
		private function completeHandler(e:TimerEvent):void {
			trace(" ===== TIMES_UP ===== ");
			this.dispatchEvent(new GeneralEvent("TIMES_UP"));
		}
		
		public function stopTimer():void {
			this.gTimer.stop();
			this.gTimer.removeEventListener(TimerEvent.TIMER, timerHandler);
			this.gTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, completeHandler);
			this.gTimer = null;
		}
		
		public function getRepeat():int {
			return this.repeat;
		}
		
		public function getTimerClass():Timer {
			return this.gTimer;
		}
	}
}