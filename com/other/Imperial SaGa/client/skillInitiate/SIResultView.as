package skillInitiate
{
    import button.*;
    import flash.display.*;
    import icon.*;
    import message.*;
    import player.*;
    import popup.*;
    import resource.*;
    import sound.*;
    import utility.*;

    public class SIResultView extends Object
    {
        private var _resultMc:MovieClip;
        private var _isoResult:InStayOut;
        private var _teacher:PlayerInformation;
        private var _upParam:int;
        private var _rarityIcon:PlayerRarityIcon;
        private var _bSuccess:Boolean;
        private var _aTextData:Array;
        private var _nextBtn:ButtonBase;

        public function SIResultView(param1:DisplayObjectContainer, param2:Boolean, param3:PlayerInformation, param4:PlayerInformation, param5:String = "", param6:int = 0, param7:Boolean = false)
        {
            var _loc_8:* = null;
            this._resultMc = ResourceManager.getInstance().createMovieClip(ResourcePath.FACILITY_PATH + "UI_SkillInitiate.swf", param2 ? ("ResultSuccessMc") : ("ResultFailureMc"));
            this._isoResult = new InStayOut(this._resultMc);
            this._nextBtn = ButtonManager.getInstance().addButton(this._resultMc.nextBtnMc, this.cbFinishInitiate);
            this._nextBtn.enterSeId = ButtonBase.SE_DECIDE_ID;
            this._teacher = param4;
            this._upParam = param6;
            this._bSuccess = param2;
            this._rarityIcon = new PlayerRarityIcon(this._resultMc.resultInfoMc.setCharaRankMc);
            this._aTextData = [];
            if (param7)
            {
                this._aTextData.push(new DispTextData(TextControl.formatIdText(param2 ? (MessageId.SKILL_INITIATE_MESSAGE_INITIATE_SUCCESS_UPDATE) : (MessageId.SKILL_INITIATE_MESSAGE_INITIATE_FAILURE_UPDATE), param3.name, param5, param5), param3.rarity));
            }
            else
            {
                this._aTextData.push(new DispTextData(TextControl.formatIdText(param2 ? (MessageId.SKILL_INITIATE_MESSAGE_INITIATE_SUCCESS_NEW) : (MessageId.SKILL_INITIATE_MESSAGE_INITIATE_FAILURE_NEW), param3.name, param5), param3.rarity));
            }
            if (param6 != SIConstant.INITIATE_STATUS_NONE)
            {
                _loc_8 = "";
                switch(param6)
                {
                    case SIConstant.INITIATE_STATUS_ATTACK:
                    {
                        _loc_8 = MessageManager.getInstance().getMessage(MessageId.COMMON_STATUS_ATTACK);
                        break;
                    }
                    case SIConstant.INITIATE_STATUS_DEFENCE:
                    {
                        _loc_8 = MessageManager.getInstance().getMessage(MessageId.COMMON_STATUS_DEFENSE);
                        break;
                    }
                    case SIConstant.INITIATE_STATUS_SPEED:
                    {
                        _loc_8 = MessageManager.getInstance().getMessage(MessageId.COMMON_STATUS_SPEED);
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                this._aTextData.push(new DispTextData(TextControl.formatIdText(MessageId.SKILL_INITIATE_MESSAGE_INITIATE_STATUS_UP, param4.name, _loc_8), param4.rarity));
            }
            param1.addChild(this._resultMc);
            this.setInfoText();
            this.openResult();
            return;
        }// end function

        public function get bEnd() : Boolean
        {
            if (CommonPopup.isUse())
            {
                return false;
            }
            if (this._isoResult == null)
            {
                return true;
            }
            return this._isoResult.bEnd;
        }// end function

        public function release() : void
        {
            if (this._nextBtn)
            {
                ButtonManager.getInstance().removeButton(this._nextBtn);
            }
            if (this._resultMc && this._resultMc.parent)
            {
                this._resultMc.parent.removeChild(this._resultMc);
            }
            if (this._isoResult)
            {
                this._isoResult.release();
            }
            return;
        }// end function

        public function openResult() : void
        {
            if (this._isoResult.bClosed)
            {
                SoundManager.getInstance().playSe(this._bSuccess ? (SoundId.SE_COMPOSE_SUCSESS) : (SoundId.SE_COMPOSE_FALE));
                this._isoResult.setIn();
            }
            return;
        }// end function

        public function closeResult() : void
        {
            if (this._isoResult.bOpened)
            {
                this._isoResult.setOut();
            }
            return;
        }// end function

        private function cbFinishInitiate(param1:int) : void
        {
            if (this._aTextData.length == 0)
            {
                this.closeResult();
            }
            else
            {
                this.setInfoText();
            }
            return;
        }// end function

        private function setInfoText() : void
        {
            if (this._aTextData.length == 0)
            {
                return;
            }
            var _loc_1:* = this._aTextData.shift() as DispTextData;
            var _loc_2:* = _loc_1.text.split("\n");
            this._resultMc.resultInfoMc.gotoAndStop(_loc_2.length > 1 ? ("2") : ("1"));
            TextControl.setText(this._resultMc.resultInfoMc.text1Mc.textDt, _loc_2[0]);
            TextControl.setText(this._resultMc.resultInfoMc.text2Mc.textDt, _loc_2.length > 1 ? (_loc_2[1]) : (""));
            TextControl.setIdText(this._resultMc.nextBtnMc.textMc.textDt, this._aTextData.length == 0 ? (MessageId.COMMON_BUTTON_OK) : (MessageId.COMMON_BUTTON_NEXT));
            this._rarityIcon.setRarity(_loc_1.rarity);
            return;
        }// end function

    }
}

import button.*;

import flash.display.*;

import icon.*;

import message.*;

import player.*;

import popup.*;

import resource.*;

import sound.*;

import utility.*;

class DispTextData extends Object
{
    private var _rarity:int;
    private var _text:String;

    function DispTextData(param1:String, param2:int = 0)
    {
        this._rarity = param2;
        this._text = param1;
        return;
    }// end function

    public function get rarity() : int
    {
        return this._rarity;
    }// end function

    public function get text() : String
    {
        return this._text;
    }// end function

}

