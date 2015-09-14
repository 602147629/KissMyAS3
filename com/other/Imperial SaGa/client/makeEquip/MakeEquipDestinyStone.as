package makeEquip
{
    import button.*;
    import destinystone.*;
    import flash.display.*;
    import flash.events.*;
    import home.*;
    import item.*;
    import material.*;
    import message.*;
    import resource.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class MakeEquipDestinyStone extends MakeEquipBase
    {
        private const _RECIPES_02_UNLOCK_GRADE:int = 5;
        private const _RECIPES_03_UNLOCK_GRADE:int = 8;
        private const _BUTTON_CREATE:int = 1;
        private const _BUTTON_DECOMPOSITION:int = 2;
        private const _BUTTON_RETURN:int = 3;
        private const _BUTTON_RECIPES_00:int = 4;
        private const _BUTTON_RECIPES_01:int = 5;
        private const _BUTTON_RECIPES_02:int = 6;
        private const _BUTTON_RECIPES_03:int = 7;
        private const _RECIPES_LEVEL_SYOKYU:int = 1;
        private const _RECIPES_LEVEL_CHUKYU:int = 2;
        private const _RECIPES_LEVEL_JYOKYU:int = 3;
        private var Recipes00:EquipButton;
        private var Recipes01:EquipButton;
        private var Recipes02:EquipButton;
        private var Recipes03:ButtonBase;
        private var _aRecipes:Array;
        private var FacilityRank:InstitutionInfo;
        private var _select:int;
        private var _recipesLevel:int;
        private var _isoNaviBalloon:InStayOut;

        public function MakeEquipDestinyStone(param1:DisplayObjectContainer)
        {
            super(param1, "creatMainMc", true);
            this._aRecipes = [];
            this._isoNaviBalloon = new InStayOut(_mc.chrInfoBalloonTopMc);
            TextControl.setIdText(_mc.chrInfoBalloonTopMc.chrInfoBalloonMc.textMc.textDt, MessageId.CRAFT_ROOM_TOP_GUIDE_TEXT01);
            var _loc_2:* = ButtonManager.getInstance().addButton(_mc.returnBtnMc, this.cbButtonBackPush, this._BUTTON_RETURN);
            _loc_2.enterSeId = ButtonBase.SE_CANCEL_ID;
            _aButton.push(_loc_2);
            TextControl.setIdText(_mc.returnBtnMc.textMc.textDt, MessageId.COMMON_BUTTON_RETURN);
            this.Recipes00 = new EquipButton(_mc.creatWindMc.Recipes00, this.cbButtonRecipes00Push, this.cbOverRecipes00Button, this.cbOutRecipes00Button);
            this.Recipes00.enterSeId = ButtonBase.SE_DECIDE_ID;
            ButtonManager.getInstance().addButtonBase(this.Recipes00);
            this._aRecipes.push(this.Recipes00);
            this.Recipes01 = new EquipButton(_mc.creatWindMc.Recipes01, this.cbButtonRecipes01Push, this.cbOverRecipes01Button, this.cbOutRecipes00Button);
            this.Recipes01.enterSeId = ButtonBase.SE_DECIDE_ID;
            ButtonManager.getInstance().addButtonBase(this.Recipes01);
            this._aRecipes.push(this.Recipes01);
            this.Recipes02 = new EquipButton(_mc.creatWindMc.Recipes02, this.cbButtonRecipes02Push, this.cbOverRecipes02Button, this.cbOutRecipes00Button);
            this.Recipes02.enterSeId = ButtonBase.SE_DECIDE_ID;
            ButtonManager.getInstance().addButtonBase(this.Recipes02);
            this._aRecipes.push(this.Recipes02);
            this.Recipes03 = new ButtonBase(_mc.creatWindMc.Recipes03, this.cbButtonRecipes03Push, this.cbOverDecompresionButton, this.cbOutRecipes00Button);
            this.Recipes03.enterSeId = ButtonBase.SE_DECIDE_ID;
            ButtonManager.getInstance().addButtonBase(this.Recipes03);
            TextControl.setIdText(_mc.creatWindMc.Recipes03.TextMc.textDt, MessageId.CRAFT_ROOM_DECOMPOSITION_BUTTON);
            _aButton.push(this.Recipes03);
            this.UpdateRecipesSeals();
            this._isoNaviBalloon.setIn();
            this._select = Constant.UNDECIDED;
            return;
        }// end function

        public function get aRecipes() : Array
        {
            return this._aRecipes;
        }// end function

        public function get resipesLevel() : int
        {
            return this._recipesLevel;
        }// end function

        public function get bSelectCreate() : Boolean
        {
            return this._select == this._BUTTON_CREATE;
        }// end function

        public function get bSelectDecomposition() : Boolean
        {
            return this._select == this._BUTTON_DECOMPOSITION;
        }// end function

        public function get bSelectReturn() : Boolean
        {
            return this._select == this._BUTTON_RETURN;
        }// end function

        public function get bOpened() : Boolean
        {
            return _isoMain.bOpened;
        }// end function

        public function get bClosed() : Boolean
        {
            return _isoMain.bClosed;
        }// end function

        override public function release() : void
        {
            var _loc_1:* = null;
            super.release();
            for each (_loc_1 in this._aRecipes)
            {
                
                ButtonManager.getInstance().removeButton(_loc_1);
            }
            this._aRecipes = [];
            return;
        }// end function

        private function cbButtonBackPush(param1:int) : void
        {
            this.disableSimpleButtons(true);
            this.disableRecepiesButtons(true);
            this._select = this._BUTTON_RETURN;
            this._isoNaviBalloon.setOut();
            close();
            return;
        }// end function

        private function cbButtonRecipes00Push(param1:int) : void
        {
            this.disableSimpleButtons(true);
            this.disableRecepiesButtons(true);
            this._select = this._BUTTON_CREATE;
            this._recipesLevel = this._RECIPES_LEVEL_SYOKYU;
            this._isoNaviBalloon.setOut();
            close();
            return;
        }// end function

        private function cbButtonRecipes01Push(param1:int) : void
        {
            this.disableSimpleButtons(true);
            this.disableRecepiesButtons(true);
            this._select = this._BUTTON_CREATE;
            this._recipesLevel = this._RECIPES_LEVEL_CHUKYU;
            this._isoNaviBalloon.setOut();
            close();
            return;
        }// end function

        private function cbButtonRecipes02Push(param1:int) : void
        {
            this.disableSimpleButtons(true);
            this.disableRecepiesButtons(true);
            this._select = this._BUTTON_CREATE;
            this._recipesLevel = this._RECIPES_LEVEL_JYOKYU;
            this._isoNaviBalloon.setOut();
            close();
            return;
        }// end function

        private function cbButtonRecipes03Push(param1:int) : void
        {
            this._select = this._BUTTON_DECOMPOSITION;
            this._isoNaviBalloon.setOut();
            close();
            return;
        }// end function

        private function cbOverRecipes00Button(param1:int) : void
        {
            var id:* = param1;
            if (this.Recipes00.speciallyDisaled)
            {
                this._isoNaviBalloon.setOut(function () : void
            {
                if (_mc != null)
                {
                    TextControl.setIdText(_mc.chrInfoBalloonTopMc.chrInfoBalloonMc.textMc.textDt, MessageId.CRAFT_ROOM_NOT_ENOUGH_FACILITY);
                    _isoNaviBalloon.setIn();
                }
                return;
            }// end function
            );
            }
            else
            {
                this._isoNaviBalloon.setOut(function () : void
            {
                if (_mc != null)
                {
                    TextControl.setIdText(_mc.chrInfoBalloonTopMc.chrInfoBalloonMc.textMc.textDt, MessageId.CRAFT_ROOM_CREATE_NAVI_GUIDE);
                    _isoNaviBalloon.setIn();
                }
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function cbOverRecipes01Button(param1:int) : void
        {
            var id:* = param1;
            if (this.Recipes01.speciallyDisaled)
            {
                this._isoNaviBalloon.setOut(function () : void
            {
                if (_mc != null)
                {
                    TextControl.setIdText(_mc.chrInfoBalloonTopMc.chrInfoBalloonMc.textMc.textDt, MessageId.CRAFT_ROOM_NOT_ENOUGH_FACILITY);
                    _isoNaviBalloon.setIn();
                }
                return;
            }// end function
            );
            }
            else
            {
                this._isoNaviBalloon.setOut(function () : void
            {
                if (_mc != null)
                {
                    TextControl.setIdText(_mc.chrInfoBalloonTopMc.chrInfoBalloonMc.textMc.textDt, MessageId.CRAFT_ROOM_CREATE_NAVI_GUIDE);
                    _isoNaviBalloon.setIn();
                }
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function cbOverRecipes02Button(param1:int) : void
        {
            var id:* = param1;
            if (this.Recipes02.speciallyDisaled)
            {
                this._isoNaviBalloon.setOut(function () : void
            {
                if (_mc != null)
                {
                    TextControl.setIdText(_mc.chrInfoBalloonTopMc.chrInfoBalloonMc.textMc.textDt, MessageId.CRAFT_ROOM_NOT_ENOUGH_FACILITY);
                    _isoNaviBalloon.setIn();
                }
                return;
            }// end function
            );
            }
            else
            {
                this._isoNaviBalloon.setOut(function () : void
            {
                if (_mc != null)
                {
                    TextControl.setIdText(_mc.chrInfoBalloonTopMc.chrInfoBalloonMc.textMc.textDt, MessageId.CRAFT_ROOM_CREATE_NAVI_GUIDE);
                    _isoNaviBalloon.setIn();
                }
                return;
            }// end function
            );
            }
            return;
        }// end function

        private function cbOutRecipes00Button(param1:int) : void
        {
            var id:* = param1;
            this._isoNaviBalloon.setOut(function () : void
            {
                if (_mc != null)
                {
                    TextControl.setIdText(_mc.chrInfoBalloonTopMc.chrInfoBalloonMc.textMc.textDt, MessageId.CRAFT_ROOM_TOP_GUIDE_TEXT01);
                    _isoNaviBalloon.setIn();
                }
                return;
            }// end function
            );
            return;
        }// end function

        private function cbOverDecompresionButton(param1:int) : void
        {
            var id:* = param1;
            this._isoNaviBalloon.setOut(function () : void
            {
                if (_mc != null)
                {
                    TextControl.setIdText(_mc.chrInfoBalloonTopMc.chrInfoBalloonMc.textMc.textDt, MessageId.CRAFT_ROOM_RESOLUTION_NAVI_GUIDE);
                    _isoNaviBalloon.setIn();
                }
                return;
            }// end function
            );
            return;
        }// end function

        private function OverDisabled(event:Event) : void
        {
            var _loc_2:* = event.target as MovieClip;
            return;
        }// end function

        public function UpdateRecipesSeals() : void
        {
            TextControl.setIdText(_mc.creatWindMc.Recipes00.MaterialText01Mc.textDt, MessageId.CRAFT_ROOM_RECIPES_BUTTON_CLASS_01);
            TextControl.setIdText(_mc.creatWindMc.Recipes00.MaterialText02Mc.textDt, MessageId.CRAFT_ROOM_RECIPES_01_BUTTON);
            TextControl.setIdText(_mc.creatWindMc.Recipes00.MaterialText03Mc.textDt, MessageId.CRAFT_ROOM_RECIPES_BUTTON_CHATTEL);
            TextControl.setIdText(_mc.creatWindMc.Recipes01.MaterialText01Mc.textDt, MessageId.CRAFT_ROOM_RECIPES_BUTTON_CLASS_01);
            TextControl.setIdText(_mc.creatWindMc.Recipes01.MaterialText02Mc.textDt, MessageId.CRAFT_ROOM_RECIPES_02_BUTTON);
            TextControl.setIdText(_mc.creatWindMc.Recipes01.MaterialText03Mc.textDt, MessageId.CRAFT_ROOM_RECIPES_BUTTON_CHATTEL);
            TextControl.setIdText(_mc.creatWindMc.Recipes02.MaterialText01Mc.textDt, MessageId.CRAFT_ROOM_RECIPES_BUTTON_CLASS_01);
            TextControl.setIdText(_mc.creatWindMc.Recipes02.MaterialText02Mc.textDt, MessageId.CRAFT_ROOM_RECIPES_03_BUTTON);
            TextControl.setIdText(_mc.creatWindMc.Recipes02.MaterialText03Mc.textDt, MessageId.CRAFT_ROOM_RECIPES_BUTTON_CHATTEL);
            TextControl.setText(_mc.creatWindMc.Recipes00.LockTextMc.textDt, "仮：施設Grade1から使用可能");
            TextControl.setText(_mc.creatWindMc.Recipes01.LockTextMc.textDt, TextControl.formatIdText(MessageId.CRAFT_ROOM_RECIPES_02_BUTTON_LOCKED, this._RECIPES_02_UNLOCK_GRADE));
            TextControl.setText(_mc.creatWindMc.Recipes02.LockTextMc.textDt, TextControl.formatIdText(MessageId.CRAFT_ROOM_RECIPES_03_BUTTON_LOCKED, this._RECIPES_03_UNLOCK_GRADE));
            var _loc_1:* = UserDataManager.getInstance().userData.getOwnDestinyStoneNum(MaterialId.MT_A_ORE_010);
            TextControl.setText(_mc.creatWindMc.Recipes00.MaterialSet00.NumTextMc.textDt, _loc_1.toString());
            var _loc_2:* = ItemManager.getInstance().getDestinyStoneInformation(MaterialId.MT_A_ORE_010);
            var _loc_3:* = ResourceManager.getInstance().createBitmap(ResourcePath.DESTINY_STONE_PATH + _loc_2.fileName);
            _loc_3.smoothing = true;
            _mc.creatWindMc.Recipes00.MaterialSet00.dsNull.addChild(_loc_3);
            var _loc_4:* = UserDataManager.getInstance().userData.getOwnDestinyStoneNum(MaterialId.MT_B_WOOD_010);
            TextControl.setText(_mc.creatWindMc.Recipes00.MaterialSet01.NumTextMc.textDt, _loc_4.toString());
            var _loc_5:* = ItemManager.getInstance().getDestinyStoneInformation(MaterialId.MT_B_WOOD_010);
            var _loc_6:* = ResourceManager.getInstance().createBitmap(ResourcePath.DESTINY_STONE_PATH + _loc_5.fileName);
            ResourceManager.getInstance().createBitmap(ResourcePath.DESTINY_STONE_PATH + _loc_5.fileName).smoothing = true;
            _mc.creatWindMc.Recipes00.MaterialSet01.dsNull.addChild(_loc_6);
            var _loc_7:* = UserDataManager.getInstance().userData.getOwnDestinyStoneNum(MaterialId.MT_C_FUR_010);
            TextControl.setText(_mc.creatWindMc.Recipes00.MaterialSet02.NumTextMc.textDt, _loc_7.toString());
            var _loc_8:* = ItemManager.getInstance().getDestinyStoneInformation(MaterialId.MT_C_FUR_010);
            var _loc_9:* = ResourceManager.getInstance().createBitmap(ResourcePath.DESTINY_STONE_PATH + _loc_8.fileName);
            ResourceManager.getInstance().createBitmap(ResourcePath.DESTINY_STONE_PATH + _loc_8.fileName).smoothing = true;
            _mc.creatWindMc.Recipes00.MaterialSet02.dsNull.addChild(_loc_9);
            var _loc_10:* = UserDataManager.getInstance().userData.getOwnDestinyStoneNum(MaterialId.MT_A_ORE_020);
            TextControl.setText(_mc.creatWindMc.Recipes01.MaterialSet00.NumTextMc.textDt, _loc_10.toString());
            var _loc_11:* = ItemManager.getInstance().getDestinyStoneInformation(MaterialId.MT_A_ORE_020);
            var _loc_12:* = ResourceManager.getInstance().createBitmap(ResourcePath.DESTINY_STONE_PATH + _loc_11.fileName);
            ResourceManager.getInstance().createBitmap(ResourcePath.DESTINY_STONE_PATH + _loc_11.fileName).smoothing = true;
            _mc.creatWindMc.Recipes01.MaterialSet00.dsNull.addChild(_loc_12);
            var _loc_13:* = UserDataManager.getInstance().userData.getOwnDestinyStoneNum(MaterialId.MT_B_WOOD_020);
            TextControl.setText(_mc.creatWindMc.Recipes01.MaterialSet01.NumTextMc.textDt, _loc_13.toString());
            var _loc_14:* = ItemManager.getInstance().getDestinyStoneInformation(MaterialId.MT_B_WOOD_020);
            var _loc_15:* = ResourceManager.getInstance().createBitmap(ResourcePath.DESTINY_STONE_PATH + _loc_14.fileName);
            ResourceManager.getInstance().createBitmap(ResourcePath.DESTINY_STONE_PATH + _loc_14.fileName).smoothing = true;
            _mc.creatWindMc.Recipes01.MaterialSet01.dsNull.addChild(_loc_15);
            var _loc_16:* = UserDataManager.getInstance().userData.getOwnDestinyStoneNum(MaterialId.MT_C_FUR_020);
            TextControl.setText(_mc.creatWindMc.Recipes01.MaterialSet02.NumTextMc.textDt, _loc_16.toString());
            var _loc_17:* = ItemManager.getInstance().getDestinyStoneInformation(MaterialId.MT_C_FUR_020);
            var _loc_18:* = ResourceManager.getInstance().createBitmap(ResourcePath.DESTINY_STONE_PATH + _loc_17.fileName);
            ResourceManager.getInstance().createBitmap(ResourcePath.DESTINY_STONE_PATH + _loc_17.fileName).smoothing = true;
            _mc.creatWindMc.Recipes01.MaterialSet02.dsNull.addChild(_loc_18);
            var _loc_19:* = UserDataManager.getInstance().userData.getOwnDestinyStoneNum(MaterialId.MT_A_ORE_030);
            TextControl.setText(_mc.creatWindMc.Recipes02.MaterialSet00.NumTextMc.textDt, _loc_19.toString());
            var _loc_20:* = ItemManager.getInstance().getDestinyStoneInformation(MaterialId.MT_A_ORE_030);
            var _loc_21:* = ResourceManager.getInstance().createBitmap(ResourcePath.DESTINY_STONE_PATH + _loc_20.fileName);
            ResourceManager.getInstance().createBitmap(ResourcePath.DESTINY_STONE_PATH + _loc_20.fileName).smoothing = true;
            _mc.creatWindMc.Recipes02.MaterialSet00.dsNull.addChild(_loc_21);
            var _loc_22:* = UserDataManager.getInstance().userData.getOwnDestinyStoneNum(MaterialId.MT_B_WOOD_030);
            TextControl.setText(_mc.creatWindMc.Recipes02.MaterialSet01.NumTextMc.textDt, _loc_22.toString());
            var _loc_23:* = ItemManager.getInstance().getDestinyStoneInformation(MaterialId.MT_B_WOOD_030);
            var _loc_24:* = ResourceManager.getInstance().createBitmap(ResourcePath.DESTINY_STONE_PATH + _loc_23.fileName);
            ResourceManager.getInstance().createBitmap(ResourcePath.DESTINY_STONE_PATH + _loc_23.fileName).smoothing = true;
            _mc.creatWindMc.Recipes02.MaterialSet01.dsNull.addChild(_loc_24);
            var _loc_25:* = UserDataManager.getInstance().userData.getOwnDestinyStoneNum(MaterialId.MT_C_FUR_030);
            TextControl.setText(_mc.creatWindMc.Recipes02.MaterialSet02.NumTextMc.textDt, _loc_25.toString());
            var _loc_26:* = ItemManager.getInstance().getDestinyStoneInformation(MaterialId.MT_C_FUR_030);
            var _loc_27:* = ResourceManager.getInstance().createBitmap(ResourcePath.DESTINY_STONE_PATH + _loc_26.fileName);
            ResourceManager.getInstance().createBitmap(ResourcePath.DESTINY_STONE_PATH + _loc_26.fileName).smoothing = true;
            _mc.creatWindMc.Recipes02.MaterialSet02.dsNull.addChild(_loc_27);
            this.FacilityRank = UserDataManager.getInstance().userData.getInstitutionInfo(CommonConstant.FACILITY_ID_MAKE_EQUIP);
            this.Recipes00.setSpecialDisable(false);
            if (this.FacilityRank.grade < this._RECIPES_02_UNLOCK_GRADE)
            {
                this.Recipes01.setSpecialDisable(true);
            }
            else
            {
                this.Recipes01.setSpecialDisable(false);
            }
            if (this.FacilityRank.grade < this._RECIPES_03_UNLOCK_GRADE)
            {
                this.Recipes02.setSpecialDisable(true);
            }
            else
            {
                this.Recipes02.setSpecialDisable(false);
            }
            return;
        }// end function

        public function updateSealsWithoutData() : void
        {
            if (this.FacilityRank.grade < this._RECIPES_02_UNLOCK_GRADE)
            {
                this.Recipes01.setSpecialDisable(true);
            }
            else
            {
                this.Recipes01.setSpecialDisable(false);
            }
            if (this.FacilityRank.grade < this._RECIPES_03_UNLOCK_GRADE)
            {
                this.Recipes02.setSpecialDisable(true);
            }
            else
            {
                this.Recipes02.setSpecialDisable(false);
            }
            return;
        }// end function

        override protected function cbMainIn() : void
        {
            super.cbMainIn();
            if (TutorialManager.getInstance().isFacilityTutorial(TutorialManager.FACILITY_TUTORIAL_FLAG_MAKE_EQUIP))
            {
                TutorialManager.getInstance().stepChange(0);
            }
            else if (TutorialManager.getInstance().isFacilityUpgradeGuide())
            {
                TutorialManager.getInstance().stepChange(100);
            }
            return;
        }// end function

        private function disableRecepiesButtons(param1:Boolean) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in this.aRecipes)
            {
                
                _loc_2.setDisableFlag(param1);
            }
            return;
        }// end function

        private function disableSimpleButtons(param1:Boolean) : void
        {
            var _loc_2:* = null;
            for each (_loc_2 in _aButton)
            {
                
                _loc_2.setDisable(param1);
            }
            return;
        }// end function

    }
}
