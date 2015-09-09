package justFly {
	
	import justFly.event.SystemStateEvent;
	import net.ricogaming.core.base.GameModule;
	
	/**
	 * ...
	 * @author sam
	 */
	public class JustFlyModule extends GameModule {
		
		public function JustFlyModule() {
			context.configure(JustFlyConfig);
		}
		
		override public function init():void {
			super.init();
			this.dispatchEvent(new SystemStateEvent(SystemStateEvent.LOAD_RECORD));
		}
	
	}

}