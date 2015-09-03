package com.soar.events.load {
	import com.soar.events.GeneralEvent;
	import flash.display.Loader;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/4/4 下午 06:38
	 * @version	：1.0.12
	 */
	
	public class ClassLoader extends EventDispatcher {
		public const CLASS_LOADED:String = "classLoaded";
		public const LOAD_ERROR:String = "loadError";
		public const PROGRESS:String = "progress";
		public var BytesLoaded:Number = 0;
		public var BytesTotal:Number = 0;
		private var loader:Loader;
		private var swfLib:String;
		private var request:URLRequest;
		private var loadedClass:Class;
		
		public function ClassLoader():void {
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
		}
		
		private function progressHandler(e:ProgressEvent):void {
			var dateByte:Number = (e.bytesLoaded / e.bytesTotal)*100;
			dispatchEvent( new GeneralEvent( PROGRESS , null ,dateByte.toString() ) );
		}
		
		public function load(lib:String):void {
			swfLib = lib;
			request = new URLRequest(swfLib);
			var context:LoaderContext = new LoaderContext();
			context.applicationDomain = ApplicationDomain.currentDomain;
			loader.load(request, context);
		}
		
		public function getClass(className:String):Class {
			/*
			   var loaderoader = new Loader();
			   加載成功後，使用：
			   var cls:* = loader.contentLoaderInfo.applicationDomain.getDefinition("ToolBar");
			   就可以獲取到swf定義的類
			 */
			try {
				return loader.contentLoaderInfo.applicationDomain.getDefinition(className) as Class;
			} catch (e:Error) {
				throw new IllegalOperationError(className + " definition not found in " + swfLib);
			}
			return null;
		}
		
		private function completeHandler(e:Event):void {
			dispatchEvent(new GeneralEvent(CLASS_LOADED));
		}
		
		private function ioErrorHandler(e:Event):void {
			dispatchEvent(new GeneralEvent(LOAD_ERROR));
		}
		
		private function securityErrorHandler(e:Event):void {
			dispatchEvent(new GeneralEvent(LOAD_ERROR));
		}
		
		public function distory():void {
			loader.unloadAndStop();
			loader = null;
		}
	}
}