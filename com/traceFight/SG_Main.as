package com.traceFight{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author g8sam
	 */
	public class  SG_Main extends Sprite{
		public static var Hero:PlayerData2 = new PlayerData2();
		private var $FightRound:FightRound ;
		
		public function SG_Main():void {
			init();
		}
		
		private function init():void {
			Hero.IDNum = "英雄";
			Hero.STRNum = 400;
			Hero.AGINum = 60;
			Hero.VITNum = 10;
			Hero.DEXNum = 50;
			Hero.SpeedNum = 150;
			//Hero.DmgIn(800, 20 , 1.2 , 5 ,false);
			
			var bl:Sprite = new Sprite();
			bl.graphics.beginFill(0xffffff);
			bl.graphics.drawRect(100, 100, 50, 50);
			bl.graphics.endFill();
			bl.addEventListener(MouseEvent.CLICK, fightRound);
			this.addChild(bl);
		}
		
		private function fightRound(e:MouseEvent):void {
			$FightRound = new FightRound();
			this.addChild($FightRound);
		}
		
	}
}