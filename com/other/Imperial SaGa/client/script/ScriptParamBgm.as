package script
{
    import sound.*;

    public class ScriptParamBgm extends ScriptParamBase
    {
        private var _bgmId:int;

        public function ScriptParamBgm()
        {
            this._bgmId = Constant.UNDECIDED;
            return;
        }// end function

        public function get bgmId() : int
        {
            return this._bgmId;
        }// end function

        override public function release() : void
        {
            super.release();
            return;
        }// end function

        public function setParam(param1:int) : void
        {
            this._bgmId = param1;
            SoundManager.getInstance().loadSound(param1);
            return;
        }// end function

        public function play() : void
        {
            SoundManager.getInstance().playBgm(this._bgmId);
            return;
        }// end function

    }
}
