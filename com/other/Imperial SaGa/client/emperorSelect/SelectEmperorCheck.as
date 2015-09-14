package emperorSelect
{
    import button.*;
    import flash.display.*;
    import flash.geom.*;
    import icon.*;
    import layer.*;
    import message.*;
    import player.*;
    import resource.*;
    import status.*;
    import user.*;
    import utility.*;

    public class SelectEmperorCheck extends Object
    {
        private var _bmBustUp:Bitmap;
        private var _layer:LayerEmperorSelect;
        private var _isoMainMc:InStayOut;
        private var _baseMc:MovieClip;
        private var _selectPersonal:PlayerPersonal;
        private var _simpleStatus:PlayerSimpleStatus;
        private var _detilStatus:PlayerDetailStatus;
        private var _aButton:Array;
        private var _aItemData:Array;
        private var _cbYes:Function;
        private var _cbNo:Function;
        private var _cbStatusClose:Function;
        private static const BUTTON_TYPE_YES:int = 1;
        private static const BUTTON_TYPE_NO:int = 2;
        private static const BUTTON_TYPE_INFOMATION:int = 3;
        private static const BLACK_OUT:Number = 0.4;
        private static const LIGHT_ON:Number = 1;

        public function SelectEmperorCheck(param1:LayerEmperorSelect, param2:PlayerPersonal, param3:Array, param4:Function, param5:Function, param6:Function)
        {
            var layer:* = param1;
            var personal:* = param2;
            var aItem:* = param3;
            var cbFunctionYes:* = param4;
            var cbFunctionNo:* = param5;
            var cbStatusClose:* = param6;
            this._layer = layer;
            this._selectPersonal = personal;
            this._cbYes = cbFunctionYes;
            this._cbNo = cbFunctionNo;
            this._cbStatusClose = cbStatusClose;
            this._baseMc = ResourceManager.getInstance().createMovieClip(ResourcePath.EMPEROR_SELECT_PATH + "UI_EmperorSelect.swf", "SuccessorConfirmPopupMc");
            this._isoMainMc = new InStayOut(this._baseMc);
            this._layer.getLayer(LayerEmperorSelect.CHECK).addChild(this._baseMc);
            this._simpleStatus = new PlayerSimpleStatus(this._baseMc.selectCharaMc.BalloonAmbitNull, PlayerSimpleStatus.LABEL_MAIN);
            this._aButton = [];
            this._aItemData = aItem;
            var btn:* = ButtonManager.getInstance().addButton(this._baseMc.yesBtnMc, this.cbYesButtonClick);
            btn.setId(BUTTON_TYPE_YES);
            btn.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._aButton.push(btn);
            btn = ButtonManager.getInstance().addButton(this._baseMc.noBtnMc, this.cbNoButtonClick);
            btn.setId(BUTTON_TYPE_NO);
            btn.enterSeId = ButtonBase.SE_CANCEL_ID;
            this._aButton.push(btn);
            TextControl.setIdText(this._baseMc.yesBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_DECIDE);
            TextControl.setIdText(this._baseMc.noBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_NO);
            this.setButtonDisable(true);
            this.setSimpleEmperor();
            TextControl.setIdText(this._baseMc.InfoTextSet.text1Mc.textDt, MessageId.EMPEROR_SELECT_CHECK01);
            if (UserDataManager.getInstance().userData.chapter == 4)
            {
                TextControl.setText(this._baseMc.InfoTextSet.text2Mc.textDt, "");
            }
            else
            {
                TextControl.setIdText(this._baseMc.InfoTextSet.text2Mc.textDt, MessageId.EMPEROR_SELECT_CHECK02);
            }
            this._isoMainMc.setIn(function () : void
            {
                setButtonDisable(false);
                return;
            }// end function
            );
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aButton)
            {
                
                ButtonManager.getInstance().removeButton(_loc_1);
            }
            this._aButton = [];
            if (this._detilStatus)
            {
                this._detilStatus.release();
            }
            this._detilStatus = null;
            if (this._simpleStatus)
            {
                this._simpleStatus.release();
            }
            this._simpleStatus = null;
            if (this._isoMainMc)
            {
                this._isoMainMc.release();
            }
            this._isoMainMc = null;
            if (this._baseMc && this._baseMc.parent != null)
            {
                this._baseMc.parent.removeChild(this._baseMc);
            }
            this._baseMc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            if (this._detilStatus)
            {
                this._detilStatus.control(param1);
            }
            return;
        }// end function

        public function get displayPlayerUniqueId() : int
        {
            if (this._selectPersonal != null)
            {
                return this._selectPersonal.uniqueId;
            }
            return Constant.UNDECIDED;
        }// end function

        public function updateStatus(param1:PlayerPersonal) : void
        {
            this._selectPersonal = param1;
            this.setSimpleEmperor();
            return;
        }// end function

        private function setSimpleEmperor() : void
        {
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_1:* = this._baseMc.selectCharaMc;
            var _loc_2:* = PlayerManager.getInstance().getPlayerInformation(this._selectPersonal.playerId);
            this._bmBustUp = ResourceManager.getInstance().createBitmap(ResourcePath.PLAYER_BUSTUP_PATH + _loc_2.bustUpFileName);
            this._bmBustUp.smoothing = true;
            this._bmBustUp.x = this._bmBustUp.x - this._bmBustUp.width / 2;
            this._bmBustUp.y = this._bmBustUp.y - this._bmBustUp.height;
            _loc_1.bigCharacterNull.addChild(this._bmBustUp);
            TextControl.setText(_loc_1.charaNameMc.textDt, _loc_2.name);
            var _loc_3:* = new PlayerRarityIcon(_loc_1.charaRankMc, _loc_2.rarity);
            if (BuildSwitch.SW_EMPEROR_SKILL)
            {
                _loc_6 = PlayerManager.getInstance().getEmperorSkill(_loc_2.characterId);
                _loc_7 = PlayerManager.getInstance().getEmperorSkillEffectsBonus(this._selectPersonal, _loc_2, _loc_6);
                TextControl.setText(_loc_1.LeaderSkill.skilltextMc.textDt, PlayerManager.getInstance().getEmperorSkillEffectsText(_loc_2, _loc_7, _loc_6));
            }
            else
            {
                TextControl.setText(_loc_1.LeaderSkill.skilltextMc.textDt, "");
                _loc_1.LeaderSkill.visible = false;
            }
            if (this._selectPersonal.uniqueId < 0)
            {
                TextControl.setIdText(_loc_1.spotEntryMc.textDt, MessageId.EMPEROR_SELECT_FREE_RARE);
                _loc_1.spotEntryMc.visible = true;
            }
            else
            {
                _loc_1.spotEntryMc.visible = false;
            }
            var _loc_4:* = new WeaponTypeIcon(_loc_1.weaponTypeMc, _loc_2.weaponType);
            var _loc_5:* = new MagicTypeIcon(_loc_1.attributeTypeSetMc, _loc_2.magicType);
            this._simpleStatus.setStatus(this._selectPersonal);
            return;
        }// end function

        private function setButtonDisable(param1:Boolean) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this._aButton)
            {
                
                _loc_2.setDisableFlag(param1);
            }
            return;
        }// end function

        private function setColorTransform(param1:Number) : void
        {
            this._baseMc.transform.colorTransform = new ColorTransform(param1, param1, param1);
            return;
        }// end function

        private function cbYesButtonClick(param1:int) : void
        {
            this.setButtonDisable(true);
            this._isoMainMc.setOut(this._cbYes);
            return;
        }// end function

        private function cbNoButtonClick(param1:int) : void
        {
            this.setButtonDisable(true);
            this._isoMainMc.setOut(this._cbNo);
            return;
        }// end function

        private function cbSelectEmperorDetail(param1:int) : void
        {
            this.setButtonDisable(true);
            StatusManager.getInstance().addStatusDetail(PlayerDetailStatus.STATUS_TYPE_EQUIPMENT, this._layer.getLayer(LayerEmperorSelect.STATUS), this.cbCloseDetailStatus, this._selectPersonal, this._aItemData);
            return;
        }// end function

        private function cbCloseDetailStatus(param1:int, param2:Boolean) : void
        {
            if (StatusManager.getInstance().aDetailLength == 0)
            {
                this.setButtonDisable(false);
            }
            if (param2)
            {
                if (this._cbStatusClose != null)
                {
                    this._cbStatusClose(param1);
                }
            }
            return;
        }// end function

    }
}
