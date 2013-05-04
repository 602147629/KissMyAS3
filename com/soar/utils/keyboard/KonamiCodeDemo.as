package{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	public class KonamiCodeDemo extends  Sprite{
		private var konamiCode:Array;

		public function KonamiCodeDemo(){
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(e:Event):void{
			removeEventListener(Event.ADDED_TO_STAGE,  onAddedToStage);
			// create an array to hold the input  history;
			konamiCode = new Array();
			// set  the array length to 10, since we are comparing it against a code of 10  key presses
			konamiCode.length = 10;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, checkKonamiCode)
		}

		private function  checkKonamiCode(e:KeyboardEvent):void{
			// Do  a little array work to make comparison easy.
			konamiCode.shift(); // remove first item in array;
			konamiCode.push(e.keyCode);    // add latest key press to end of  keypress history
			// Some trace comments to let you see  what is happening
			trace("___________________________________________");
			trace("User Input:", konamiCode);
			trace("Comared To:",  [Keyboard.UP, Keyboard.UP, Keyboard.DOWN, Keyboard.DOWN, Keyboard.LEFT,  Keyboard.RIGHT, Keyboard.LEFT, Keyboard.RIGHT, 66, 65]);
			trace("Is a match:", konamiCode.toString() == [Keyboard.UP,  Keyboard.UP, Keyboard.DOWN, Keyboard.DOWN, Keyboard.LEFT,  Keyboard.RIGHT, Keyboard.LEFT, Keyboard.RIGHT, 66, 65].toString());
			trace("___________________________________________");
			
			if (konamiCode.toString() == [Keyboard.UP, Keyboard.UP,  Keyboard.DOWN, Keyboard.DOWN, Keyboard.LEFT, Keyboard.RIGHT,  Keyboard.LEFT, Keyboard.RIGHT, 66, 65].toString()) {
				// Add you magical Konami Code Madness here.
				trace("Konami Entered!!!");
				trace("Now Enjoy  some ASCII art");
				trace("######################~~..'|.##############.|`..~~#######################\r##############~./`.~~./'  ./ ################ \. `\. ~~.`\.~##############\r############~.'  `.`-'   /   ~#############~ .  \   `-'.'   `.~############\r##########~.'    |     |  .'\ ~##########~ /`.  |      |     `.~##########\r########~.'      |     |  |`.`._ ~####~ _.'.'|   |     |       `.~########\r######~.'        `.    |   `..`._|\.--./|_.'..'  |    .'         `.~######\r####~.'            \   |  #.`.`._`.'--`.'_.'.'.# |   /             `.~####\r##~.'       ......   \  | ###.`~'(o\||/o)`~'.### |  /  ......        `.~##\r~.`.......'~       `. \  \~####  |\_  _/|  ####~/  / .'       ~`........'.~\r;.'                 \ .----.__.'`(n||n)'`.__.----.  /                  `; \r`.                  .'    .'   `. \`'/ .'    `.    `.                  .' \r#:               ..':      :    '. ~~  .`    :      :`..               :# \r#:             .'   :     .'      .'  `.     `.     :   `.             :# \r#:           .'    .`    .'       . || .       `.   '.    `.           :# \r#:         .'    .'  :       ....'      `....       : `.    `.         :# \r#:       .'    .'  ) )        (      )     (      (    )`.    `.       :# \r#:     ..'     .  ( ((   )  ) )) (  ((  (  ))  )  ))  ((  `.   `..     :# \r#:   ..'      .'# ) ) ) (( ( ( (  ) ) ) ))( ( (( ( (  ) ) #`.     `..  :#  \r#;.'        .'##|((  ( ) ) ) ) )( (  (( ( ) )) ) ) )( (||##`.        `.:# \r#`.        .'###|\__  )( (( ( ( )  )  )) )  (  (( (  )_)/|###`.       .'# \r##.`        '#####\__~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~__/#####`       '.##                                   \r ###        #######   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  #######       ### ");
			}
		}
	}
}
