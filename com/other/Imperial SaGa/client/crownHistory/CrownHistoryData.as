package crownHistory
{

    public class CrownHistoryData extends Object
    {
        private var _time:uint;
        private var _amount:int;
        private var _type:int;
        private var _count:int;
        private var _total:int;
        private var _text:String;

        public function CrownHistoryData(param1:Object)
        {
            this._time = param1.epochTime;
            this._amount = param1.amount;
            this._type = param1.type;
            this._count = param1.count;
            this._total = param1.total;
            this._text = param1.text;
            return;
        }// end function

        public function get time() : uint
        {
            return this._time;
        }// end function

        public function get amount() : int
        {
            return this._amount;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function get count() : int
        {
            return this._count;
        }// end function

        public function get total() : int
        {
            return this._total;
        }// end function

        public function get text() : String
        {
            return this._text;
        }// end function

    }
}
