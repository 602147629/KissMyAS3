package com.lab.debug {
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.sampler.getSize;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @copy   ：Copyright (c) 2008, SOAR Digital Incorporated. All rights reserved.
	 * @author ：g8sam
	 * @since   ：2013/1/8 下午 04:42
	 * @version：1.0.12
	 */
	public class ObjectUseMemoryByte {
		private var size:Number;
		
		public function ObjectUseMemoryByte():void {
			
			size = getSize(new int());
			trace("int 字節 :" + size); //輸出：4
			
			size = getSize(new uint());
			trace("uint 字節 :" + size); //輸出：4

			size = getSize(new Number());
			trace("Number 字節 :" + size); //輸出：4
			
			size = getSize(new String());
			trace("String 字節 :" + size); //輸出：24
			
			size = getSize(new Object());
			trace("Object 字節 :" + size); //輸出：40
			
			size = getSize(new Vector.<int>());
			trace("Vector.<int> 字節 :" + size); //輸出：76
			
			size = getSize(new Array());
			trace("Array 字節 :" + size); //輸出：88
			
			size = getSize(new Bitmap());
			trace("Bitmap 字節 :" + size); //輸出：236
			
			size = getSize(new Shape());
			trace("Shape 字節 :" + size); //輸出：236
			
			size = getSize(new SimpleButton());
			trace("SimpleButton 字節 :" + size); //輸出：252
			
			size = getSize(new Sprite());
			trace("Sprite 字節 :" + size); //輸出：404
			
			size = getSize(new MovieClip());
			trace("MovieClip 字節 :" + size); //輸出：440
			
			size = getSize(new TextField());
			trace("TextField 字節 :" + size); //輸出：1024
			
		}
		
		//使用的内存
		public function getTotalMemory():String {
			var mem:String = Number( System.totalMemory / 1024 / 1024 ).toFixed( 2 ) + "Mb";
			trace(mem);
		}
		
	}
}