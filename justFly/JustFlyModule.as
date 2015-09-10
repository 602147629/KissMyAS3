package justFly {
	
	import justFly.event.SystemStateEvent;
	import justFly.view.util.JustFightUtil;
	import net.ricogaming.core.base.GameModule;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2015/9/5 下午 12:03
	 * @version	：1.0.2
	 */
	public class JustFlyModule extends GameModule {
		
		public function JustFlyModule() {
			context.configure(JustFlyConfig);
		}
		
		override public function init():void {
			super.init();
			
			this.contextView.view.focusRect = false;
			this.dispatchEvent(new SystemStateEvent(SystemStateEvent.LOAD_RECORD));
		}
	
	}

}