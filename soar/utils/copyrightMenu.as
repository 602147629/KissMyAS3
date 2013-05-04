package com.soar.utils{
	import flash.display.InteractiveObject;
	import flash.events.ContextMenuEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class copyrightMenu {
		private var myName:Array = new Array("SOAR", "Flash Action Script 3.0", "http://www.soar.com");
		private var myUrl:String = "http://www.soar.com";
		private var i:Number;
		private var num:Number = 3;
		private var target:InteractiveObject;
		
		public function copyrightMenu(target:InteractiveObject) {
			this.target = target;
			this.myItem();
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