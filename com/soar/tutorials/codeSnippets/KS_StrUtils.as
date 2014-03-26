package soar.tutorials.codeSnippets {
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/8/8 上午 10:55
	 * @version	：1.0.12
	 */
	
	public class KS_StrUtils {
		
		public function KS_StrUtils() {
			testSystem();
		}
		
		public function testSystem():void {
			var txt:String = "FF6600";
			
			txt = systemChange(txt, 16, 10); //16轉10
			trace(txt); //輸出: 16737792
			
			txt = systemChange(txt, 10, 8); //10轉8
			trace(txt); //輸出: 77663000
			
			txt = systemChange(txt, 8, 2); //8轉2
			trace(txt); //輸出: 111111110110011000000000
			
			txt = systemChange(txt, 2, 32); //2轉32
			trace(txt); //輸出: fupg0
			
			txt = systemChange(txt, 32, 16); //32轉16
			trace(txt); //輸出: ff6600
		}
		
		/*
		 * 用parseInt把2/8/10/16/32進制轉換成10進制，
		 * 用toString把10進制轉換成2/8/10/16/32進制。
		 */
		public function systemChange(txt:String, radix:uint, target:uint):String {
			var num:Number = parseInt(txt, radix); //把2~32進制轉換為10進制
			return num.toString(target); //把10進制轉換為2~32進制
		}
	
	}

}