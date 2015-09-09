package justFly.view.util {
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	 /** ...
	 * @author sam
	 */
	public class Config {
		
		public function Config() {}
		
		public static function getSimpleTextField():TextField {
			var text:TextField = new TextField();
			text.selectable = false;
			text.mouseEnabled = false;
			text.autoSize = TextFieldAutoSize.CENTER;
			text.defaultTextFormat = new TextFormat("Tahoma", 12);
			return text;
		}
	
	}

}