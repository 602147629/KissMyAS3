package soar.air.utils{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.FileReference;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @copy		 : Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author		 : g8sam « Just do it ™ »
	 * @since		 : 2015/1/5 上午 10:14
	 * @version	 : 1.0.2
	 */
	public class DownLoadManager {
		private var urlText:TextField = new TextField();
		private var fr:FileReference = new FileReference();
		
		public function DownLoadManager(){
			addChild(urlText);
			urlText.border = true;
			urlText.borderColor = 0x999999;
			urlText.type = TextFieldType.INPUT;
			var spt:Sprite = new Sprite();
			var Btntext:TextField = new TextField();
			Btntext.text = "DOWNLOAD";
			Btntext.border = true;
			Btntext.borderColor = 0x000000;
			Btntext.backgroundColor = 0x333333;
			spt.addChild(Btntext);
			
			addChild(spt);
			spt.x = 100;
			spt.y = 300;
			fr.addEventListener(Event.OPEN, openHandler);
			fr.addEventListener(Event.COMPLETE, completeHandler);
			fr.addEventListener(IOErrorEvent.IO_ERROR, ioerrorHd);
			spt.addEventListener(MouseEvent.CLICK, startDownload);
		}
		
		public function cancelDownload(event:MouseEvent):void {
			fr.cancel();
		}
		
		public function startDownload(event:MouseEvent):void {
			var request:URLRequest = new URLRequest();
			request.url = urlText.text;
			fr.download(request);
		}
		
		public function openHandler(event:Event):void {
			trace("open");
		}
		
		//下載處理函數，用進度條顯示下載速度
		public function progressHandler(event:ProgressEvent):void {
			//downloadProgress.setProgress(event.bytesLoaded,event.bytesTotal);
			trace("prog");
		}
		
		public function completeHandler(event:Event):void {
			//downloadProgress.setProgress(0,100);
			//download.enabled = false;
			trace("ok");
		}
		
		public function ioerrorHd(event:IOErrorEvent):void {
			trace("不能下載該文件");
		}
		
	}

}