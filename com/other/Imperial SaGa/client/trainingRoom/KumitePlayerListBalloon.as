package trainingRoom
{
    import flash.display.*;
    import flash.geom.*;
    import icon.*;
    import message.*;
    import player.*;
    import resource.*;
    import user.*;
    import utility.*;

    public class KumitePlayerListBalloon extends Object
    {
        private var _mcBase:MovieClip;
        private var _arrowShape:Shape;
        private var _arrowBmpData:BitmapData;
        private var _arrowTargetPos:Point;
        private var _numSucceccProb:NumericNumberMc;
        private var _numSucceccProb2:NumericNumberMc;
        private static const _STATUS_DISPLAY_ARROW_WIDTH:int = 29;
        private static const _STATUS_DISPLAY_ARROW_HEIGHT:int = 19;

        public function KumitePlayerListBalloon(param1:DisplayObjectContainer, param2:KumiteListPlayerData = null, param3:OwnSkillData = null, param4:Point = null, param5:Point = null)
        {
            this._mcBase = ResourceManager.getInstance().createMovieClip(ResourcePath.FACILITY_PATH + "UI_Training.swf", "CharaStatusBalloonMc");
            var _loc_6:* = new MovieClip();
            new MovieClip().mouseEnabled = false;
            _loc_6.mouseChildren = false;
            this._arrowShape = new Shape();
            _loc_6.addChild(this._arrowShape);
            this._mcBase.charaStatusBalloon.arrowNull.addChild(_loc_6);
            this._arrowBmpData = ResourceManager.getInstance().createSwfInBitmap(ResourcePath.FACILITY_PATH + "UI_Training.swf", "CharaStatusArrow");
            this._arrowTargetPos = new Point();
            this._numSucceccProb = null;
            this._numSucceccProb2 = null;
            param1.addChild(this._mcBase);
            if (param2)
            {
                this.setKumitePlayerData(param2, param3);
            }
            if (param4)
            {
                this.setPosition(param4);
            }
            if (param5)
            {
                this.setArrowTargetPosition(param5);
            }
            return;
        }// end function

        public function release() : void
        {
            if (this._numSucceccProb)
            {
                this._numSucceccProb.release();
            }
            this._numSucceccProb = null;
            if (this._numSucceccProb2)
            {
                this._numSucceccProb2.release();
            }
            this._numSucceccProb2 = null;
            if (this._mcBase && this._mcBase.parent)
            {
                this._mcBase.parent.removeChild(this._mcBase);
            }
            this._mcBase = null;
            return;
        }// end function

        public function show() : void
        {
            this._mcBase.visible = true;
            return;
        }// end function

        public function hide() : void
        {
            this._mcBase.visible = false;
            return;
        }// end function

        public function isShow() : Boolean
        {
            return this._mcBase.visible;
        }// end function

        public function setKumitePlayerData(param1:KumiteListPlayerData, param2:OwnSkillData) : void
        {
            TextControl.setIdText(this._mcBase.charaStatusBalloon.lvTextMc.textDt, MessageId.TOPBAR_LEVEL);
            TextControl.setText(this._mcBase.charaStatusBalloon.lvNumMc.textDt, UserDataManager.getInstance().getEmperorLv(param1.kumitePlayerData.exp).toString());
            TextControl.setText(this._mcBase.charaStatusBalloon.playerNameMc.textDt, param1.kumitePlayerData.userName ? (param1.kumitePlayerData.userName) : (UserDataManager.getInstance().userData.name));
            TextControl.setIdText(this._mcBase.charaStatusBalloon.armyTextMc.textDt, MessageId.TRAINING_ROOM_KUMITE_PLAYER_ARMY);
            TextControl.setText(this._mcBase.charaStatusBalloon.charaNameMc.textDt, param1.info.name);
            TextControl.setIdText(this._mcBase.charaStatusBalloon.charaStatus1TextMc.textDt, MessageId.COMMON_STATUS_HP);
            TextControl.setIdText(this._mcBase.charaStatusBalloon.charaStatus2TextMc.textDt, MessageId.COMMON_STATUS_LP);
            TextControl.setIdText(this._mcBase.charaStatusBalloon.charaStatus3TextMc.textDt, MessageId.COMMON_STATUS_SP);
            TextControl.setIdText(this._mcBase.charaStatusBalloon.charaStatus4TextMc.textDt, MessageId.COMMON_STATUS_ATTACK);
            TextControl.setIdText(this._mcBase.charaStatusBalloon.charaStatus5TextMc.textDt, MessageId.COMMON_STATUS_DEFENSE);
            TextControl.setIdText(this._mcBase.charaStatusBalloon.charaStatus6TextMc.textDt, MessageId.COMMON_STATUS_SPEED);
            TextControl.setIdText(this._mcBase.charaStatusBalloon.charaStatus7TextMc.textDt, MessageId.COMMON_STATUS_WAR_EXPERIENCE);
            TextControl.setIdText(this._mcBase.charaStatusBalloon.charaStatus8TextMc.textDt, MessageId.COMMON_STATUS_GROWTH);
            var _loc_3:* = param1.info.hp + param1.kumitePlayerData.addHp;
            var _loc_4:* = param1.info.attack + param1.kumitePlayerData.addAttack;
            var _loc_5:* = param1.info.defense + param1.kumitePlayerData.addDefense;
            var _loc_6:* = param1.info.speed + param1.kumitePlayerData.addSpeed;
            var _loc_7:* = String(param1.kumitePlayerData.hp + "/" + _loc_3);
            var _loc_8:* = String(param1.kumitePlayerData.lp + "/" + param1.info.lp);
            var _loc_9:* = String(param1.kumitePlayerData.sp + "/" + param1.info.sp);
            TextControl.setText(this._mcBase.charaStatusBalloon.charaStatusNum1TextMc.textDt, _loc_7);
            TextControl.setText(this._mcBase.charaStatusBalloon.charaStatusNum2TextMc.textDt, _loc_8);
            TextControl.setText(this._mcBase.charaStatusBalloon.charaStatusNum3TextMc.textDt, _loc_9);
            TextControl.setText(this._mcBase.charaStatusBalloon.charaStatusNum4TextMc.textDt, _loc_4.toString());
            TextControl.setText(this._mcBase.charaStatusBalloon.charaStatusNum5TextMc.textDt, _loc_5.toString());
            TextControl.setText(this._mcBase.charaStatusBalloon.charaStatusNum6TextMc.textDt, _loc_6.toString());
            TextControl.setText(this._mcBase.charaStatusBalloon.charaStatusNum7TextMc.textDt, param1.kumitePlayerData.battleCount.toString());
            TextControl.setIdText(this._mcBase.charaStatusBalloon.SuccessProbabilityTextMc.textDt, MessageId.TRAINING_ROOM_KUMITE_PLAYER_GREAT_SUCCESS_PROB);
            var _loc_10:* = param2 ? (TrainingRoomTable.getTrainingKumiteGreatSuccessProbability(param2, param1.kumitePlayerData)) : (0);
            this._numSucceccProb = new NumericNumberMc(this._mcBase.charaStatusBalloon.probabilityNumTop1aMc.probabilityNumMc, int(_loc_10 / 100), 1, false);
            this._numSucceccProb2 = new NumericNumberMc(this._mcBase.charaStatusBalloon.probabilityNumTop1bMc.probabilityNumMc, int(_loc_10 % 100), 1, true);
            var _loc_11:* = Math.max(1, Math.min(5, _loc_10 / 20 + 1));
            this._mcBase.charaStatusBalloon.ProbabilityColorBGMc.gotoAndStop(_loc_11);
            this._mcBase.charaStatusBalloon.probabilityNumTop1aMc.gotoAndStop(_loc_11);
            this._mcBase.charaStatusBalloon.probabilityNumTop1bMc.gotoAndStop(_loc_11);
            var _loc_12:* = new PlayerRarityIcon(this._mcBase.charaStatusBalloon.setCharaRankMc, param1.info.rarity);
            var _loc_13:* = new WeaponTypeIcon(this._mcBase.charaStatusBalloon.weaponTypeSetMc, param1.info.weaponType);
            var _loc_14:* = new MagicTypeIcon(this._mcBase.charaStatusBalloon.attributeTypeSetMc, param1.info.magicType);
            var _loc_15:* = new GrowthConditionIcon(this._mcBase.charaStatusBalloon.growArrowMc, PlayerPersonal.getGrowthLabel(param1.info, param1.kumitePlayerData.battleCount));
            return;
        }// end function

        public function setPosition(param1:Point) : void
        {
            if (this._mcBase)
            {
                this._mcBase.x = param1.x;
                this._mcBase.y = param1.y;
            }
            return;
        }// end function

        public function setArrowTargetPosition(param1:Point) : void
        {
            this._arrowTargetPos = param1;
            this.drawArrow(this._arrowTargetPos);
            return;
        }// end function

        private function drawArrow(param1:Point) : void
        {
            if (this._arrowBmpData == null)
            {
                return;
            }
            var _loc_2:* = this._arrowShape.localToGlobal(new Point());
            var _loc_3:* = this._arrowShape.graphics;
            _loc_3.clear();
            _loc_3.lineStyle(0, 0, 0);
            var _loc_4:* = Math.atan2(_loc_2.y - param1.y, _loc_2.x - param1.x);
            var _loc_5:* = Math.sqrt(Math.pow(_loc_2.x - param1.x, 2) + Math.pow(_loc_2.y - param1.y, 2));
            var _loc_6:* = new Matrix();
            new Matrix().identity();
            _loc_6.translate(0, Math.ceil(_STATUS_DISPLAY_ARROW_HEIGHT / 2));
            _loc_6.rotate(_loc_4);
            var _loc_7:* = new Matrix();
            new Matrix().identity();
            _loc_7.scale(_loc_5 / _STATUS_DISPLAY_ARROW_WIDTH, 1);
            _loc_7.rotate(_loc_4);
            _loc_7.translate(param1.x - _loc_2.x + _loc_6.tx, param1.y - _loc_2.y + _loc_6.ty);
            _loc_3.beginBitmapFill(this._arrowBmpData, _loc_7, true, true);
            _loc_3.moveTo(_loc_6.tx, _loc_6.ty);
            _loc_3.lineTo(-_loc_6.tx, -_loc_6.ty);
            _loc_3.lineTo(param1.x - _loc_2.x, param1.y - _loc_2.y);
            _loc_3.endFill();
            return;
        }// end function

        private function clearArrow() : void
        {
            var _loc_1:* = this._arrowShape.graphics;
            _loc_1.clear();
            return;
        }// end function

        public static function loadResource() : void
        {
            ResourceManager.getInstance().loadResource(ResourcePath.FACILITY_PATH + "UI_Training.swf");
            return;
        }// end function

    }
}
