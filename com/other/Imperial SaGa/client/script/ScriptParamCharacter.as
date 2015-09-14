package script
{
    import character.*;
    import flash.display.*;
    import flash.geom.*;
    import player.*;
    import resource.*;
    import user.*;

    public class ScriptParamCharacter extends ScriptParamBase
    {
        private var _DARKOUT_COLOR_OFFSET:int = -100;
        private var _name:String;
        private var _fileName:String;
        private var _mc:MovieClip;
        private var _bDarkout:Boolean;
        private var _bChangeColor:Boolean;
        private var _offsetColor:Number;
        private var _alpha:Number;

        public function ScriptParamCharacter()
        {
            this._offsetColor = 0;
            this._alpha = 1;
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

        public function set bDarkout(param1:Boolean) : void
        {
            this._bDarkout = param1;
            this._bChangeColor = true;
            return;
        }// end function

        public function get alpha() : Number
        {
            return this._alpha;
        }// end function

        public function set alpha(param1:Number) : void
        {
            this._alpha = param1;
            return;
        }// end function

        override public function release() : void
        {
            ResourceManager.getInstance().removeResource(ResourcePath.EVENT_PATH + "Chr/" + this._fileName);
            if (this._mc)
            {
                if (this._mc.parent)
                {
                    this._mc.parent.removeChild(this._mc);
                }
            }
            this._mc = null;
            return;
        }// end function

        public function setParam(param1:String, param2:String) : void
        {
            this._name = param1;
            this._fileName = param2;
            if (this._name.indexOf(ScriptConstant.SCRIPT_COMMAND_NOW_EMPEROR) >= 0)
            {
                ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_BUSTUP_PATH + CharacterConstant.ID_BUSTUP + this._fileName, this.cbLoadComplete);
                ResourceManager.getInstance().loadResource(ResourcePath.EVENT_PATH + "Chr/" + "chr_emperor.swf", this.cbLoadComplete);
            }
            else
            {
                ResourceManager.getInstance().loadResource(ResourcePath.EVENT_PATH + "Chr/" + this._fileName, this.cbLoadComplete);
            }
            return;
        }// end function

        private function cbLoadComplete() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (this._name.indexOf(ScriptConstant.SCRIPT_COMMAND_NOW_EMPEROR) >= 0)
            {
                this._mc = ResourceManager.getInstance().createMovieClip(ResourcePath.EVENT_PATH + "Chr/" + "chr_emperor.swf", "EventChr");
                _loc_1 = ResourceManager.getInstance().createBitmap(ResourcePath.PLAYER_BUSTUP_PATH + CharacterConstant.ID_BUSTUP + this._fileName);
                _loc_1.smoothing = true;
                if (this._mc == null || _loc_1 == null)
                {
                    this._mc = null;
                    return;
                }
                _loc_1.x = (-_loc_1.width) / 2;
                _loc_1.y = -_loc_1.height;
                _loc_2 = UserDataManager.getInstance().userData.getEmperorPlayerPersonal();
                if (_loc_2 && _loc_2.playerId == PlayerId.ID_Jean_CL02_SR)
                {
                    _loc_1.y = _loc_1.y + 40;
                }
                this._mc.emperorNull.addChild(_loc_1);
            }
            else
            {
                this._mc = ResourceManager.getInstance().createMovieClip(ResourcePath.EVENT_PATH + "Chr/" + this._fileName, "EventChr");
            }
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_2:* = null;
            if (this._mc == null)
            {
                return;
            }
            if (this._bChangeColor)
            {
                if (this._bDarkout)
                {
                    this._offsetColor = this._offsetColor - 500 * param1;
                    if (this._offsetColor <= this._DARKOUT_COLOR_OFFSET)
                    {
                        this._offsetColor = this._DARKOUT_COLOR_OFFSET;
                        this._bChangeColor = false;
                    }
                }
                else
                {
                    this._offsetColor = this._offsetColor + 500 * param1;
                    if (this._offsetColor >= 0)
                    {
                        this._offsetColor = 0;
                        this._bChangeColor = false;
                    }
                }
                _loc_2 = new ColorTransform();
                _loc_2.redOffset = this._offsetColor;
                _loc_2.greenOffset = this._offsetColor;
                _loc_2.blueOffset = this._offsetColor;
                this._mc.transform.colorTransform = _loc_2;
            }
            if (this._mc.alpha != this._alpha)
            {
                this._mc.alpha = this._alpha;
            }
            return;
        }// end function

        public function setVisible(param1:Boolean) : void
        {
            this._mc.visible = param1;
            return;
        }// end function

    }
}
