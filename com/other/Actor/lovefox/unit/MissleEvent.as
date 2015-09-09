package lovefox.unit
{
    import flash.events.*;

    public class MissleEvent extends Event
    {
        public var _model:Object;
        public var _speed:Object;
        public var _target:Object;
        public var _pierce:Object = false;
        public var _hue:Object = 0;
        public var _z:Object = 0;

        public function MissleEvent(param1, param2, param3, param4 = false, param5 = 0, param6 = 0)
        {
            super("missleEvent", false, false);
            this._model = param1;
            this._speed = param2;
            this._target = param3;
            this._pierce = param4;
            this._hue = param5;
            this._z = param6;
            return;
        }// end function

    }
}
