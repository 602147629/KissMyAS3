package {
	import Basic.GeneralEvent;
	import flash.events.EventDispatcher;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved.
	 * @author	：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class SyntaxColor extends EventDispatcher{
		private var rightTf_fmt:TextFormat = new TextFormat("Verdana", 28, 0x999999, true, null, null, null, null, "left");
		private var resource:Array = [["/resource/GameBtn_src.swf", 0], ["/resource/number_src.swf", 0], ["/resource/fruit_src.swf", 0], ["/resource/animal_src.swf", 0]];
		
		public function SyntaxColor {
			this.tempPractice.x = ((836 - 190 * 3) / 4) * 1 + 0 * 190 + 94;
			this.dispatchEvent(new GeneralEvent("CLOSED_BLACKGROUND", "false"));
			//addEventListener(Event.ENTER_FRAME, update, false, 0, true);
			
			///addEventListener(Event.ENTER_FRAME, update, false, 0, true);
			
			/**
			 * addEventListener(Event.ENTER_FRAME, update, false, 0, true);
			 */ 
			
			/*
			 * addEventListener(Event.ENTER_FRAME, update, false, 0, true);
			 */ 
			
			 #navigateToURL( new URLRequest( targetURL ) , targetTag) ;
			/navigateToURL( new URLRequest( targetURL ) , targetTag) ;
		}
	}
}