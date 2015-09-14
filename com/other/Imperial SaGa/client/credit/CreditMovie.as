package credit
{
    import flash.display.*;
    import movie.*;
    import resource.*;
    import sound.*;

    public class CreditMovie extends Object
    {
        private const _PHASE_RESOURCE_LOAD:int = 1;
        private const _PHASE_MOVIE_LOAD:int = 2;
        private const _PHASE_OPEN:int = 3;
        private const _PHASE_WAIT:int = 10;
        private const _PHASE_PAUSE:int = 11;
        private const _PHASE_CLOSE:int = 99;
        private var _parent:DisplayObjectContainer;
        private var _baseMc:MovieClip;
        private var _movie:MovieClip;
        private var _fileName:String;
        private var _bgmId:int;
        private var _phase:int;
        private var _movieUi:CommonMovieUi;
        private var _bEnd:Boolean;

        public function CreditMovie(param1:DisplayObjectContainer, param2:MovieClip, param3:String)
        {
            this._baseMc = param2;
            this._parent = param1;
            this._fileName = param3;
            this._bgmId = SoundId.BGM_DEM_ENDING_CREDIT;
            this._bEnd = false;
            this.setPhase(this._PHASE_RESOURCE_LOAD);
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._bEnd;
        }// end function

        public function release() : void
        {
            if (this._movieUi)
            {
                this._movieUi.release();
            }
            this._movieUi = null;
            ResourceManager.getInstance().removeMovie(ResourcePath.MOVIE_CREDIT_PATH + this._fileName);
            ResourceManager.getInstance().removeResource(ResourcePath.MOVIE_CREDIT_PATH + this._fileName);
            this._movie = null;
            this._baseMc = null;
            this._parent = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case this._PHASE_RESOURCE_LOAD:
                {
                    this.controlResourceLoad();
                    break;
                }
                case this._PHASE_MOVIE_LOAD:
                {
                    this.controlMovieLoad();
                    break;
                }
                case this._PHASE_OPEN:
                {
                    this.controlOpen();
                    break;
                }
                case this._PHASE_WAIT:
                {
                    this.controlWait(param1);
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
                    case this._PHASE_RESOURCE_LOAD:
                    {
                        this.phaseResourceLoad();
                        break;
                    }
                    case this._PHASE_MOVIE_LOAD:
                    {
                        this.phaseMovieLoad();
                        break;
                    }
                    case this._PHASE_OPEN:
                    {
                        this.phaseOpen();
                        break;
                    }
                    case this._PHASE_WAIT:
                    {
                        this.phaseWait();
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

        private function phaseResourceLoad() : void
        {
            this._bEnd = false;
            ResourceManager.getInstance().loadResourceMovie(ResourcePath.MOVIE_CREDIT_PATH + this._fileName);
            SoundManager.getInstance().loadSound(this._bgmId);
            return;
        }// end function

        private function controlResourceLoad() : void
        {
            if (ResourceManager.getInstance().isLoaded() && SoundManager.getInstance().isLoaded())
            {
                this.setPhase(this._PHASE_MOVIE_LOAD);
            }
            return;
        }// end function

        private function phaseMovieLoad() : void
        {
            ResourceManager.getInstance().loadMovieData(ResourcePath.MOVIE_CREDIT_PATH + this._fileName, this.cbLoadComplete);
            return;
        }// end function

        private function controlMovieLoad() : void
        {
            return;
        }// end function

        private function cbLoadComplete() : void
        {
            this._movie = ResourceManager.getInstance().getMovie(ResourcePath.MOVIE_CREDIT_PATH + this._fileName);
            this.setPhase(this._PHASE_OPEN);
            return;
        }// end function

        private function phaseOpen() : void
        {
            this._baseMc.visible = true;
            SoundManager.getInstance().playBgm(this._bgmId);
            return;
        }// end function

        private function controlOpen() : void
        {
            if (SoundManager.getInstance().isBgmFade())
            {
                this.setPhase(this._PHASE_WAIT);
            }
            return;
        }// end function

        private function phaseWait() : void
        {
            this._movie.play();
            if (Main.GetProcess().fade.isFade())
            {
                Main.GetProcess().fade.setFadeIn(0);
            }
            if (this._movieUi == null)
            {
                this._movieUi = new CommonMovieUi(this._parent, this._baseMc, this._movie, true);
            }
            return;
        }// end function

        private function controlWait(param1:Number) : void
        {
            this._movieUi.control(param1);
            if (this._movie.currentFrame >= this._movie.totalFrames)
            {
                this.setPhase(this._PHASE_CLOSE);
            }
            return;
        }// end function

        private function phaseClose() : void
        {
            this._bEnd = true;
            if (this._movieUi)
            {
                this._movieUi.release();
            }
            this._movieUi = null;
            return;
        }// end function

        private function controlClose() : void
        {
            return;
        }// end function

    }
}
