package com.soar.events.load {
	import com.soar.utils.log.LogAlert;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/4/4 下午 06:38
	 * @version	：1.0.12
	 */
	public class KS_Loader extends Sprite {
		private var _loaders:Loader;
		private var _mcLoader:lnk_McLoader = new lnk_McLoader();
		
		public function KS_Loader() {
			this.addChild(this._mcLoader);
			LogAlert.getInstance().toLog("Loader Flashvars:", this.root.loaderInfo.parameters);
			
			var request:URLRequest = new URLRequest("/Content/swf/" + gameName + ".swf?" + token);
			
			this._mcLoader.width = stage.stageWidth;
			this._mcLoader.height = stage.stageHeight;
			
			this._loaders = new Loader()
			this._loaders.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			this._loaders.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			this._loaders.load(request);
			
			this._mcLoader.mcBar.mcProgress.txtProgress.text = "0 %";
			this._mcLoader.mcBar.gotoAndStop(1);
			
			this.stage.addEventListener(Event.RESIZE, onResize);
			this.onResize(null);
		}
		
		private function onProgress(evt:ProgressEvent):void {
			var progress:String = String(int((evt.bytesLoaded / evt.bytesTotal) * 100));
			LogAlert.getInstance().toLog("progress : " + progress + " % " )
			this._mcLoader.mcBar.gotoAndStop(progress);
			this._mcLoader.mcBar.mcProgress.txtProgress.text = progress + "%";
		}
		
		private function completeHandler(event:Event):void {
			this._mcLoader.visible = false;
			this.addChild(this._loaders);
			
			this._loaders.scaleX = (1280 / this.root.loaderInfo.parameters["Width"]);
			this._loaders.scaleY = (720 / this.root.loaderInfo.parameters["Height"]);
			
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.addChild(LogAlert.getInstance());
			this.onResize(null);
		}
	
	}

}