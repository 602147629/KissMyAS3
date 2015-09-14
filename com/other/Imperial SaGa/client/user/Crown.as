package user
{

    public class Crown extends Object
    {
        private var _free:int;
        private var _paid:int;

        public function Crown()
        {
            this._free = 0;
            this._paid = 0;
            return;
        }// end function

        public function get free() : int
        {
            return this._free;
        }// end function

        public function get paid() : int
        {
            return this._paid;
        }// end function

        public function get total() : int
        {
            return this._free + this._paid;
        }// end function

        public function setCrown(param1:int, param2:int) : void
        {
            this._free = param1;
            this._paid = param2;
            return;
        }// end function

        public function setCrownData(param1:Object) : void
        {
            this._free = param1.free;
            this._paid = param1.paid;
            return;
        }// end function

    }
}
