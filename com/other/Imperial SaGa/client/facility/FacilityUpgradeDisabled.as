package facility
{
    import flash.display.*;
    import home.*;
    import layer.*;
    import message.*;
    import resource.*;
    import user.*;
    import utility.*;

    public class FacilityUpgradeDisabled extends Object
    {
        private var _baseMc:DisplayObjectContainer;
        private var _mcCountBg:MovieClip;
        private var _aroow:MovieClip;
        private var _mcTopPopUp:MovieClip;
        private var _numMc:NumericNumberMc;
        private var _layer:LayerMakeEquip;
        private var _numMain:InStayOut;
        private var _numArrow:InStayOut;
        private var _numPopUp:InStayOut;
        private var _popUp:Boolean = false;
        private var _popUpEnd:Boolean = false;

        public function FacilityUpgradeDisabled(param1:DisplayObjectContainer, param2:LayerMakeEquip = null)
        {
            this._baseMc = param1;
            this._layer = param2;
            this._aroow = ResourceManager.getInstance().createMovieClip(ResourcePath.FACILITY_PATH + "UI_FacilityGradeUp.swf", "arrowMc");
            this._aroow.x = 450;
            this._aroow.y = 80;
            this._aroow.gotoAndPlay("up3");
            this._numArrow = new InStayOut(this._aroow.arrow);
            this._mcCountBg = null;
            this._numMc = null;
            this._numMain = null;
            this._mcTopPopUp = ResourceManager.getInstance().createMovieClip(ResourcePath.FACILITY_PATH + "UI_FacilityGradeUp.swf", "Information2Mc");
            this._numPopUp = new InStayOut(this._mcTopPopUp);
            return;
        }// end function

        public function popUpEnd() : Boolean
        {
            return this._popUpEnd;
        }// end function

        public function release() : void
        {
            if (this._numMain)
            {
                this._numMain.release();
            }
            this._numMain = null;
            if (this._numArrow)
            {
                this._numArrow.release();
            }
            this._numArrow = null;
            if (this._numPopUp)
            {
                this._numPopUp.release();
            }
            this._numPopUp = null;
            if (this._mcCountBg && this._mcCountBg.parent)
            {
                this._mcCountBg.parent.removeChild(this._mcCountBg);
            }
            this._mcCountBg = null;
            if (this._aroow && this._aroow.parent)
            {
                this._aroow.parent.removeChild(this._aroow);
            }
            this._aroow = null;
            if (this._mcTopPopUp && this._mcTopPopUp.parent)
            {
                this._mcTopPopUp.parent.removeChild(this._mcTopPopUp);
            }
            this._mcTopPopUp = null;
            if (this._numMc)
            {
                this._numMc.release();
            }
            this._numMc = null;
            return;
        }// end function

        public function facilityUpgrade(param1:int) : Boolean
        {
            var _loc_2:* = TimeClock.getNowTime();
            var _loc_3:* = UserDataManager.getInstance().userData.getInstitutionInfo(param1);
            if (_loc_3.upgradeEnd > _loc_2 && _loc_3.upgradeEnd != 0)
            {
                if (this._mcCountBg == null)
                {
                    if (param1 == CommonConstant.FACILITY_ID_MAKE_EQUIP)
                    {
                        this._mcCountBg = ResourceManager.getInstance().createMovieClip(ResourcePath.FACILITY_PATH + "UI_FacilityGradeUp.swf", "Information2Mc");
                    }
                    else
                    {
                        this._mcCountBg = ResourceManager.getInstance().createMovieClip(ResourcePath.FACILITY_PATH + "UI_FacilityGradeUp.swf", "Information1Mc");
                    }
                }
                if (this._numMain == null)
                {
                    this._numMain = new InStayOut(this._mcCountBg);
                    this._baseMc.addChild(this._mcCountBg);
                    this._numMain.setIn();
                }
                TextControl.setIdText(this._mcCountBg.text1Mc.textDt, MessageId.FACILITY_UPGRADENOW_MESSAGE);
                TextControl.setIdText(this._mcCountBg.textMc.textDt, MessageId.FACILITY_UPGRADE_ENDTIME_MESSAGE);
                if (this._numMc == null)
                {
                    this._numMc = new NumericNumberMc(this._mcCountBg.remainingTimeMc, FacilityUpgradeUtility.getTime(param1, _loc_3.grade), 0);
                }
                this._numMc.startCount(_loc_3.upgradeEnd - _loc_2, 1);
                this._numMc.control(0);
                return true;
            }
            else
            {
                if (this._numMain)
                {
                    this._numMain.release();
                }
                this._numMain = null;
                if (this._numMc)
                {
                    this._numMc.release();
                }
                this._numMc = null;
                if (this._mcCountBg && this._mcCountBg.parent)
                {
                    this._mcCountBg.parent.removeChild(this._mcCountBg);
                }
                this._mcCountBg = null;
            }
            return false;
        }// end function

        public function countControl(param1:Number) : void
        {
            if (this._numMc != null)
            {
                this._numMc.count(param1);
                this._numMc.countTime();
                if (this._numMc.countEnd)
                {
                    this._numArrow.setIn();
                    this._baseMc.addChild(this._aroow);
                    TextControl.setText(this._mcCountBg.text1Mc.textDt, MessageManager.getInstance().getMessage(MessageId.FACILITY_UPGRADE_COMPLETION));
                    this._numMain.setIn();
                    this._mcCountBg.textMc.visible = false;
                    this._mcCountBg.remainingTimeMc.visible = false;
                    this._numMc.release();
                    this._numMc = null;
                }
            }
            return;
        }// end function

        public function popUpControl(param1:Number, param2:int) : void
        {
            var _loc_3:* = TimeClock.getNowTime();
            var _loc_4:* = UserDataManager.getInstance().userData.getInstitutionInfo(param2);
            if (UserDataManager.getInstance().userData.getInstitutionInfo(param2).upgradeEnd < _loc_3 && _loc_4.upgradeEnd != 0 && !this._popUp)
            {
                this._popUp = true;
                this._popUpEnd = true;
                this._baseMc.addChild(this._aroow);
                this._baseMc.addChild(this._mcTopPopUp);
                this._numArrow.setIn();
                TextControl.setText(this._mcTopPopUp.text1Mc.textDt, MessageManager.getInstance().getMessage(MessageId.FACILITY_UPGRADE_COMPLETION));
                this._numPopUp.setIn();
                this._mcTopPopUp.textMc.visible = false;
                this._mcTopPopUp.remainingTimeMc.visible = false;
            }
            return;
        }// end function

        public function close() : void
        {
            if (this._numMain && (this._numMain.bOpened || this._numMain.bAnimetionOpen))
            {
                this._numMain.setOut();
            }
            if (this._numArrow && (this._numArrow.bOpened || this._numArrow.bAnimetionOpen))
            {
                this._numArrow.setOut(function () : void
            {
                _aroow.eff_anm.parent.removeChild(_aroow.eff_anm);
                _aroow.eff_anm = null;
                return;
            }// end function
            );
            }
            if (this._mcTopPopUp && (this._numPopUp.bOpened || this._numPopUp.bAnimetionOpen))
            {
                this._numPopUp.setOut();
            }
            this._popUpEnd = false;
            this._popUp = false;
            return;
        }// end function

    }
}
