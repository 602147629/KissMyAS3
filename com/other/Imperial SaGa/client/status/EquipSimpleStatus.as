package status
{
    import battle.*;
    import button.*;
    import character.*;
    import flash.display.*;
    import flash.geom.*;
    import input.*;
    import item.*;
    import message.*;
    import resource.*;

    public class EquipSimpleStatus extends Object
    {
        private var _mcBase:MovieClip;
        private var _id:int;
        private var _btnArea:ButtonArea;
        private var _arrow:StatusArrow;
        private static const LABEL_RESIST_OFF:String = "ResultOff";
        private static const LABEL_RESIST_ON:String = "ResultOn";

        public function EquipSimpleStatus(param1:DisplayObjectContainer, param2:Point = null)
        {
            this._mcBase = ResourceManager.getInstance().createMovieClip(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf", "ItemStatusBalloon");
            this._arrow = new StatusArrow(this._mcBase.ItemStatusBalloonMc.arrowNull, ResourcePath.COMMON_DATA_PATH + "UI_Status.swf", "CharaStatusArrow");
            this._btnArea = new ButtonArea(this._mcBase);
            ButtonManager.getInstance().addButtonArea(this._btnArea);
            param1.addChild(this._mcBase);
            this._mcBase.visible = false;
            if (param2)
            {
                this.setPosition(param2);
            }
            return;
        }// end function

        public function get mc() : MovieClip
        {
            return this._mcBase;
        }// end function

        public function get id() : int
        {
            return this._id;
        }// end function

        public function get mcBaseX() : Number
        {
            return this._mcBase.x;
        }// end function

        public function get mcBaseY() : Number
        {
            return this._mcBase.y;
        }// end function

        public function get mcBaseWidth() : Number
        {
            return this._mcBase.width;
        }// end function

        public function get mcBaseHeight() : Number
        {
            return this._mcBase.height;
        }// end function

        public function release() : void
        {
            if (this._btnArea)
            {
                ButtonManager.getInstance().removeButtonArea(this._btnArea);
            }
            this._btnArea = null;
            if (this._arrow)
            {
                this._arrow.release();
            }
            this._arrow = null;
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
            this._mcBase.alpha = 1;
            if (this._btnArea)
            {
                this._btnArea.setEnable(true);
            }
            return;
        }// end function

        public function hide() : void
        {
            this._mcBase.visible = false;
            this._mcBase.alpha = 0;
            if (this._btnArea)
            {
                this._btnArea.setEnable(false);
            }
            return;
        }// end function

        public function isShow() : Boolean
        {
            return this._mcBase.visible;
        }// end function

        public function setItemData(param1:int) : void
        {
            this.setStatus(ItemManager.getInstance().getItemInformation(param1), ItemManager.getInstance().getItemStatus(param1));
            return;
        }// end function

        public function setStatus(param1:ItemInformation, param2:ItemStatus) : void
        {
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_3:* = this._mcBase.ItemStatusBalloonMc.ItemStatusBalloon;
            var _loc_4:* = false;
            if (param1 && param2)
            {
                _loc_4 = BattleToleranceData.checkAnyTolerance(param2.aDefenseTolerance);
            }
            if (_loc_4)
            {
                _loc_3.gotoAndStop(LABEL_RESIST_ON);
            }
            else
            {
                _loc_3.gotoAndStop(LABEL_RESIST_OFF);
            }
            _loc_3.attributeTypeMc.visible = false;
            _loc_3.weaponTypeMc.visible = false;
            TextControl.setText(_loc_3.Status1Mc.textDt, "");
            TextControl.setText(_loc_3.Status2Mc.textDt, "");
            TextControl.setText(_loc_3.Status3Mc.textDt, "");
            TextControl.setText(_loc_3.StatusNum1Mc.textMc.textDt, "");
            TextControl.setText(_loc_3.StatusNum2Mc.textMc.textDt, "");
            TextControl.setText(_loc_3.StatusNum3Mc.textMc.textDt, "");
            TextControl.setBonusText(_loc_3.statusNumSub1Mc, false, 0);
            TextControl.setBonusText(_loc_3.statusNumSub2Mc, false, 0);
            TextControl.setReverseBonusText(_loc_3.statusNumSub3Mc, false, 0);
            if (param1 == null)
            {
                TextControl.setText(_loc_3.NameMc.textDt, "");
                TextControl.setText(_loc_3.InfoMc.textDt, "");
            }
            else
            {
                TextControl.setText(_loc_3.NameMc.textDt, param1.name);
                if (param2)
                {
                    _loc_5 = [];
                    _loc_6 = [];
                    if (param2.addAttack)
                    {
                        _loc_5.push(MessageManager.getInstance().getMessage(MessageId.COMMON_STATUS_ATTACK));
                        _loc_6.push(param2.addAttack);
                    }
                    if (param2.addDefense)
                    {
                        _loc_5.push(MessageManager.getInstance().getMessage(MessageId.COMMON_STATUS_DEFENSE));
                        _loc_6.push(param2.addDefense);
                    }
                    if (param2.addSpeed)
                    {
                        _loc_5.push(MessageManager.getInstance().getMessage(MessageId.COMMON_STATUS_SPEED));
                        _loc_6.push(param2.addSpeed);
                    }
                    if (param2.addMagic)
                    {
                        _loc_5.push(MessageManager.getInstance().getMessage(MessageId.COMMON_STATUS_MAGIC_FITNESS));
                        _loc_6.push(param2.addMagic);
                    }
                    this.setParam(_loc_3, _loc_5, _loc_6);
                    if (_loc_4)
                    {
                        setResist(_loc_3, param2.aDefenseTolerance);
                    }
                }
                TextControl.setText(_loc_3.InfoMc.textDt, param1.explanation ? (param1.explanation) : (""));
            }
            return;
        }// end function

        private function setParam(param1:MovieClip, param2:Array, param3:Array) : void
        {
            var _loc_4:* = [param1.Status1Mc, param1.Status2Mc, param1.Status3Mc];
            var _loc_5:* = [param1.StatusNum1Mc, param1.StatusNum2Mc, param1.StatusNum3Mc];
            var _loc_6:* = param2.length;
            if (param2.length > _loc_4.length)
            {
                _loc_6 = _loc_4.length;
            }
            var _loc_7:* = 0;
            while (_loc_7 < _loc_6)
            {
                
                TextControl.setText(_loc_4[_loc_7].textDt, param2[_loc_7]);
                setAddParamText(_loc_5[_loc_7], param3[_loc_7]);
                _loc_7++;
            }
            return;
        }// end function

        public function setParent(param1:DisplayObjectContainer) : void
        {
            if (this._mcBase.parent != param1)
            {
                if (this._mcBase.parent)
                {
                    this._mcBase.parent.removeChild(this._mcBase);
                }
                if (param1)
                {
                    param1.addChild(this._mcBase);
                }
            }
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
            this._arrow.setArrowTargetPosition(param1);
            return;
        }// end function

        public function isHitTest() : Boolean
        {
            if (!this._mcBase.visible)
            {
                return false;
            }
            var _loc_1:* = InputManager.getInstance().corsor;
            return this._mcBase.hitTestPoint(_loc_1.x, _loc_1.y);
        }// end function

        public function setMouseEventEnable(param1:Boolean) : void
        {
            this._mcBase.mouseEnabled = param1;
            this._mcBase.mouseChildren = param1;
            return;
        }// end function

        public static function loadResource() : void
        {
            ResourceManager.getInstance().loadResource(ResourcePath.COMMON_DATA_PATH + "UI_Status.swf");
            return;
        }// end function

        private static function setResist(param1:MovieClip, param2:Array) : void
        {
            setResistHeadline([param1.Result1Mc, param1.Result2Mc, param1.Result3Mc, param1.Result4Mc, param1.Result5Mc, param1.Result6Mc, param1.Result7Mc]);
            setAddParamText(param1.ResultNum1Mc, BattleToleranceData.dispRate(BattleToleranceData.getToleranceRate(param2, CharacterConstant.ATTRIBUTE_SLASH)));
            setAddParamText(param1.ResultNum2Mc, BattleToleranceData.dispRate(BattleToleranceData.getToleranceRate(param2, CharacterConstant.ATTRIBUTE_PUNCH)));
            setAddParamText(param1.ResultNum3Mc, BattleToleranceData.dispRate(BattleToleranceData.getToleranceRate(param2, CharacterConstant.ATTRIBUTE_THRUST)));
            TextControl.setText(param1.ResultNum4Mc.textMc.textDt, "");
            setAddParamText(param1.ResultNum5Mc, BattleToleranceData.dispRate(BattleToleranceData.getToleranceRate(param2, CharacterConstant.ATTRIBUTE_HEAT)));
            setAddParamText(param1.ResultNum6Mc, BattleToleranceData.dispRate(BattleToleranceData.getToleranceRate(param2, CharacterConstant.ATTRIBUTE_ICY)));
            setAddParamText(param1.ResultNum7Mc, BattleToleranceData.dispRate(BattleToleranceData.getToleranceRate(param2, CharacterConstant.ATTRIBUTE_THUNDER)));
            return;
        }// end function

        private static function setResistHeadline(param1:Array) : void
        {
            if (param1[0])
            {
                TextControl.setIdText(param1[0].textDt, MessageId.RESIST_TYPE_SWORD);
            }
            if (param1[1])
            {
                TextControl.setIdText(param1[1].textDt, MessageId.RESIST_TYPE_BLOW);
            }
            if (param1[2])
            {
                TextControl.setIdText(param1[2].textDt, MessageId.RESIST_TYPE_THRUST);
            }
            if (param1[3])
            {
                TextControl.setText(param1[3].textDt, "");
            }
            if (param1[4])
            {
                TextControl.setIdText(param1[4].textDt, MessageId.RESIST_TYPE_HEAT);
            }
            if (param1[5])
            {
                TextControl.setIdText(param1[5].textDt, MessageId.RESIST_TYPE_COLD);
            }
            if (param1[6])
            {
                TextControl.setIdText(param1[6].textDt, MessageId.RESIST_TYPE_THUNDER);
            }
            return;
        }// end function

        private static function setAddParamText(param1:MovieClip, param2:int) : TextControl
        {
            param1.gotoAndStop(param2 != 0 ? (param2 < 0 ? ("down") : ("up")) : ("normal"));
            return TextControl.setText(param1.textMc.textDt, param2 < 0 ? ("-" + (-param2)) : ("+" + param2));
        }// end function

    }
}
