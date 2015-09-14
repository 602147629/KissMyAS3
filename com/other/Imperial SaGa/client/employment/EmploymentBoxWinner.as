package employment
{
    import PlayerCard.*;
    import flash.display.*;
    import player.*;
    import resource.*;
    import utility.*;

    public class EmploymentBoxWinner extends Object
    {
        private var _mc:MovieClip;
        private var _playerDisplay:EmploymentRunnerDisplay;
        private var _smallCard:PlayerSmallCard;
        private var _isoCard:InStayOut;
        private var _hit:EmploymentBoxCardHit;
        private var _mcKira:MovieClip;
        private var _wait:Number;

        public function EmploymentBoxWinner(param1:MovieClip, param2:MovieClip, param3:PlayerInformation, param4:Function, param5:Function)
        {
            this._mc = param1;
            this._playerDisplay = new EmploymentRunnerDisplay(this._mc, param3.id, false);
            if (PlayerManager.getInstance().cmpRaritySuperRare(param3.rarity) < 0)
            {
                this._smallCard = new PlayerSmallCard(param2.cardInOut1Mc.cardNull, param3.id);
                param2.gotoAndStop("cardNormal");
                this._isoCard = new InStayOut(param2.cardInOut1Mc);
                this._mcKira = null;
            }
            else
            {
                this._smallCard = new PlayerSmallCard(param2.cardInOut2Mc.cardNull, param3.id);
                param2.gotoAndStop("cardRare");
                this._isoCard = new InStayOut(param2.cardInOut2Mc);
                this._mcKira = ResourceManager.getInstance().createMovieClip(ResourcePath.GACHA_PATH + "UI_SummonProduction.swf", "kiraAnmSetMc");
                param2.cardInOut2Mc.addChild(this._mcKira);
                param2.cardInOut2Mc.mouseEnabled = false;
            }
            this._hit = new EmploymentBoxCardHit(param2, param4, param5, param3);
            if (this._mcKira)
            {
                this._mcKira.mouseEnabled = false;
                this._mcKira.mouseChildren = false;
            }
            this._mc.mouseEnabled = false;
            this._mc.mouseChildren = false;
            param2.mouseEnabled = false;
            this._wait = 0;
            this.hide();
            return;
        }// end function

        public function isOpened() : Boolean
        {
            return this._isoCard.bOpened;
        }// end function

        public function release() : void
        {
            if (this._playerDisplay)
            {
                this._playerDisplay.release();
            }
            this._playerDisplay = null;
            if (this._smallCard)
            {
                this._smallCard.release();
            }
            this._smallCard = null;
            if (this._isoCard)
            {
                this._isoCard.release();
            }
            this._isoCard = null;
            if (this._mcKira && this._mcKira.parent)
            {
                this._mcKira.parent.removeChild(this._mcKira);
            }
            this._mcKira = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var t:* = param1;
            if (this._wait > 0)
            {
                this._wait = this._wait - t;
                if (this._wait <= 0)
                {
                    this._playerDisplay.setAnimationWithCallback(PlayerDisplay.LABEL_STATUS_UP, function () : void
            {
                _isoCard.setIn();
                return;
            }// end function
            );
                    this._wait = 0;
                }
            }
            return;
        }// end function

        public function setAnimation(param1:String) : void
        {
            if (this._playerDisplay)
            {
                this._playerDisplay.setAnimation(param1);
            }
            return;
        }// end function

        public function delayOpen(param1:Number) : void
        {
            this._wait = param1;
            return;
        }// end function

        public function close() : void
        {
            this._isoCard.setOut();
            return;
        }// end function

        public function show() : void
        {
            this._mc.visible = true;
            return;
        }// end function

        public function hide() : void
        {
            this._mc.visible = false;
            return;
        }// end function

    }
}
