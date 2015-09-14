package employment
{
    import flash.display.*;
    import message.*;
    import resource.*;
    import utility.*;

    public class EmploymentTitleHeader extends Object
    {
        private var _mcBase:MovieClip;
        private var _isoMain:InStayOut;
        private var _isoSubHeader:InStayOut;

        public function EmploymentTitleHeader(param1:DisplayObjectContainer)
        {
            this._mcBase = ResourceManager.getInstance().createMovieClip(ResourcePath.GACHA_PATH + "UI_SummonMenu.swf", "summonTitleMc");
            param1.addChild(this._mcBase);
            this._isoMain = new InStayOut(this._mcBase);
            this._isoSubHeader = new InStayOut(this._mcBase.gachaTitleMc);
            return;
        }// end function

        public function get bClose() : Boolean
        {
            return this._isoMain && this._isoMain.bClosed && (this._isoSubHeader && this._isoSubHeader.bClosed);
        }// end function

        public function get bAnimetion() : Boolean
        {
            return this._isoMain && this._isoMain.bAnimetion && (this._isoSubHeader && this._isoSubHeader.bAnimetion);
        }// end function

        public function release() : void
        {
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._isoSubHeader)
            {
                this._isoSubHeader.release();
            }
            this._isoSubHeader = null;
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            return;
        }// end function

        public function open() : void
        {
            this._isoMain.setIn();
            return;
        }// end function

        public function close() : void
        {
            this._isoMain.setOut();
            this._isoSubHeader.setOut();
            return;
        }// end function

        public function subOpen() : void
        {
            if (this._isoSubHeader.bClosed)
            {
                this._isoSubHeader.setIn();
            }
            return;
        }// end function

        public function subClose() : void
        {
            if (this._isoSubHeader.bOpened)
            {
                this._isoSubHeader.setOut();
            }
            return;
        }// end function

        public function setSubTitle(param1:String) : void
        {
            TextControl.setText(this._mcBase.gachaTitleMc.textMc.textDt, param1);
            return;
        }// end function

    }
}
