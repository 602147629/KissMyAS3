package magicLaboratory
{
    import asset.*;
    import flash.display.*;
    import message.*;
    import player.*;
    import resource.*;
    import status.*;
    import utility.*;

    public class MLearnCheckStatus extends Object
    {
        private const _PHASE_OPEN:int = 1;
        private const _PHASE_WAIT:int = 10;
        private const _PHASE_CLOSE:int = 99;
        private var _phase:int;
        private var _baseMc:MovieClip;
        private var _isoBase:InStayOut;
        private var _playerDisplay:PlayerDisplay;
        private var _playerMiniStatus:PlayerMiniStatus;
        private var _skillSimpleStatus:SkillSimpleStatus;
        private var _learningTime:NumericNumberMc;
        private var _assetIcon:AssetIcon;

        public function MLearnCheckStatus(param1:DisplayObjectContainer)
        {
            this._baseMc = ResourceManager.getInstance().createMovieClip(ResourcePath.FACILITY_PATH + "UI_MagicLaboratory.swf", "LearningConsentPopMc");
            param1.addChild(this._baseMc);
            this._isoBase = new InStayOut(this._baseMc);
            this._playerDisplay = new PlayerDisplay(this._baseMc.LearningConsentPop.charaNull, Constant.EMPTY_ID, Constant.EMPTY_ID);
            this._playerMiniStatus = new PlayerMiniStatus(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf", this._baseMc.LearningConsentPop.charaNull);
            this._playerMiniStatus.setInvisible(PlayerMiniStatus.INVISIBLE_FLAG_HP | PlayerMiniStatus.INVISIBLE_FLAG_GROWTH | PlayerMiniStatus.INVISIBLE_FLAG_PICKUP_PARAM | PlayerMiniStatus.INVISIBLE_FLAG_ACTIVITY_PARAM);
            this._skillSimpleStatus = new SkillSimpleStatus(this._baseMc.LearningConsentPop.StatusNull);
            this._learningTime = new NumericNumberMc(this._baseMc.LearningConsentPop.larningTimeMc, 0, 0);
            this._assetIcon = new AssetIcon(this._baseMc.LearningConsentPop.dsNull, AssetId.ASSET_MAGIC_DEVELOP);
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            return this._isoBase.bClosed;
        }// end function

        public function release() : void
        {
            if (this._assetIcon)
            {
                this._assetIcon.release();
            }
            this._assetIcon = null;
            if (this._learningTime)
            {
                this._learningTime.release();
            }
            this._learningTime = null;
            if (this._skillSimpleStatus)
            {
                this._skillSimpleStatus.release();
            }
            this._skillSimpleStatus = null;
            if (this._playerMiniStatus)
            {
                this._playerMiniStatus.release();
            }
            this._playerMiniStatus = null;
            if (this._playerDisplay)
            {
                this._playerDisplay.release();
            }
            this._playerDisplay = null;
            if (this._isoBase)
            {
                this._isoBase.release();
            }
            this._isoBase = null;
            if (this._baseMc.parent)
            {
                this._baseMc.parent.removeChild(this._baseMc);
            }
            this._baseMc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            switch(this._phase)
            {
                case this._PHASE_OPEN:
                {
                    this.controlOpen();
                    break;
                }
                case this._PHASE_WAIT:
                {
                    this.controlWait();
                    break;
                }
                case this._PHASE_CLOSE:
                {
                    this.controlClose();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function setPhase(param1:int) : void
        {
            if (param1 != this._phase)
            {
                this._phase = param1;
                switch(this._phase)
                {
                    case this._PHASE_OPEN:
                    {
                        this.phaseOpen();
                        break;
                    }
                    case this._PHASE_WAIT:
                    {
                        this.phaseWait();
                        break;
                    }
                    case this._PHASE_CLOSE:
                    {
                        this.phaseClose();
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        public function open() : void
        {
            this.setPhase(this._PHASE_OPEN);
            return;
        }// end function

        public function close() : void
        {
            this.setPhase(this._PHASE_CLOSE);
            return;
        }// end function

        public function setData(param1:PlayerPersonal, param2:int, param3:uint, param4:int) : void
        {
            this._playerDisplay.setId(param1.playerId, param1.uniqueId);
            this._playerDisplay.setAnimSelect();
            this._playerMiniStatus.setPlayerPersonal(param1);
            this._playerMiniStatus.show();
            this._skillSimpleStatus.setSkillData(param2);
            this._skillSimpleStatus.show();
            TextControl.setIdText(this._baseMc.LearningConsentPop.textMc.textDt, MessageId.COMMON_DEVELOP_END_TIME);
            this._learningTime.setTime(param3);
            TextControl.setText(this._baseMc.LearningConsentPop.costTextMc.textDt, param4.toString());
            return;
        }// end function

        private function phaseOpen() : void
        {
            this._isoBase.setIn();
            return;
        }// end function

        private function controlOpen() : void
        {
            if (this._isoBase.bOpened)
            {
                this.setPhase(this._PHASE_WAIT);
            }
            return;
        }// end function

        private function phaseWait() : void
        {
            return;
        }// end function

        private function controlWait() : void
        {
            return;
        }// end function

        private function phaseClose() : void
        {
            this._isoBase.setOut();
            return;
        }// end function

        private function controlClose() : void
        {
            return;
        }// end function

        public static function loadResource() : void
        {
            ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf");
            SkillSimpleStatus.loadResource();
            return;
        }// end function

    }
}
