package employment
{
    import flash.display.*;
    import flash.geom.*;
    import message.*;
    import resource.*;
    import tutorial.*;
    import utility.*;

    public class EmploymentNaviCharacter extends Object
    {
        private var _mcBase:MovieClip;
        private var _isoMain:InStayOut;
        private var _isoBalloon:InStayOut;

        public function EmploymentNaviCharacter(param1:DisplayObjectContainer)
        {
            this._mcBase = ResourceManager.getInstance().createMovieClip(ResourcePath.GACHA_PATH + "UI_SummonMenu.swf", "popupNaviCharaMc");
            param1.addChild(this._mcBase);
            this._isoMain = new InStayOut(this._mcBase);
            this._isoBalloon = new InStayOut(this._mcBase.popupNaviCharaBGMc.charaBalloonMc);
            var _loc_2:* = ResourceManager.getInstance().createBitmap(ResourcePath.NAVI_CHARACTER_PATH);
            var _loc_3:* = new Shape();
            var _loc_4:* = _loc_3.graphics;
            var _loc_5:* = new Matrix();
            new Matrix().identity();
            _loc_5.scale(-1, 1);
            _loc_5.translate(-_loc_2.width / 2, 0);
            _loc_4.beginBitmapFill(_loc_2.bitmapData, _loc_5);
            _loc_4.drawRect(-_loc_2.width / 2, -_loc_2.height, _loc_2.width, _loc_2.height);
            _loc_4.endFill();
            (this._mcBase.popupNaviCharaBGMc.naviCharaNull as MovieClip).addChild(_loc_3);
            this.setText(MessageManager.getInstance().getMessage(MessageId.EMPLOYMENT_NAVI_MESSAGE));
            return;
        }// end function

        public function get bClose() : Boolean
        {
            return this._isoMain && this._isoMain.bClosed;
        }// end function

        public function get bAnimetion() : Boolean
        {
            return this._isoMain && this._isoMain.bAnimetion;
        }// end function

        public function release() : void
        {
            if (this._isoBalloon)
            {
                this._isoBalloon.release();
            }
            this._isoBalloon = null;
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            return;
        }// end function

        public function open(param1:Function = null) : void
        {
            if (TutorialManager.getInstance().isTutorial())
            {
                if (param1 != null)
                {
                    this.param1();
                }
            }
            else
            {
                this._isoMain.setIn(param1);
            }
            return;
        }// end function

        public function close(param1:Function = null) : void
        {
            if (TutorialManager.getInstance().isTutorial())
            {
                if (param1 != null)
                {
                    this.param1();
                }
            }
            else
            {
                this._isoMain.setOut(param1);
            }
            return;
        }// end function

        public function setText(param1:String) : void
        {
            TextControl.setText(this._mcBase.popupNaviCharaBGMc.charaBalloonMc.balloonMc.infoBalloonTextMc.textDt, param1);
            return;
        }// end function

        public function openBalloon(param1:Function = null) : void
        {
            if (this._isoBalloon)
            {
                this._isoBalloon.setIn(param1);
            }
            return;
        }// end function

        public function closeBalloon(param1:Function = null) : void
        {
            if (this._isoBalloon)
            {
                this._isoBalloon.setOut(param1);
            }
            return;
        }// end function

    }
}
