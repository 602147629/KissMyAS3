package battle
{
    import flash.display.*;
    import flash.geom.*;
    import utility.*;

    public class BattleBg extends Object
    {
        private const _DARK_OUT:Number = 0.5;
        private const _DARK_OUT_TIME:Number = 0.5;
        private var _parent:DisplayObjectContainer;
        private var _mc:MovieClip;
        private var _isoMain:InStayOut;
        private var _isoBg:InStayOut;
        private var _bDarkOut:Boolean;
        private var _darkOutColor:Number;

        public function BattleBg(param1:DisplayObjectContainer, param2:MovieClip)
        {
            this._parent = param1;
            this._mc = param2;
            this._parent.addChild(this._mc);
            this._isoMain = new InStayOut(this._mc, true);
            this._isoBg = new InStayOut(this._mc.bgMc, true);
            this._bDarkOut = false;
            this._darkOutColor = 1;
            return;
        }// end function

        public function get bTurnStart() : Boolean
        {
            return this._isoMain.bOpened;
        }// end function

        public function get bInputWait() : Boolean
        {
            return this._isoMain.bClosed;
        }// end function

        public function set bDarkOut(param1:Boolean) : void
        {
            this._bDarkOut = param1;
            return;
        }// end function

        public function release() : void
        {
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._isoBg)
            {
                this._isoBg.release();
            }
            this._isoBg = null;
            if (this._mc)
            {
                if (this._mc.parent)
                {
                    this._mc.parent.removeChild(this._mc);
                }
            }
            this._mc = null;
            this._parent = null;
            return;
        }// end function

        public function setTurnStart() : void
        {
            this._isoMain.setIn();
            this._isoBg.setIn();
            return;
        }// end function

        public function setInputWait() : void
        {
            this._isoMain.setOut();
            this._isoBg.setOut();
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._bDarkOut)
            {
                if (this._darkOutColor > this._DARK_OUT)
                {
                    this._darkOutColor = this._darkOutColor - this._DARK_OUT * (param1 / this._DARK_OUT_TIME);
                    if (this._darkOutColor < this._DARK_OUT)
                    {
                        this._darkOutColor = this._DARK_OUT;
                    }
                    this.setBgColorTransform(this._darkOutColor);
                }
            }
            else if (this._darkOutColor < 1)
            {
                this._darkOutColor = this._darkOutColor + 1 * (param1 / this._DARK_OUT_TIME);
                if (this._darkOutColor > 1)
                {
                    this._darkOutColor = 1;
                }
                this.setBgColorTransform(this._darkOutColor);
            }
            return;
        }// end function

        private function setBgColorTransform(param1:Number) : void
        {
            this._mc.bgMc.transform.colorTransform = new ColorTransform(param1, param1, param1);
            return;
        }// end function

    }
}
