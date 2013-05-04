package {
	import flash.display.DisplayObject;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2008, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam
	 * @since		：2013/3/2 上午 11:39
	 * @version	：1.0.12
	 */
	
	public class TraceUtils {
		
		public function TraceUtils():void {
		
		}
		
		/**
		 * trace 出顯示對象的路徑
		 */
		public static function getDisplayObjPath(t:DisplayObject):String {
			var a:String = getDOPath(t);
			return a;
		}
		
		private static function getDOPath(t:DisplayObject, name:String = "") :String{
			if (name == "") {
				name = t.name;
			} else {
				name = t.name + "." + name;
			}
			
			if (t.parent.name) {
				return getDOPath(t.parent, name);
			} else {
				return name;
			}
		}
	}
}