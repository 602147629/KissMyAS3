package com.soar.utils.array {
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class StrUtil {
		
		public function StrUtil() {
			var str:String = "hello world!";
			for (var i:int = 0; i < str.length; i++) {
				trace(str.charAt(i), "-", str.charCodeAt(i));
			}
		}
		
		//刪除數組裡的重複數據
		var arr:Array = new Array("a", "b", "a", "c", "d", "b");
		removeDuplicate(arr);
		public function removeDuplicate(arr:Array):void {
			var i:int;
			var j:int;
			for (i = 0; i < arr.length - 1; i++) {
				for (j = i + 1; j < arr.length; j++) {
					if (arr[i] === arr[j]) {
						arr.splice(j, 1);
					}
				}
			}
		}
		
		
	
	}

}