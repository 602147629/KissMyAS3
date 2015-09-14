package formationSettings
{
    import flash.display.*;
    import flash.geom.*;
    import layer.*;
    import message.*;
    import player.*;
    import utility.*;

    public class FormationCommanderSelecter extends Object
    {
        private var _mcBase:MovieClip;
        private var _layer:LayerFormationSettings;
        private var _bCommanderEnable:Boolean;
        private var _bCommanderChange:Boolean;

        public function FormationCommanderSelecter(param1:MovieClip, param2:Boolean)
        {
            this._mcBase = param1;
            this._layer = new LayerFormationSettings();
            this._mcBase.charaNull.addChildAt(this._layer, 0);
            this._bCommanderEnable = CommanderSkillUtility.isUnlockCommander();
            this._bCommanderChange = param2;
            TextControl.setIdText(this._mcBase.titleMc.textDt, MessageId.COMMON_COMMANDER_SKILL);
            TextControl.setIdText(this._mcBase.conditionsTextMc.textDt, MessageId.FORMATION_COMMANDER_SORTIE_TERM);
            this.setWarningEnable(false);
            this.setCommander(null, 0);
            this._mcBase.visible = this._bCommanderEnable;
            return;
        }// end function

        public function get mc() : MovieClip
        {
            return this._mcBase;
        }// end function

        public function get layer() : LayerFormationSettings
        {
            return this._layer;
        }// end function

        public function get bCommanderEnable() : Boolean
        {
            return this._bCommanderEnable;
        }// end function

        public function get bCommanderChange() : Boolean
        {
            return this._bCommanderChange;
        }// end function

        public function release() : void
        {
            if (this._layer)
            {
                this._layer.release();
            }
            this._layer = null;
            this._mcBase = null;
            return;
        }// end function

        public function getCommanderPosition() : Point
        {
            var _loc_1:* = new Point(this._mcBase.charaNull.x, this._mcBase.charaNull.y);
            return this._mcBase.localToGlobal(_loc_1);
        }// end function

        public function setCommander(param1:PlayerPersonal, param2:int) : void
        {
            var _loc_3:* = param1 ? (PlayerManager.getInstance().getPlayerInformation(param1.playerId)) : (null);
            CommanderSkillUtility.setupCommanderSkillField(this._mcBase.infoTextMc, this._mcBase.warningTextMc, _loc_3, param2, null, false);
            return;
        }// end function

        public function isHit(param1:Point) : Boolean
        {
            var _loc_2:* = null;
            if (this._bCommanderEnable)
            {
                _loc_2 = this._mcBase.charaNull;
                if (_loc_2.getChildAt(0).hitTestPoint(param1.x, param1.y))
                {
                    return HitTest.isObstructHitTest(_loc_2.getChildAt(0), param1.x, param1.y);
                }
            }
            return false;
        }// end function

        public function setWarningText(param1:String) : void
        {
            TextControl.setText(this._mcBase.conditionsTextMc.textDt, param1);
            return;
        }// end function

        public function setWarningEnable(param1:Boolean) : void
        {
            this._mcBase.conditionsTextMc.visible = param1;
            return;
        }// end function

    }
}
