package justFly.view.util {
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class XMLParser {
		private var xmlLoader:URLLoader;
		private var url:URLRequest;
		
		public function XMLParser() {
			xmlLoader = new URLLoader();
			url = new URLRequest("products.xml");
			xmlLoader.load(url);
			xmlLoader.addEventListener(Event.COMPLETE, onXmlLoad);
		}
		
		public function 
	
	}

}