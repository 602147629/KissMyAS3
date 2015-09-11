package haxe.io
{
    import flash.*;
    import flash.utils.*;

    public class Bytes extends Object
    {
        public var length:int;
        public var b:ByteArray;

        public function Bytes(param1:int = 0, param2:ByteArray = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            length = param1;
            b = param2;
            param2.endian = Endian.LITTLE_ENDIAN;
            return;
        }// end function

        public static function alloc(param1:int) : Bytes
        {
            var _loc_2:* = new ByteArray();
            _loc_2.length = param1;
            return new Bytes(param1, _loc_2);
        }// end function

    }
}
