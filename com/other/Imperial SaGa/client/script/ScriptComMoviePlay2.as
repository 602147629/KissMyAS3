package script
{
    import flash.display.*;
    import utility.*;

    public class ScriptComMoviePlay2 extends ScriptComBase
    {
        private const _PHASE_PLAY_START:int = 1;
        private const _PHASE_FADE_START_IN:int = 2;
        private const _PHASE_PLAY:int = 3;
        private const _PHASE_FADE_END_OUT:int = 4;
        private const _FADE_IN_TIME:Number = 0.2;
        private const _FADE_OUT_TIME:Number = 0.2;
        private const _FADE_FRAME:int = 5;
        private var _name:String;
        private var _phase:int;
        private var _frameBef:int;
        private var _bPlayCalled:Boolean;

        public function ScriptComMoviePlay2()
        {
            super(ScriptComConstant.COMMAND_CATEGORY_DISP);
            this._frameBef = Constant.UNDECIDED;
            this._bPlayCalled = false;
            return;
        }// end function

        override public function setXml(param1:XML) : void
        {
            super.setXml(param1);
            this._name = param1.name;
            return;
        }// end function

        override public function commandInit() : void
        {
            super.commandInit();
            this.setPhase(this._PHASE_PLAY_START);
            return;
        }// end function

        override public function commandSkip() : int
        {
            var _loc_1:* = ScriptManager.getInstance().getMovie(this._name);
            if (_loc_1.mc == null)
            {
                this.movPlay();
                return ScriptComConstant.COMMAND_SKIP_RESULT_WAIT;
            }
            _loc_1.mc.gotoAndPlay(_loc_1.mc.totalFrames);
            _loc_1.playEnd();
            var _loc_2:* = ScriptManager.getInstance().getFade();
            _loc_2.setParamFadeOut(0, 0);
            _bCommandEnd = true;
            return ScriptComConstant.COMMAND_SKIP_RESULT_FINISH;
        }// end function

        override public function isCommandSkipEnable() : Boolean
        {
            return true;
        }// end function

        override public function commandControl(param1:Number) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            _loc_3 = ScriptManager.getInstance().getMovie(this._name);
            switch(this._phase)
            {
                case this._PHASE_PLAY_START:
                {
                    if (_loc_3.bPlay)
                    {
                        this.setPhase(this._PHASE_FADE_START_IN);
                    }
                    break;
                }
                case this._PHASE_FADE_START_IN:
                {
                    this.setPhase(this._PHASE_PLAY);
                    break;
                }
                case this._PHASE_PLAY:
                {
                    _loc_4 = _loc_3.mc;
                    _loc_5 = _loc_4.currentFrame;
                    if (this._frameBef != _loc_5)
                    {
                        if (_loc_5 == _loc_4.totalFrames - this._FADE_FRAME)
                        {
                            _loc_2 = ScriptManager.getInstance().getFade();
                            _loc_2.setParamFadeOut(this._FADE_OUT_TIME, 0);
                        }
                    }
                    if (_loc_3.bPlayEnd)
                    {
                        this.setPhase(this._PHASE_FADE_END_OUT);
                    }
                    this._frameBef = _loc_5;
                    break;
                }
                case this._PHASE_FADE_END_OUT:
                {
                    _loc_2 = ScriptManager.getInstance().getFade();
                    if (_loc_2.bFadeEnd)
                    {
                        _loc_3.playEnd();
                        _bCommandEnd = true;
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            var _loc_2:* = null;
            this._phase = param1;
            switch(this._phase)
            {
                case this._PHASE_PLAY_START:
                {
                    this.movPlay();
                    break;
                }
                case this._PHASE_FADE_START_IN:
                {
                    _loc_2 = ScriptManager.getInstance().getFade();
                    _loc_2.setParamFadeIn(this._FADE_IN_TIME, 0);
                    break;
                }
                case this._PHASE_PLAY:
                {
                    break;
                }
                case this._PHASE_FADE_END_OUT:
                {
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function movPlay() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (this._bPlayCalled == false)
            {
                _loc_1 = ScriptManager.getInstance().getMovie(this._name);
                if (_loc_1 == null)
                {
                    Assert.print("ムービー【" + this._name + "】が作成されていません");
                }
                _loc_2 = ScriptManager.getInstance().getMovieLayer();
                if (_loc_2 == null)
                {
                    Assert.print("表示スプライトが有りません");
                }
                _loc_1.play(_loc_2);
                this._bPlayCalled = true;
            }
            return;
        }// end function

    }
}
