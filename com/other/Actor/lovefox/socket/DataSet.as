package lovefox.socket
{
    import flash.utils.*;

    public class DataSet extends Object
    {
        public var _head:uint;
        public var _body:ByteArray;

        public function DataSet()
        {
            this._body = new ByteArray();
            this._body.endian = Endian.LITTLE_ENDIAN;
            return;
        }// end function

        public function addHead(param1) : void
        {
            this._head = param1;
            return;
        }// end function

        public function add8(param1:uint) : void
        {
            this._body.writeByte(param1);
            return;
        }// end function

        public function add16(param1:uint) : void
        {
            this._body.writeShort(param1);
            return;
        }// end function

        public function add32(param1:uint) : void
        {
            this._body.writeUnsignedInt(param1);
            return;
        }// end function

        public function addFloat(param1:Number) : void
        {
            this._body.writeFloat(param1);
            return;
        }// end function

        public function addUTF(param1:String) : void
        {
            var _loc_2:* = new ByteArray();
            _loc_2.writeUTFBytes(param1);
            this._body.writeShort(_loc_2.length);
            this._body.writeUTFBytes(param1);
            _loc_2 = null;
            return;
        }// end function

        public function output() : ByteArray
        {
            var _loc_1:* = new ByteArray();
            _loc_1.endian = Endian.BIG_ENDIAN;
            _loc_1.writeShort(this._body.length + 2);
            _loc_1.endian = Endian.LITTLE_ENDIAN;
            _loc_1.writeShort(this._head);
            _loc_1.writeBytes(this._body);
            this._body.clear();
            return _loc_1;
        }// end function

    }
}
