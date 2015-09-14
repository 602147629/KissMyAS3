package employment
{
    import flash.display.*;
    import flash.geom.*;
    import player.*;
    import sound.*;

    public class EmploymentBoxRunner extends Object
    {
        private var _index:int;
        private var _mc:MovieClip;
        private var _playerDisplay:EmploymentRunnerDisplay;
        private var _jumper:EmploymentRunnerDisplay;
        private var _bStarted:Boolean;

        public function EmploymentBoxRunner(param1:MovieClip, param2:int)
        {
            this._mc = param1;
            this._index = param2;
            this._playerDisplay = null;
            this._jumper = null;
            this._bStarted = false;
            this.hide();
            return;
        }// end function

        public function get index() : int
        {
            return this._index;
        }// end function

        public function get mc() : MovieClip
        {
            return this._mc;
        }// end function

        public function get playerDisplay() : EmploymentRunnerDisplay
        {
            return this._playerDisplay;
        }// end function

        public function get playerId() : int
        {
            return this._playerDisplay ? (this._playerDisplay.info.id) : (Constant.EMPTY_ID);
        }// end function

        public function get bEnable() : Boolean
        {
            return this._playerDisplay != null;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._jumper)
            {
                this._jumper.control(param1);
            }
            if (this._bStarted && PlayerManager.getInstance().cmpRaritySuperRare(this._playerDisplay.info.rarity) < 0 && this._playerDisplay.iconRarity.mc.alpha > 0)
            {
                this._playerDisplay.iconRarity.mc.alpha = this._playerDisplay.iconRarity.mc.alpha - param1 * 5;
                if (this._playerDisplay.iconRarity.mc.alpha < 0)
                {
                    this._playerDisplay.iconRarity.mc.alpha = 0;
                }
            }
            return;
        }// end function

        public function setPlayerId(param1:int) : void
        {
            if (this._playerDisplay == null)
            {
                this._playerDisplay = new EmploymentRunnerDisplay(this._mc, param1);
            }
            else
            {
                this._playerDisplay.setId(param1, Constant.EMPTY_ID);
            }
            this._playerDisplay.setAnimation(PlayerDisplay.LABEL_SIDE_STOP);
            var _loc_2:* = PlayerManager.getInstance().getPlayerInformation(this._playerDisplay.info.id);
            this._playerDisplay.iconRarity.setRarity(_loc_2.rarity);
            this._playerDisplay.iconRarity.mc.alpha = 1;
            return;
        }// end function

        public function setJumper(param1:MovieClip, param2:Point) : void
        {
            this.releaseJumper();
            this._jumper = new EmploymentRunnerDisplay(param1, this._playerDisplay.info.id);
            this._jumper.pos = param2;
            this._jumper.setTargetJump(new Point(this._mc.x, this._mc.y));
            var _loc_3:* = PlayerManager.getInstance().getPlayerInformation(this._playerDisplay.info.id);
            this._jumper.iconRarity.setRarity(_loc_3.rarity);
            return;
        }// end function

        public function setAnimation(param1:String) : void
        {
            if (param1 == "spin")
            {
                SoundManager.getInstance().playSe(SoundId.SE_REV_TRAIN_SPIN);
            }
            if (!this._mc.visible)
            {
                this.show();
                this.releaseJumper();
                this._bStarted = false;
            }
            this._playerDisplay.setAnimation(param1);
            return;
        }// end function

        public function checkStarted(param1:MovieClip) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (this._bStarted == false && this._mc.visible)
            {
                _loc_2 = param1.localToGlobal(new Point());
                _loc_3 = this._mc.localToGlobal(new Point());
                _loc_2.x = _loc_2.x + (_loc_2.y - _loc_3.y);
                if (_loc_3.x < _loc_2.x)
                {
                    this._bStarted = true;
                }
            }
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

        public function releaseRunner() : void
        {
            if (this._playerDisplay)
            {
                this._playerDisplay.release();
            }
            this._playerDisplay = null;
            this.releaseJumper();
            this.hide();
            return;
        }// end function

        private function releaseJumper() : void
        {
            if (this._jumper)
            {
                this._jumper.release();
            }
            this._jumper = null;
            return;
        }// end function

    }
}
