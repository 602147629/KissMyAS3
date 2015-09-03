package com.soar.events.load {
	import com.soar.events.GeneralLoadEvent;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/5/7 上午 11:34
	 * @version	：1.0.12
	 */
	
	public class GeneralLoader extends EventDispatcher {
		public const GENERAL_LOADED:String = "GeneralLoaded";
		private var loader:Loader;
		private var request:URLRequest;
		private var context:LoaderContext;
		private var loadinfo:LoaderInfo;
		private var urlLoader:URLLoader;
		
		private var sourcePaths:Array;
		private var sourceCount:int = -1;
		private var sourceTotal:int = 0;
		private var rootPath:String = "";
		
		public function GeneralLoader():void {
			this.loader = new Loader();
			this.urlLoader = new URLLoader()
			this.request = new URLRequest();
			this.context = new LoaderContext(false, ApplicationDomain.currentDomain);
			this.loadinfo = this.loader.contentLoaderInfo;
			return;
		}
		
		public function addItem(_rootPath:String, _path:Array):void {
			rootPath = _rootPath;
			sourcePaths = _path;
			sourceTotal = _path.length;
			addEvent();
			return;
		}
		
		public function Load():void {
			sourceCount++;
			
			request.url = rootPath + sourcePaths[sourceCount][0].toString();
			
			if (sourcePaths[sourceCount][1] == 0) {
				loader.load(request, context);
			} else {
				urlLoader.load(request);
			}
			return;
		}
		
		private function addEvent():void {
			loadinfo.addEventListener(Event.COMPLETE, onComplete);
			loadinfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			loadinfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
			loadinfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
			urlLoader.addEventListener(Event.COMPLETE, urlLoaderHandle);
			return;
		}
		
		private function removeEvent():void {
			loadinfo.removeEventListener(Event.COMPLETE, onComplete);
			loadinfo.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			loadinfo.removeEventListener(IOErrorEvent.IO_ERROR, onError);
			loadinfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
			urlLoader.removeEventListener(Event.COMPLETE, urlLoaderHandle);
			return;
		}
		
		public function Destory():void {
			removeEvent();
			loader.unloadAndStop();
			sourcePaths = null;
			urlLoader = null;
			loader = null;
		}
		
		private function onComplete(event:Event):void {
			this.dispatchEvent(new GeneralLoadEvent(GENERAL_LOADED, sourceCount, sourceTotal, "", loadinfo));
			return;
		}
		
		private function urlLoaderHandle(e:Event):void{
        	this.dispatchEvent(new GeneralLoadEvent( GENERAL_LOADED ,sourceCount,sourceTotal,"",urlLoader.data));	
        }
		
		private function onProgress(evt:ProgressEvent):void {
			var dateByte:int = Math.ceil(evt.bytesLoaded / evt.bytesTotal * 100);
			this.dispatchEvent(new GeneralEvent( "Progress" , null , dateByte ));
			return;
		}
		
		private function onError(event:Event):void {
			this.dispatchEvent(event);
			return;
		}
		
		public function getClass( clsName:String):Class {
			var cls:Class;
			var name:String = clsName;
			
			try {
				if (this.loadinfo) {
					cls = this.loadinfo.applicationDomain.getDefinition(name) as Class;
				} else {
					cls = getDefinitionByName(name) as Class;
				}
			} catch (e:ReferenceError) {
				return null;
			}
			
			return cls;
		}
	
	}
}