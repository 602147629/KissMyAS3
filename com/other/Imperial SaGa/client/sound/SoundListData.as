package sound
{

    public class SoundListData extends Object
    {
        private var _id:int;
        private var _fileName:String;
        private var _startPosition:Number;
        private var _voluem:Number;
        private var _loopPosition:Number;
        private var _bLoop:Boolean;
        private var _parallelLimit:int;

        public function SoundListData()
        {
            this._id = 0;
            this._fileName = "";
            this._voluem = 0;
            this._startPosition = 0;
            this._loopPosition = 0;
            this._bLoop = false;
            this._parallelLimit = 0;
            return;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function get fileName() : String
        {
            return this._fileName;
        }// end function

        public function get startPosition() : Number
        {
            return this._startPosition;
        }// end function

        public function get voluem() : Number
        {
            return this._voluem;
        }// end function

        public function get loopPosition() : Number
        {
            return this._loopPosition;
        }// end function

        public function get bLoop() : Boolean
        {
            return this._bLoop;
        }// end function

        public function get parallelLimit() : int
        {
            return this._parallelLimit;
        }// end function

        public function setXml(param1:XML) : void
        {
            this._id = int(param1.id);
            this._fileName = String(param1.fileName);
            this._voluem = Number(param1.volume);
            this._startPosition = Number(param1.loopStart);
            this._loopPosition = Number(param1.loopEnd);
            this._parallelLimit = Number(param1.parallelLimit);
            if (this._startPosition != 0 || this._loopPosition != 0)
            {
                this._bLoop = true;
            }
            return;
        }// end function

    }
}
