package magicLaboratory
{

    public class MagicLearningData extends Object
    {
        private var _uniqueId:uint;
        private var _skillId:uint;
        private var _endTime:uint;
        private var _noticeId:uint;
        private var _bFastFinish:Boolean;
        private var _bFinish:Boolean;

        public function MagicLearningData()
        {
            this.resetData();
            return;
        }// end function

        public function get uniqueId() : uint
        {
            return this._uniqueId;
        }// end function

        public function set uniqueId(param1:uint) : void
        {
            this._uniqueId = param1;
            return;
        }// end function

        public function get skillId() : uint
        {
            return this._skillId;
        }// end function

        public function set skillId(param1:uint) : void
        {
            this._skillId = param1;
            return;
        }// end function

        public function get endTime() : uint
        {
            return this._endTime;
        }// end function

        public function set endTime(param1:uint) : void
        {
            this._endTime = param1;
            return;
        }// end function

        public function get noticeId() : uint
        {
            return this._noticeId;
        }// end function

        public function set noticeId(param1:uint) : void
        {
            this._noticeId = param1;
            return;
        }// end function

        public function get bFastFinish() : Boolean
        {
            return this._bFastFinish;
        }// end function

        public function alertFastFinish() : void
        {
            this._bFastFinish = true;
            return;
        }// end function

        public function checkFastFinish() : void
        {
            this._bFastFinish = false;
            return;
        }// end function

        public function get bFinish() : Boolean
        {
            return this._bFinish;
        }// end function

        public function alertFinish() : void
        {
            this._bFinish = true;
            return;
        }// end function

        public function setObject(param1:Object) : void
        {
            this._uniqueId = param1.uniqueId;
            this._skillId = param1.skillId;
            this._endTime = param1.endTime;
            this._noticeId = param1.noticeId;
            return;
        }// end function

        public function resetData() : void
        {
            this._uniqueId = Constant.EMPTY_ID;
            this._endTime = 0;
            this._skillId = 0;
            this._noticeId = 0;
            this._bFastFinish = false;
            this._bFinish = false;
            return;
        }// end function

    }
}
