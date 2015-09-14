package script
{
    import flash.display.*;
    import resource.*;

    public class ScriptParamMovie extends ScriptParamBase
    {
        private var _parent:DisplayObjectContainer;
        private var _bg:Sprite;
        private var _name:String;
        private var _fileName:String;
        private var _mc:MovieClip;
        private var _bPlayEnd:Boolean;
        private var _bPlay:Boolean;

        public function ScriptParamMovie()
        {
            this._name = "";
            this._fileName = "";
            this._bg = null;
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function get mc() : MovieClip
        {
            return this._mc;
        }// end function

        public function get bPlayEnd() : Boolean
        {
            return this._bPlayEnd;
        }// end function

        public function get bPlay() : Boolean
        {
            return this._bPlay;
        }// end function

        override public function release() : void
        {
            this.removeParent();
            this._mc = null;
            this._parent = null;
            this._bPlay = false;
            this._bPlayEnd = false;
            ResourceManager.getInstance().removeResource(ResourcePath.MOVIE_EVENT_PATH + this._fileName);
            return;
        }// end function

        private function removeParent() : void
        {
            if (this._mc)
            {
                if (this._mc.parent)
                {
                    this._mc.parent.removeChild(this._mc);
                }
            }
            this._mc = null;
            if (this._bg != null)
            {
                if (this._bg.parent)
                {
                    this._bg.parent.removeChild(this._bg);
                }
            }
            this._bg = null;
            return;
        }// end function

        public function setParam(param1:String, param2:String) : void
        {
            this._name = param1;
            this._fileName = param2;
            ResourceManager.getInstance().loadResourceMovie(ResourcePath.MOVIE_EVENT_PATH + this._fileName);
            return;
        }// end function

        private function cbLoadComplete() : void
        {
            this._bg = new Sprite();
            var _loc_1:* = this._bg.graphics;
            _loc_1.beginFill(0);
            _loc_1.drawRect(0, 0, Constant.SCREEN_WIDTH, Constant.SCREEN_HEIGHT);
            this._mc = ResourceManager.getInstance().getMovie(ResourcePath.MOVIE_EVENT_PATH + this._fileName);
            this._parent.addChild(this._bg);
            this._parent.addChild(this._mc);
            this._bPlay = true;
            return;
        }// end function

        public function play(param1:DisplayObjectContainer) : void
        {
            ResourceManager.getInstance().loadMovieData(ResourcePath.MOVIE_EVENT_PATH + this._fileName, this.cbLoadComplete);
            this._parent = param1;
            return;
        }// end function

        public function playEnd() : void
        {
            this._mc.stop();
            ResourceManager.getInstance().removeMovie(ResourcePath.MOVIE_EVENT_PATH + this._fileName);
            this.removeParent();
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._mc != null)
            {
                if (this._mc.currentFrame >= this._mc.totalFrames)
                {
                    this._bPlay = false;
                    this._bPlayEnd = true;
                }
            }
            return;
        }// end function

    }
}
