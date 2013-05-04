package com.soar.debug {
	
	public class SuperTrace {
		
		public static function SuperTrace(... args):void {
			var e:Error = new Error();
			var caller:String = "[" + e.getStackTrace().match(/[\w\/]*\(\)/g)[1] + "]";
			trace(caller, args);
		}
	}
}