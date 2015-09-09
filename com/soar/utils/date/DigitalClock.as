package com.soar.utils.date{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class DigitalClock {
		private var my_date:Date;
		private var months_en:Array = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
		private var months_ch:Array = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
		private var days_en:Array = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
		private var days_ch:Array = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
		
		public function DigitalClock():void {
			my_date = new Date();
			trace(my_date);
			trace("months : " + months_ch[my_date.month]);
			trace("days : " + days_ch[my_date.day]);
		}
		
		public function tokiGo():void {
			var my_timer:Timer = new Timer(1000);
			my_timer.addEventListener(TimerEvent.TIMER, onTimer);
			my_timer.start();
		}
		
		private function onTimer(e:TimerEvent):void {
			my_date = new Date();
			trace(my_date.hours + ":" + my_date.minutes + ":" + my_date.seconds);
		}
		
	}
}