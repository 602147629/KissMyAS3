package lovefox.gameUI
{
    import flash.events.*;

    public class GeneralEvent extends Event
    {
        public var param:Object;
        public var value:Object;

        public function GeneralEvent(param1:String, param2 = null, param3 = null)
        {
            super(param1, false, false);
            this.param = param2;
            this.value = param3;
            return;
        }// end function

    }
}
