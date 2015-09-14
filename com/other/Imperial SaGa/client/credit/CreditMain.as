package credit
{
    import flash.display.*;
    import resource.*;
    import sound.*;

    public class CreditMain extends Object
    {
        private const _MOVIE_FILE_NAME:String = "credit.swf";
        private const _PHASE_OPEN:int = 1;
        private const _PHASE_MOVIE:int = 10;
        private const _PHASE_CLOSE:int = 99;
        private var _parent:DisplayObjectContainer;
        private var _baseMc:MovieClip;
        private var _creditMovie:CreditMovie;
        private var _phase:int;
        private var _bClose:Boolean;

        public function CreditMain(param1:DisplayObjectContainer)
        {
            this._bClose = false;
            this._parent = param1;
            this._baseMc = ResourceManager.getInstance().createMovieClip(ResourcePath.MOVIE_PATH + "UI_Movie.swf", "UImovie");
            SoundManager.getInstance().stopBgm();
            Main.GetProcess().topBar.close();
            this.setPhase(this._PHASE_OPEN);
            return;
        }// end function

        public function get bClose() : Boolean
        {
            return this._bClose;
        }// end function

        public function release() : void
        {
            if (this._creditMovie)
            {
                this._creditMovie.release();
                this._creditMovie = null;
            }
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case this._PHASE_OPEN:
                {
                    this.controlOpen();
                    break;
                }
                case this._PHASE_MOVIE:
                {
                    this.controlMovie(param1);
                    break;
                }
                case this._PHASE_CLOSE:
                {
                    this.controlClose();
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
            if (param1 != this._phase)
            {
                this._phase = param1;
                switch(this._phase)
                {
                    case this._PHASE_OPEN:
                    {
                        this.phaseOpen();
                        break;
                    }
                    case this._PHASE_MOVIE:
                    {
                        this.phaseMovie();
                        break;
                    }
                    case this._PHASE_CLOSE:
                    {
                        this.phaseClose();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        private function phaseOpen() : void
        {
            this._baseMc.visible = true;
            return;
        }// end function

        private function controlOpen() : void
        {
            this.setPhase(this._PHASE_MOVIE);
            return;
        }// end function

        private function phaseMovie() : void
        {
            if (this._creditMovie == null)
            {
                this._creditMovie = new CreditMovie(this._parent, this._baseMc, this._MOVIE_FILE_NAME);
            }
            return;
        }// end function

        private function controlMovie(param1:Number) : void
        {
            if (this._creditMovie)
            {
                this._creditMovie.control(param1);
                if (this._creditMovie.bEnd)
                {
                    this._creditMovie.release();
                    this._creditMovie = null;
                    this.setPhase(this._PHASE_CLOSE);
                }
            }
            return;
        }// end function

        private function phaseClose() : void
        {
            this._bClose = true;
            this._baseMc.visible = false;
            Main.GetProcess().topBar.open();
            if (this._creditMovie)
            {
                this._creditMovie.release();
                this._creditMovie = null;
            }
            return;
        }// end function

        private function controlClose() : void
        {
            return;
        }// end function

        public static function getResource() : Array
        {
            return [ResourcePath.MOVIE_PATH + "UI_Movie.swf"];
        }// end function

    }
}
