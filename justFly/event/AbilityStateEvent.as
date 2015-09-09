package justFly.event {
	import flash.events.Event;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2015/9/5 下午 12:03
	 * @version	：1.0.2
	 */
	
	public class AbilityStateEvent extends Event {
		
		private var _model:Object;
		
		public function AbilityStateEvent(type:String, model:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			this._model = model;
		}
		
		public function get model():Object {
			return _model;
		}
		
		public function set model(model:Object):void {
			this._model = model;
		}
	
	}

}