package title
{

    public class TitleTimer extends Object
    {
        private var _titleEndTime:Number;
        private var _cbTitleEndTime:Function;
        private var _bCheckTitleEndTime:Boolean;
        private var _playMovieTime:Number;
        private var _cbPlayMovieTime:Function;
        private var _bCheckMovieTime:Boolean;
        private var _playBgmEndTime:Number;
        private var _cbBgmEnd:Function;
        private var _bCheckBgmTime:Boolean;
        private var _playTime:Number;

        public function TitleTimer(param1:Number, param2:Number, param3:Number, param4:Function, param5:Function, param6:Function)
        {
            this._titleEndTime = param1;
            this._playMovieTime = param2;
            this._playBgmEndTime = param3;
            this._cbTitleEndTime = param4;
            this._cbPlayMovieTime = param5;
            this._cbBgmEnd = param6;
            this._bCheckTitleEndTime = false;
            this._bCheckMovieTime = false;
            this._bCheckBgmTime = false;
            this._playTime = 0;
            return;
        }// end function

        public function get playTime() : Number
        {
            return this._playTime;
        }// end function

        public function release() : void
        {
            this._titleEndTime = 0;
            this._playMovieTime = 0;
            this._playBgmEndTime = 0;
            this._cbTitleEndTime = null;
            this._cbPlayMovieTime = null;
            this._cbBgmEnd = null;
            this._bCheckTitleEndTime = false;
            this._bCheckMovieTime = false;
            this._bCheckBgmTime = false;
            this._playTime = 0;
            return;
        }// end function

        public function startCheck() : void
        {
            this._playTime = 0;
            this._bCheckTitleEndTime = true;
            this._bCheckMovieTime = true;
            this._bCheckBgmTime = true;
            return;
        }// end function

        public function stopCheck() : void
        {
            this._bCheckTitleEndTime = false;
            this._bCheckMovieTime = false;
            this._bCheckBgmTime = false;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._bCheckTitleEndTime || this._bCheckMovieTime || this._bCheckBgmTime)
            {
                this._playTime = this._playTime + param1;
            }
            if (this._bCheckTitleEndTime && this._playTime >= this._titleEndTime)
            {
                this._bCheckTitleEndTime = false;
                if (this._cbTitleEndTime != null)
                {
                    this._cbTitleEndTime();
                }
            }
            if (this._bCheckMovieTime && this._playTime >= this._playMovieTime)
            {
                this._bCheckMovieTime = false;
                if (this._cbPlayMovieTime != null)
                {
                    this._cbPlayMovieTime();
                }
            }
            if (this._bCheckBgmTime && this._playTime >= this._playBgmEndTime)
            {
                this._bCheckBgmTime = false;
                if (this._cbBgmEnd != null)
                {
                    this._cbBgmEnd();
                }
            }
            return;
        }// end function

    }
}
