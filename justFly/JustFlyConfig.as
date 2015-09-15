package justFly {
	import flash.utils.describeType;
	import justFly.controller.BattleStateCommand;
	import justFly.controller.GameRecordCommand;
	import justFly.event.BattleStateEvent;
	import justFly.event.SystemStateEvent;
	import justFly.model.GameModel;
	import justFly.model.GameSharedObject;
	import justFly.view.BattleMainViewMediator;
	import justFly.view.character.PlayerStatusInfoMediator;
	import justFly.view.MainViewMediator;
	import justFly.view.master.MasterMediator;
	import justFly.view.MonsterViewMediator;
	import net.ricogaming.slot.BustyBabies.View_NG;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IInjector;
	import robotlegs.bender.framework.api.ILogger;
	
	/**
	 * ...
	 * @copy		：Copyright (c) 2012, SOAR Digital Incorporated. All rights reserved. ( http://g8sam.site90.net )
	 * @author		：g8sam « Just do it ™ »
	 * @since		：2015/9/5 下午 12:03
	 * @version	：1.0.2
	 */
	public class JustFlyConfig implements IConfig {
		
		[Inject]
		public var logger:ILogger;
		
		[Inject]
		public var injector:IInjector;
		
		[Inject]
		public var commandMap:IEventCommandMap;
		
		[Inject]
		public var mediatorMap:IMediatorMap;
		
		public function JustFlyConfig() { }
	
		public function configure():void {
			/* =========================================================================== *
			 * 映射 GameMdoel 到 Content
			 * =========================================================================== */
			injector.map(GameModel).asSingleton();
			injector.map(GameSharedObject).asSingleton();
			
			/* =========================================================================== *
			 * 映射 View (畫面) 到 相關的 Mediator (傳遞者)
			 * =========================================================================== */
			mediatorMap.map(View_NG).toMediator(MainViewMediator);
			mediatorMap.map(View_NG).toMediator(MonsterViewMediator);
			mediatorMap.map(View_NG).toMediator(PlayerStatusInfoMediator);
			mediatorMap.map(View_NG).toMediator(BattleMainViewMediator);
			mediatorMap.map(View_NG).toMediator(MasterMediator);
			/* =========================================================================== *
			 * 映射 Event (事件) 到 相關的 Command (命令)
			 * =========================================================================== */
			
			for each (var state:String in describeType(BattleStateEvent).constant.@name) {
				commandMap.map(BattleStateEvent[state], BattleStateEvent).toCommand(BattleStateCommand);
			}
			for each (var sysState:String in describeType(SystemStateEvent).constant.@name) {
				commandMap.map(SystemStateEvent[sysState], SystemStateEvent).toCommand(GameRecordCommand);
			}
			 
		}
	
	}

}