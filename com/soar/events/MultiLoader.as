package com.soar.events {
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class MultiLoader extends EventDispatcher {
		private var sourcePaths:Array;
		private var sourceCount:int = -1;
		private var sourceTotal:int = 0;
		private var rootPath:String = "";
		
		private var loader:Loader = new Loader();
		private var urlLoader:URLLoader = new URLLoader();
		
		public function MultiLoader(rootPath:String, _path:Array) {
			this.rootPath = rootPath;
			sourcePaths = _path;
			sourceTotal = _path.length;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, LoadHandle);
			urlLoader.addEventListener(Event.COMPLETE, urlLoaderHandle);
		}
		
		public function Load():void {
			loader.unload();
			sourceCount++;
			if (sourcePaths[sourceCount][1] == 0) {
				//trace(this.rootPath +sourcePaths[sourceCount][0].toString());
				loader.load(new URLRequest(this.rootPath + sourcePaths[sourceCount][0].toString()));
			} else {
				urlLoader.load(new URLRequest(this.rootPath + sourcePaths[sourceCount][0].toString()));
			}
			//trace(sourcePaths[sourceCount].toString());
		}
		
		public function Destory():void {
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, LoadHandle);
			urlLoader.removeEventListener(Event.COMPLETE, urlLoaderHandle);
			loader.unloadAndStop();
			sourcePaths = null;
			urlLoader = null;
			loader = null;
		}
		
		private function LoadHandle(e:Event):void {
			this.dispatchEvent(new MultiLoadEvent("MultiLoadEvent", sourceCount, sourceTotal, "", loader.contentLoaderInfo));
		}
		
		private function urlLoaderHandle(e:Event):void {
			this.dispatchEvent(new MultiLoadEvent("MultiLoadEvent", sourceCount, sourceTotal, "", urlLoader.data));
		}
	
	}
}