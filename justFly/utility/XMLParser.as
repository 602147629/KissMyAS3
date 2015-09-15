package justFly.utility {
	import com.junkbyte.console.Cc;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class XMLParser {
		
		private var _xmlLoader:URLLoader;
		private var _url:URLRequest;
		
		public function XMLParser() {
			this._xmlLoader = new URLLoader();
			this._url = new URLRequest("char.xml");
			this._xmlLoader.load(this._url);
			this._xmlLoader.addEventListener(Event.COMPLETE, onXmlLoad);
		}
		
		public function onXmlLoad(e:Event):void {
			var xml:XML = new XML(e.target.data);
			
			for (var i:int = 0; i < xml.record.length(); i++) {
				trace("record [ " + (i + 1) + " ], charName : " + xml.record[i].charName);
				trace("record [ " + (i + 1) + " ], master : " + xml.record[i].master);
				trace("record [ " + (i + 1) + " ], comment : " + xml.record[i].comment);
			}
			
			var obj:Object;
			for each (obj in xml.record) {
				Cc.log(" OBJ : " + obj);
			}
		}
	
	}

}