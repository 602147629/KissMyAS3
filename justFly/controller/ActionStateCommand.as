package justFly.controller {
	import robotlegs.bender.bundles.mvcs.Command;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.api.ILogger;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2013/3/16 下午 12:03
	 * @version	：1.0.12
	 */
	
	public class ActionStateCommand extends Command {
		
		[Inject]
		public var logger:ILogger;
		
		[Inject]
		public var contextView:ContextView;
		
		public function ActionStateCommand() {
			super();
		}
		
		override public function execute():void {
			
		}
	
	}

}