package com.soar.utils {
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
	
	public class RightClickMenu {
		
		public function RightClickMenu():void {
			var fm_menu:ContextMenu = new ContextMenu();
			var copyright:ContextMenuItem = new ContextMenuItem("Created by www.soar.com");
			var credit:ContextMenuItem = new ContextMenuItem("Grid Slider Click [0.5]");
			
			copyright.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, visit_flashmo);
			credit.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, visit_grid_slider);
			credit.separatorBefore = false;
			
			fm_menu.hideBuiltInItems();
			fm_menu.customItems.push(copyright, credit);
			this.contextMenu = fm_menu;
		}
		
		private function visit_flashmo(e:Event):void {
			var flashmo_link:URLRequest = new URLRequest("http://www.flashmo.com");
			navigateToURL(flashmo_link, "_parent");
		}
	
	}
}