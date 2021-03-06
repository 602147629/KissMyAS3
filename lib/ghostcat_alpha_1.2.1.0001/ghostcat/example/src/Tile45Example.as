package
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	
	import ghostcat.debug.EnabledSWFScreen;
	import ghostcat.debug.FPS;
	import ghostcat.display.GBase;
	import ghostcat.display.game.Display45Util;
	import ghostcat.display.game.Tile45;
	import ghostcat.display.game.TileGameLayer;
	import ghostcat.manager.DragManager;
	import ghostcat.parse.display.TextFieldParse;
	import ghostcat.ui.CursorSprite;
	
	
	
	[SWF(width="600",height="600",frameRate="60")]
	
	/**
	 * 45度场景
	 * 
	 * @author flashyiyi
	 * 
	 */
	public class Tile45Example extends GBase
	{
		public const MAX_SIZE:int = 1000;
		public var mapData:Array;
		public var man:GBase;
		public var game:TileGameLayer;
		public var debugText:TextField;
		
		public function Tile45Example()
		{
			new EnabledSWFScreen(stage);
			
			stage.addChild(new FPS())
			
			debugText = TextFieldParse.createTextField("",new Point(0,20));
			stage.addChild(debugText);
			stage.addEventListener(MouseEvent.MOUSE_MOVE,moveMoveHandler);
			
			mapData = [];
			for (var i:int = 0;i < MAX_SIZE;i++)
			{
				mapData.push([]);
				for (var j:int = 0;j < MAX_SIZE;j++)
					mapData[i].push((Math.random() < 0.5) ? 0 : 1)
			}
			
			game = new TileGameLayer(mapData,new Tile45(TestRepeater45),createTileItemHandler);
			addChild(game);
			game.tileLayer.cursor = CursorSprite.CURSOR_DRAG;
			
			DragManager.register(game.tileLayer,game);
			
			man = new GBase(new TestHuman())
			game.addItem(man);
			man.x = 50;
			man.y = 50;
			man.cursor = CursorSprite.CURSOR_DRAG;
			DragManager.register(man);
			
			man = new GBase(new TestHuman())
			game.addItem(man);
			man.x = 100;
			man.y = 100;
			man.cursor = CursorSprite.CURSOR_DRAG;
			DragManager.register(man);
			
			stage.addChild(new CursorSprite())//加入鼠标
			
			Display45Util.getDefaultTileRect(new TileObj())
		}
		
		protected function createTileItemHandler(d:*):GBase
		{
			return d ? new GBase(new TileObj()) : null;
		}
		
		protected function moveMoveHandler(event:MouseEvent):void
		{
			var v:DisplayObject = event.target as DisplayObject;
			debugText.text = game.tileLayer.getItemPointAtPoint(new Point(game.mouseX,game.mouseY)).toString();
			debugText.appendText("\n目前实例数:"+game.sortEngine.data.length)
		}
		
	}
}