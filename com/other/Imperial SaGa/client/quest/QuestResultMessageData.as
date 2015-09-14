package quest
{

    public class QuestResultMessageData extends Object
    {
        private var _type:int;
        private var _aMessage:Array;

        public function QuestResultMessageData()
        {
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function setParameter(param1:XML) : void
        {
            this._type = param1.type;
            this._aMessage = [];
            var _loc_2:* = param1.failure;
            var _loc_3:* = param1.success;
            var _loc_4:* = param1.gSuccess;
            this._aMessage.push(_loc_2);
            this._aMessage.push(_loc_3);
            this._aMessage.push(_loc_4);
            return;
        }// end function

        public function getResultMessage(param1:int) : String
        {
            return this._aMessage[(param1 - 1)];
        }// end function

    }
}
