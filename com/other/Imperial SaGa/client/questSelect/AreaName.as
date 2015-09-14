package questSelect
{
    import flash.display.*;
    import message.*;
    import utility.*;

    public class AreaName extends Object
    {
        private var _mc:MovieClip;
        private var _isoMain:InStayOut;

        public function AreaName(param1:MovieClip)
        {
            this._mc = param1;
            this._isoMain = new InStayOut(this._mc);
            return;
        }// end function

        public function isOpen() : Boolean
        {
            return this._isoMain.bOpened;
        }// end function

        public function release() : void
        {
            this._isoMain.release();
            this._isoMain = null;
            if (this._mc.parent)
            {
                this._mc.parent.removeChild(this._mc);
            }
            this._mc = null;
            return;
        }// end function

        public function setIn(param1:String) : void
        {
            TextControl.setText(this._mc.TitleMc.textMc.textDt, param1);
            this._isoMain.setIn();
            return;
        }// end function

        public function setOut() : void
        {
            this._isoMain.setOut();
            return;
        }// end function

    }
}
