package justFly.event {
	import flash.events.Event;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2015/9/5 下午 12:03
	 * @version	：1.0.2
	 */
	public class BattleStateEvent extends Event {
		
		private var _model:Object;
		
		static public const BATTLE_ENTER:String = "battleEnter";
		static public const BATTLE_READY:String = "battleReady";
		static public const BATTLE_FIGHT:String = "battleFight";
		static public const BATTLE_NEXT_ROUND:String = "battleNextRound";
		
		
		static public const ATTACK_TIME_UP:String = "attackTimerUP";
		
		static public const CREATE_MONSTER:String = "createMonster";
		
		static public const BATTLE_LOSE:String = "battleLose";
		
		public function BattleStateEvent(type:String, model:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) {
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