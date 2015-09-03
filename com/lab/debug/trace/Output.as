package lab.debug.trace {
	import flash.utils.describeType;
	
	/**
	 * ... 將物件轉換成字串彌補trace不足
	 * @author sam
	 */
	public class Output {
		private static var n:int = 0;
		private static var str:String;
		
		/**
		 * 使用語法:
		 * var obj:Object={a:2008,b:"minwt",c:["doc","tools","favorite"]};
		 * Output.echo(obj);
		 */
		// trace
		public static function echo(o:Object):void {
			trace(go(o));
		}
		
		// return the result string
		public static function go(o:Object):String {
			str = "";
			dump(o);
			// remove the lastest \n
			str = str.slice(0, str.length - 1);
			return str;
		}
		
		private static function dump(o:Object):void {
			var type:String = describeType(o).@name;
			if (type == 'Array') {
				dumpArray(o);
			} else if (type == 'Object') {
				dumpObject(o);
			} else {
				appendStr(o);
			}
		}
		
		private static function appendStr(s:Object):void {
			str += s + '\n';
		}
		
		private static function dumpArray(a:Object):void {
			n++;
			var type:String;
			for (var i:String in a) {
				type = describeType(a[i]).@name;
				if (type == 'Array' || type == 'Object') {
					appendStr(getSpaces() + "[" + i + "]:");
					dump(a[i]);
				} else {
					appendStr(getSpaces() + "[" + i + "]:" + a[i]);
				}
			}
			n--;
		}
		
		private static function dumpObject(o:Object):void {
			n++;
			var type:String;
			for (var i:String in o) {
				type = describeType(o[i]).@name;
				if (type == 'Array' || type == 'Object') {
					appendStr(getSpaces() + i + ":");
					dump(o[i]);
				} else {
					appendStr(getSpaces() + i + ":" + o[i]);
				}
			}
			n--;
		}
		
		private static function getSpaces():String {
			var s:String = "";
			for (var i:int = 1; i < n; i++) {
				s += "  ";
			}
			return s;
		}
		
		public static function SuperTrace(... args):void {
			var e:Error = new Error();
			var caller:String = "[" + e.getStackTrace().match(/[\w\/]*\(\)/g)[1] + "]";
			trace(caller, args);
		}
		
		/**
		 * trace 出顯示對象的路徑
		 * @param	t : DisplayObject
		 * @return	Path : String
		 */
		public static function getDisplayObjPath(t:DisplayObject):String {
			var a:String = getDOPath(t);
			return a;
		}
		
		private static function getDOPath(t:DisplayObject, name:String = ""):String {
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
		
		private function TaceExtra(... args):void {
			var tracemsg:String = "";
			
			for each (var obj:Object in args) {
				tracemsg = tracemsg.concat(obj + ", ");
			}
			
			tracemsg = tracemsg.substr(0, tracemsg.length - 2);
			trace(tracemsg);
		}
	
	}

}