package com.lab.tutorials.codeSnippets {
	import flash.display.Sprite;

	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/8/12 下午 03:25
	 * @version	：1.0.12
	 */

	public class Tutorials_Array extends Sprite {
		private var _listA:Array = [ "ATK : " + 900 ];
		private var _listB:Array = [ "DEF : " + 70 ];
		private var _listC:Array = [ "VIT : " + 100 ];
		private var _listD:Array = [ "HIT : " + 100];
		private var _listE:Array = [ "LUK : " + 100];
		
		
		private var List_Concat:Array = [];
		private var List_Slice:Array = [];
		private var List_Splice:Array = [];
		
		public function Tutorials_Array():void {
			this._concat();
			this._slice();
			this._splice();
		}
		
		//連結陣列：陣列 A.concat(陣列 B, 陣列 c…)
		public function _concat():void {
			List_Concat = _listA.concat( _listB , _listC , _listD , _listE);
			trace( "List_Concat : " + List_Concat );
			//List_Concat : ATK : 900,DEF : 70,VIT : 100,HIT : 100,LUK : 100
		}
		
		//分割陣列：slice(a,b) 從「a 的序號」取「b」個元素，將其重建一個陣列，且保留原陣列。
		public function _slice():void {
			var ListShadow:Array = List_Concat.concat();
			
			List_Slice = ListShadow.slice( 0 , 2);
			trace( "List_Slice : " + List_Slice );
			//List_Slice : ATK : 900,DEF : 70
		}
		
		public function _splice():void {
			var ListShadow:Array = List_Concat.concat();
			
			List_Splice = ListShadow.splice( 1, 3 );
			trace( "List_Splice : " + List_Splice );
			//List_Splice : DEF : 70,VIT : 100,HIT : 100
		}

	}
}