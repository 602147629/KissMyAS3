package com.soar.events.load {
	import flash.display.Loader;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class MultiLoader extends EventDispatcher {
		public const PROGRESS:String = "progress";
		public const MULTI_LOADED:String = "MultiLoaded";
		public const LOAD_ERROR:String = "loadError";
		public const HTTP_STATUS:String = "httpStatus";
		
		private var sourcePaths:Array;
		private var sourceCount:int = -1;
		private var sourceTotal:int = 0;
		private var rootPath:String = "";
		private var loader:Loader;
		private var urlLoader:URLLoader;
		private var context:LoaderContext;
		
		public function MultiLoader(rootPath:String, _path:Array) {
			this.rootPath = rootPath;
			this.sourcePaths = _path;
			this.sourceTotal = _path.length;
			
			this.loader = new Loader();
			this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, LoadHandle);
			this.loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			this.loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			this.loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			this.urlLoader = new URLLoader();
			this.urlLoader.addEventListener(Event.COMPLETE, urlLoaderHandle);
		}
		
		public function Load():void {
			sourceCount++;
			
			if (sourcePaths[sourceCount][1] == 0) {
				context = new LoaderContext();
				context.applicationDomain = ApplicationDomain.currentDomain;
				loader.load(new URLRequest(this.rootPath + sourcePaths[sourceCount][0].toString()) , context);
			} else {
				urlLoader.load(new URLRequest(this.rootPath + sourcePaths[sourceCount][0].toString()));
			}
		}
		
		/**
		 * 獲取到swf定義的類：
		 * @param	className :String
		 * @return	Class
		 * @example	var cls:Class = loader.contentLoaderInfo.applicationDomain.getDefinition("ToolBar");
		 */
		public function getClass(className:String):Class {
			try {
				return loader.contentLoaderInfo.applicationDomain.getDefinition(className) as Class;
			} catch (e:Error) {
				throw new IllegalOperationError(className + " definition not found in " + rootPath);
			}
			return null;
		}
		
		/**
		 * 釋放記憶體
		 */
		public function Destory():void {
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, LoadHandle);
			urlLoader.removeEventListener(Event.COMPLETE, urlLoaderHandle);
			loader.unloadAndStop();
			sourcePaths = null;
			urlLoader = null;
			loader = null;
		}
		
		public function unload():void {
			loader.unload();
		}
		
		private function LoadHandle(e:Event):void {
			this.dispatchEvent(new MultiLoadEvent( MULTI_LOADED , sourceCount, sourceTotal, "", loader.contentLoaderInfo));
		}
		
		private function urlLoaderHandle(e:Event):void {
			this.dispatchEvent(new MultiLoadEvent( MULTI_LOADED , sourceCount, sourceTotal, "", urlLoader.data));
		}
		
		private function progressHandler(evt:ProgressEvent):void {
			var dateByte:int = Math.ceil(evt.bytesLoaded / evt.bytesTotal * 100);
			this.dispatchEvent( new GeneralEvent( PROGRESS , null , dateByte) );
		}
		
		private function ioErrorHandler(e:Event):void {
			//trace( " > MultiLoader.ioErrorHandler : " + e.toString() );
			this.dispatchEvent(new MultiLoadEvent(LOAD_ERROR , sourceCount, sourceTotal, "" , null ) );
		}
		
		private function securityErrorHandler(e:Event):void {
			//trace( " > MultiLoader.securityErrorHandler : " + e.toString());
			this.dispatchEvent(new MultiLoadEvent(LOAD_ERROR , sourceCount, sourceTotal, "" , null ) );
		}
		
		private function httpStatusHandler(e:HTTPStatusEvent):void {
			//trace( " > MultiLoader.httpStatusHandler : " + e.status );
			this.dispatchEvent(new MultiLoadEvent(HTTP_STATUS, sourceCount, sourceTotal, "" , null ) );
		}
	
	}
}