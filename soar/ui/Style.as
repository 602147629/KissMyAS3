package com.soar.ui{
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/3/18 上午 11:19
	 * @version	：1.0.12
	 */
	
	public class Style {
		public static var TEXT_BACKGROUND:uint = 0xFFFFFF;
		public static var BACKGROUND:uint = 0xCCCCCC;
		public static var BUTTON_FACE:uint = 0xFFFFFF;
		public static var BUTTON_DOWN:uint = 0xEEEEEE;
		public static var INPUT_TEXT:uint = 0x333333;
		public static var LABEL_TEXT:uint = 0x666666;
		public static var DROPSHADOW:uint = 0x000000;
		public static var PANEL:uint = 0xF3F3F3;
		public static var PROGRESS_BAR:uint = 0xFFFFFF;
		public static var LIST_DEFAULT:uint = 0xFFFFFF;
		public static var LIST_ALTERNATE:uint = 0xF3F3F3;
		public static var LIST_SELECTED:uint = 0xCCCCCC;
		public static var LIST_ROLLOVER:uint = 0XDDDDDD;
		
		
		public static var BUTTON_GRADIENT:Array = [ 0xfefefe, 0xcccccc];
		public static var BUTTON_GLOW:uint = 0x336699;
		public static var BUTTON_LINE_STYLE:uint = 0xaaaaaa;
		
		
		public static var embedFonts:Boolean = false;
		public static var fontName:String = "Verdana";
		public static var fontSize:Number = 12;
		
		public static const DARK:String = "dark";
		public static const LIGHT:String = "light";
		public static const GALAXY:String = "galaxy";
		
		/**
		 * UI 組件樣式 
		 */
		public static function setStyle(style:String):void {
			switch (style) {
				case GALAXY:
					Style.fontName = "Verdana";
					Style.BACKGROUND = 0xefefef;
					Style.PROGRESS_BAR = 0x6699CC;
					Style.LABEL_TEXT = 0x666666;
					Style.BUTTON_GRADIENT = [ 0xfefefe, 0xcccccc];
					Style.BUTTON_GLOW = 0x0064CD;
					Style.BUTTON_LINE_STYLE = 0xcccccc;
					break;
				case DARK: 
					Style.BACKGROUND = 0x444444;
					Style.BUTTON_FACE = 0x666666;
					Style.BUTTON_DOWN = 0x222222;
					Style.INPUT_TEXT = 0xBBBBBB;
					Style.LABEL_TEXT = 0xCCCCCC;
					Style.PANEL = 0x666666;
					Style.PROGRESS_BAR = 0x666666;
					Style.TEXT_BACKGROUND = 0x555555;
					Style.LIST_DEFAULT = 0x444444;
					Style.LIST_ALTERNATE = 0x393939;
					Style.LIST_SELECTED = 0x666666;
					Style.LIST_ROLLOVER = 0x777777;
					break;
				case LIGHT: 
				default: 
					Style.BACKGROUND = 0xCCCCCC;
					Style.BUTTON_FACE = 0xFFFFFF;
					Style.BUTTON_DOWN = 0xEEEEEE;
					Style.INPUT_TEXT = 0x333333;
					Style.LABEL_TEXT = 0x666666;
					Style.PANEL = 0xF3F3F3;
					Style.PROGRESS_BAR = 0xFFFFFF;
					Style.TEXT_BACKGROUND = 0xFFFFFF;
					Style.LIST_DEFAULT = 0xFFFFFF;
					Style.LIST_ALTERNATE = 0xF3F3F3;
					Style.LIST_SELECTED = 0xCCCCCC;
					Style.LIST_ROLLOVER = 0xDDDDDD;
					break;
			}
		}
	}
}