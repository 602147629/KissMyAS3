package background
{
    import flash.display.*;
    import flash.geom.*;
    import utility.*;

    public class BackGround extends Object
    {
        private var _isoMain:InStayOut;
        private var _mc:MovieClip;

        public function BackGround(param1:MovieClip)
        {
            this._mc = param1;
            this._isoMain = new InStayOut(this._mc);
            return;
        }// end function

        public function release() : void
        {
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
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

        public function open() : void
        {
            if (this._isoMain.bClosed)
            {
                this._isoMain.setIn();
            }
            return;
        }// end function

        public function setColorTransform(param1:ColorTransform) : void
        {
            if (this._mc != null)
            {
                this._mc.transform.colorTransform = param1;
            }
            return;
        }// end function

    }
}
