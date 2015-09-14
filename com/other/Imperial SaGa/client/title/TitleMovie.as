package title
{
    import flash.display.*;
    import flash.events.*;
    import input.*;
    import resource.*;

    public class TitleMovie extends Object
    {
        private const _PHASE_STAY:int = 0;
        private const _PHASE_MOVIE_LOAD:int = 10;
        private const _PHASE_MOVIE_PLAY:int = 11;
        private const _PHASE_MOVIE_END:int = 12;
        private var _parent:DisplayObjectContainer;
        private var _fileName:String;
        private var _cbMovieStart:Function;
        private var _cbMovieEnd:Function;
        private var _phase:int;
        private var _bSetBinaryRequest:Boolean;
        private var _bSetBinary:Boolean;
        private var _movie:MovieClip;
        private var _filter:Sprite;
        private var _bPlayMovie:Boolean;
        private var _playTime:Number;
        private var _throttleState:String = "resume";
        private var _throttleStartTime:Number = 99999;
        private var _throttleFrame:Number = 9999;

        public function TitleMovie(param1:DisplayObjectContainer, param2:String, param3:Function, param4:Function)
        {
            this._parent = param1;
            this._fileName = param2;
            this._cbMovieStart = param3;
            this._cbMovieEnd = param4;
            this._phase = this._PHASE_STAY;
            this._bSetBinaryRequest = false;
            this._bSetBinary = false;
            this._movie = null;
            this._bPlayMovie = false;
            this._playTime = 0;
            return;
        }// end function

        public function get bPlayMovie() : Boolean
        {
            return this._bPlayMovie;
        }// end function

        public function get playTime() : Number
        {
            return this._playTime;
        }// end function

        public function release() : void
        {
            this.deleteMovie();
            if (this._bSetBinary)
            {
                ResourceManager.getInstance().removeMovie(ResourcePath.MOVIE_OPED_PATH + this._fileName);
                this._bSetBinary = false;
            }
            this._cbMovieEnd = null;
            this._cbMovieStart = null;
            this._parent = null;
            return;
        }// end function

        public function playMovie() : void
        {
            this.setPhase(this._PHASE_MOVIE_LOAD);
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._phase != this._PHASE_STAY)
            {
                this._playTime = this._playTime + param1;
            }
            switch(this._phase)
            {
                case this._PHASE_MOVIE_LOAD:
                {
                    this.controlMovieLoad();
                    break;
                }
                case this._PHASE_MOVIE_PLAY:
                {
                    this.controlMoviePlay();
                    break;
                }
                case this._PHASE_MOVIE_END:
                {
                    this.controlMovieEnd();
                    break;
                }
                default:
                {
                    break;
                    break;
                }
            }
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            if (this._phase != param1)
            {
                this._phase = param1;
                switch(this._phase)
                {
                    case this._PHASE_MOVIE_LOAD:
                    {
                        this.phaseMovieLoad();
                        break;
                    }
                    case this._PHASE_MOVIE_PLAY:
                    {
                        this.phaseMoviePlay();
                        break;
                    }
                    case this._PHASE_MOVIE_END:
                    {
                        this.phaseMovieEnd();
                        break;
                    }
                    default:
                    {
                        break;
                        break;
                    }
                }
            }
            return;
        }// end function

        private function phaseMovieLoad() : void
        {
            if (this._cbMovieStart != null)
            {
                this._cbMovieStart();
            }
            this._bPlayMovie = true;
            if (this._bSetBinaryRequest == false)
            {
                this._bSetBinaryRequest = true;
                ResourceManager.getInstance().loadMovieData(ResourcePath.MOVIE_OPED_PATH + this._fileName, this.cbLoadComplete);
            }
            else if (this._bSetBinary)
            {
                this.setPhase(this._PHASE_MOVIE_PLAY);
            }
            return;
        }// end function

        private function controlMovieLoad() : void
        {
            return;
        }// end function

        private function phaseMoviePlay() : void
        {
            this.deleteMovie();
            this.createMovie();
            return;
        }// end function

        private function controlMoviePlay() : void
        {
            var _loc_2:* = NaN;
            var _loc_3:* = 0;
            var _loc_1:* = Main.GetApplicationData().throttleState;
            if (_loc_1 != this._throttleState)
            {
                this._throttleState = _loc_1;
                if (_loc_1 == ThrottleType.RESUME)
                {
                    _loc_2 = this._playTime - this._throttleStartTime;
                    _loc_3 = this._throttleFrame + _loc_2 * Constant.FPS;
                    this._movie.gotoAndPlay(_loc_3);
                }
                this._throttleStartTime = this._playTime;
                this._throttleFrame = this._movie.currentFrame;
            }
            if (this._movie.currentFrame >= (this._movie.totalFrames - 1))
            {
                this.setPhase(this._PHASE_MOVIE_END);
            }
            return;
        }// end function

        private function phaseMovieEnd() : void
        {
            this.deleteMovie();
            return;
        }// end function

        private function controlMovieEnd() : void
        {
            this.setPhase(this._PHASE_STAY);
            if (this._cbMovieEnd != null)
            {
                this._cbMovieEnd();
            }
            return;
        }// end function

        private function createMovie() : void
        {
            var _loc_1:* = null;
            if (this._filter == null)
            {
                this._filter = new Sprite();
                _loc_1 = this._filter.graphics;
                _loc_1.lineStyle(0, 0, 1);
                _loc_1.beginFill(0, 1);
                _loc_1.drawRect(0, 0, Constant.SCREEN_WIDTH, Constant.SCREEN_HEIGHT);
                this._parent.addChild(this._filter);
            }
            if (this._movie == null)
            {
                this._movie = ResourceManager.getInstance().getMovie(ResourcePath.MOVIE_OPED_PATH + this._fileName);
                this._movie.gotoAndPlay(0);
                this._parent.addChild(this._movie);
                InputManager.getInstance().addMouseCallback(this._movie, null, this.cbMovieClick);
            }
            return;
        }// end function

        private function deleteMovie() : void
        {
            if (this._movie)
            {
                InputManager.getInstance().delMouseCallback(this._movie);
                this._movie.gotoAndStop(this._movie.totalFrames);
                if (this._movie.parent)
                {
                    this._movie.parent.removeChild(this._movie);
                }
                this._movie = null;
            }
            if (this._filter && this._filter.parent)
            {
                this._filter.parent.removeChild(this._filter);
            }
            this._filter = null;
            return;
        }// end function

        private function cbLoadComplete() : void
        {
            this._bSetBinary = true;
            if (this._phase == this._PHASE_MOVIE_LOAD)
            {
                this.setPhase(this._PHASE_MOVIE_PLAY);
            }
            return;
        }// end function

        private function cbMovieClick(event:MouseEvent) : void
        {
            this.setPhase(this._PHASE_MOVIE_END);
            return;
        }// end function

    }
}
