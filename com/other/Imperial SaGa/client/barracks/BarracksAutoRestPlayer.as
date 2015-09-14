package barracks
{
    import player.*;

    public class BarracksAutoRestPlayer extends Object
    {
        private var _personal:PlayerPersonal;
        private var _index:int;

        public function BarracksAutoRestPlayer(param1:PlayerPersonal, param2:BarracksData)
        {
            this._personal = param1;
            this._index = param2.index;
            return;
        }// end function

        public function get personal() : PlayerPersonal
        {
            return this._personal;
        }// end function

        public function get uniqueId() : int
        {
            return this._personal ? (this._personal.uniqueId) : (Constant.EMPTY_ID);
        }// end function

        public function get index() : int
        {
            return this._index;
        }// end function

        public function release() : void
        {
            this._personal = null;
            return;
        }// end function

        public function getRestoreSec(param1:uint) : uint
        {
            return this._personal.getRestoreWaitTime(param1);
        }// end function

    }
}
