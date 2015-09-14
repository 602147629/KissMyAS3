package quest
{

    public class QuestFlag extends Object
    {
        private var _id:int;
        private var _bCear:Boolean;
        private var _bState:Boolean;

        public function QuestFlag(param1:int)
        {
            this._id = param1;
            this._bState = false;
            this._bCear = false;
            return;
        }// end function

        public function setReceive(param1:Object) : void
        {
            this._id = param1.id;
            this._bCear = param1.bClear;
            return;
        }// end function

        public function setState(param1:Boolean) : void
        {
            this._bState = param1;
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function get bClear() : Boolean
        {
            return this._bCear;
        }// end function

        public function get bState() : Boolean
        {
            return this._bState;
        }// end function

    }
}
