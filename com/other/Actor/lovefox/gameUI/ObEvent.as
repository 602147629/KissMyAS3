package lovefox.gameUI
{
    import flash.events.*;

    public class ObEvent extends Event
    {
        public var value:String;

        public function ObEvent(param1:String)
        {
            super("obEvent", false, false);
            this.value = param1;
            return;
        }// end function

    }
}
