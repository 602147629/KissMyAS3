package lovefox.unit
{
    import flash.events.*;

    public class UnitEvent extends Event
    {
        public var param:Object;
        public var value:Object;

        public function UnitEvent(param1:String, param2 = null, param3 = null)
        {
            super(param1, false, false);
            this.param = param2;
            this.value = param3;
            return;
        }// end function

    }
}
