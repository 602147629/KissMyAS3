package justFly.utility {
	import com.junkbyte.console.Cc;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2015/9/5 下午 12:03
	 * @version	：1.0.2
	 */
	public class JustFightUtil {
		
		private static var instance:JustFightUtil;
		public static function getInstance():JustFightUtil { return (instance ||= new JustFightUtil); }
		public function JustFightUtil():void { if (instance) { throw new Error(" Error : Use JustFightUtil.getInstance() !!! "); }}
		
		public function getSimpleTextField():TextField {
			var text:TextField = new TextField();
			text.selectable = false;
			text.mouseEnabled = false;
			text.autoSize = TextFieldAutoSize.CENTER;
			text.defaultTextFormat = new TextFormat("Tahoma", 12);
			return text;
		}
		
		/**
		 * 隨機獲得一個漢字
		 * @return String
		 */
		public function randomChar():String {
			var index:int = 19968 + (30000 - 19968) * Math.random();
			return String.fromCharCode(index);
		}
		
		public function createNewName():String {
			var ran:int = int(Math.random() * 6) +2;
			var tmpName:String = "";
			
			for (var i:int = 0; i < ran; i ++ ) {
				tmpName += randomChar();
			}
			
			Cc.logch(this , "Player Name [ " + tmpName + " ] ");
			return tmpName;
		}
		
		public function createChineseName():String {
			var ran:int;
			var dict:Array;
			var firstName:String;
			var lastName:String;
			
			//姓
			dict = ChineseRandomName.lastName.split(" ");
			ran = (Math.random() * dict.length);
			lastName = dict[ran];
			
			//名
			dict = ChineseRandomName.firstName.split(" ");
			ran = (Math.random() * dict.length);
			firstName = dict[ran];
			
			Cc.logch(this , "Player Name [ " + lastName + " " + firstName + " ] ");
			return lastName + firstName;
		}
	
	}

}