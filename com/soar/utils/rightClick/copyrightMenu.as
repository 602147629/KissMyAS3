/**

   The MIT License

   Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )

   Permission is hereby granted, free of charge, to any person obtaining a copy
   of this software and associated documentation files (the "Software"), to deal
   in the Software without restriction, including without limitation the rights
   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
   copies of the Software, and to permit persons to whom the Software is
   furnished to do so, subject to the following conditions:

   The above copyright notice and this permission notice shall be included in
   all copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
   THE SOFTWARE.

 **/
package com.soar.utils.rightClick {
	import flash.display.InteractiveObject;
	import flash.events.ContextMenuEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class copyrightMenu {
		private var myName:Array = new Array("SOAR", "SOAR Digital Incorporated", "http://www.soar.com");
		private var myUrl:String = "http://g8sam.site90.net";
		private var i:Number;
		private var num:Number = 3;
		private var target:InteractiveObject;
		private var version:String = "1.0.12";
		
		public function copyrightMenu(target:InteractiveObject) {
			this.target = target;
			this.myItem();
		}
		
		public function addVersion(version:String, isHide:Boolean = true):void {
			var myContextMenu:ContextMenu = new ContextMenu();
			if (isHide) {
				myContextMenu.hideBuiltInItems();
			}
			
			if (myContextMenu.customItems != null) {
				var mAuthor:ContextMenuItem = new ContextMenuItem("版本:" + version);
				myContextMenu.customItems.push(mAuthor);
				this.contextMenu = myContextMenu;
			}
		}
		
		private function myItem():void {
			var myContextMenu = new ContextMenu();
			myContextMenu.hideBuiltInItems();
			
			for (i = 0; i < num; i++) {
				var item:ContextMenuItem = new ContextMenuItem(myName[i]);
				myContextMenu.customItems.push(item);
				target.contextMenu = myContextMenu;
				item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, itemSelectHandler);
			}
		}
		
		private function itemSelectHandler(e:ContextMenuEvent):void {
			navigateToURL(new URLRequest(myUrl), "_blank");
		}
	}
}