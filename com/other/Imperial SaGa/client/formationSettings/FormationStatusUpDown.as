package formationSettings
{
    import flash.display.*;
    import formation.*;
    import player.*;
    import resource.*;
    import utility.*;

    public class FormationStatusUpDown extends Object
    {
        private var _mc:MovieClip;
        private var _bVisible:Boolean;
        private var _bIconVisible:Boolean;
        private var _aChanger:Array;
        private var _lastChangeTiming:uint;
        private var _formationIndex:int;
        private var _formationId:int;
        private var _weaponType:int;
        private var _bFormationBonus:Boolean;
        public static const PARAM_ATK:int = 0;
        public static const PARAM_DEF:int = 1;
        public static const PARAM_AGL:int = 2;
        public static const PARAM_INT:int = 3;
        private static const _PARAM_LABEL_TABLE:Array = ["atk", "def", "agi", "int"];
        public static const UP:int = 0;
        public static const DOWN:int = 1;
        private static const _UPDOWN_LABEL_TABLE:Array = ["Up", "Down"];
        public static const CORRECTION_VALUE_LARGE:int = 0;
        public static const CORRECTION_VALUE_MEDIUM:int = 1;
        public static const CORRECTION_VALUE_SMALL:int = 2;
        private static const _CORRECTION_VALUE_LABEL_TABLE:Array = ["3", "2", "1"];
        private static const _ATK_PLUS_RANGE_TABLE:Array = [CommonConstant.FORMATION_PARAM_RANGE_ATK_HIGH, CommonConstant.FORMATION_PARAM_RANGE_ATK_MIDDLE, CommonConstant.FORMATION_PARAM_RANGE_ATK_LOW];
        private static const _ATK_MINUS_RANGE_TABLE:Array = [-CommonConstant.FORMATION_PARAM_RANGE_ATK_HIGH, -CommonConstant.FORMATION_PARAM_RANGE_ATK_MIDDLE, -CommonConstant.FORMATION_PARAM_RANGE_ATK_LOW];
        private static const _DEF_PLUS_RANGE_TABLE:Array = [CommonConstant.FORMATION_PARAM_RANGE_DEF_HIGH, CommonConstant.FORMATION_PARAM_RANGE_DEF_MIDDLE, CommonConstant.FORMATION_PARAM_RANGE_DEF_LOW];
        private static const _DEF_MINUS_RANGE_TABLE:Array = [-CommonConstant.FORMATION_PARAM_RANGE_DEF_HIGH, -CommonConstant.FORMATION_PARAM_RANGE_DEF_MIDDLE, -CommonConstant.FORMATION_PARAM_RANGE_DEF_LOW];
        private static const _AGL_PLUS_RANGE_TABLE:Array = [CommonConstant.FORMATION_PARAM_RANGE_SPD_HIGH, CommonConstant.FORMATION_PARAM_RANGE_SPD_MIDDLE, CommonConstant.FORMATION_PARAM_RANGE_SPD_LOW];
        private static const _AGL_MINUS_RANGE_TABLE:Array = [-CommonConstant.FORMATION_PARAM_RANGE_SPD_HIGH, -CommonConstant.FORMATION_PARAM_RANGE_SPD_MIDDLE, -CommonConstant.FORMATION_PARAM_RANGE_SPD_LOW];
        private static const _INT_PLUS_RANGE_TABLE:Array = [CommonConstant.FORMATION_PARAM_RANGE_MAG_HIGH, CommonConstant.FORMATION_PARAM_RANGE_MAG_MIDDLE, CommonConstant.FORMATION_PARAM_RANGE_MAG_LOW];
        private static const _INT_MINUS_RANGE_TABLE:Array = [-CommonConstant.FORMATION_PARAM_RANGE_MAG_HIGH, -CommonConstant.FORMATION_PARAM_RANGE_MAG_MIDDLE, -CommonConstant.FORMATION_PARAM_RANGE_MAG_LOW];

        public function FormationStatusUpDown(param1:DisplayObjectContainer, param2:int = -1, param3:int = 0, param4:int = 0)
        {
            this._mc = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "BattleFormation.swf", "statusUpDownPartsMc");
            this._mc.mouseEnabled = false;
            this._mc.mouseChildren = false;
            param1.addChild(this._mc);
            this._bVisible = true;
            this._bIconVisible = false;
            this._aChanger = [];
            this._lastChangeTiming = 0;
            this._formationIndex = param2;
            this._formationId = param3;
            this._weaponType = Constant.UNDECIDED;
            this._bFormationBonus = false;
            this.setPlayerId(param4);
            this.setFormationId(this._formationId, this._bFormationBonus);
            return;
        }// end function

        public function get mc() : MovieClip
        {
            return this._mc;
        }// end function

        public function release() : void
        {
            this.clearIcon();
            this._aChanger = null;
            if (this._mc && this._mc.parent)
            {
                this._mc.parent.removeChild(this._mc);
            }
            this._mc = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = TimeClock.getNowTime() >> 1;
            if (_loc_2 != this._lastChangeTiming)
            {
                this._lastChangeTiming = _loc_2;
                for each (_loc_3 in this._aChanger)
                {
                    
                    _loc_3.change();
                }
            }
            return;
        }// end function

        public function setPosition(param1:int, param2:int) : void
        {
            this._mc.x = param1;
            this._mc.y = param2;
            return;
        }// end function

        public function show() : void
        {
            this._bVisible = true;
            this.updateVisible();
            return;
        }// end function

        public function hide() : void
        {
            this._bVisible = false;
            this.updateVisible();
            return;
        }// end function

        private function setIconVisible(param1:Boolean) : void
        {
            this._bIconVisible = param1;
            this.updateVisible();
            return;
        }// end function

        private function updateVisible() : void
        {
            this._mc.visible = this._bVisible && this._bIconVisible;
            return;
        }// end function

        public function setPlayerId(param1:int) : void
        {
            var _loc_2:* = PlayerManager.getInstance().getPlayerInformation(param1);
            var _loc_3:* = _loc_2 ? (_loc_2.weaponType) : (Constant.UNDECIDED);
            if (this._weaponType != _loc_3)
            {
                this._weaponType = _loc_3;
                this.setFormationId(this._formationId, this._bFormationBonus);
            }
            return;
        }// end function

        public function setFormationBonusOccurrence(param1:Boolean) : void
        {
            if (this._bFormationBonus != param1)
            {
                this._bFormationBonus = param1;
                this.setFormationId(this._formationId, this._bFormationBonus);
            }
            return;
        }// end function

        public function setFormationId(param1:int, param2:Boolean) : void
        {
            var _loc_11:* = 0;
            this.clearIcon();
            this._formationId = param1;
            this._bFormationBonus = param2;
            if (this._bFormationBonus == false)
            {
                this.setIconVisible(false);
                return;
            }
            if (this._formationIndex < 0 || param1 == Constant.EMPTY_ID)
            {
                this.setIconVisible(false);
                return;
            }
            var _loc_3:* = FormationManager.getInstance().getFormationInformation(this._formationId);
            if (_loc_3 == null)
            {
                this.setIconVisible(false);
                return;
            }
            var _loc_4:* = [CORRECTION_VALUE_LARGE, CORRECTION_VALUE_MEDIUM, CORRECTION_VALUE_SMALL];
            var _loc_5:* = _loc_3.getAttackCorrectionValue(this._formationIndex, this._weaponType);
            var _loc_6:* = _loc_3.getDefenseCorrectionValue(this._formationIndex, this._weaponType);
            var _loc_7:* = _loc_3.getSpeedCorrectionValue(this._formationIndex, this._weaponType);
            var _loc_8:* = _loc_3.getMagicCorrectionValue(this._formationIndex, this._weaponType);
            var _loc_9:* = [];
            var _loc_10:* = [];
            if (_loc_5 > 0)
            {
                _loc_11 = 0;
                while (_loc_11 < _ATK_PLUS_RANGE_TABLE.length)
                {
                    
                    if (_loc_5 >= _ATK_PLUS_RANGE_TABLE[_loc_11])
                    {
                        _loc_9.push(this.getLabelName(PARAM_ATK, UP, _loc_4[_loc_11]));
                        break;
                    }
                    _loc_11++;
                }
            }
            else if (_loc_5 < 0)
            {
                _loc_11 = 0;
                while (_loc_11 < _ATK_MINUS_RANGE_TABLE.length)
                {
                    
                    if (_loc_5 <= _ATK_MINUS_RANGE_TABLE[_loc_11])
                    {
                        _loc_10.push(this.getLabelName(PARAM_ATK, DOWN, _loc_4[_loc_11]));
                        break;
                    }
                    _loc_11++;
                }
            }
            if (_loc_6 > 0)
            {
                _loc_11 = 0;
                while (_loc_11 < _DEF_PLUS_RANGE_TABLE.length)
                {
                    
                    if (_loc_6 >= _DEF_PLUS_RANGE_TABLE[_loc_11])
                    {
                        _loc_9.push(this.getLabelName(PARAM_DEF, UP, _loc_4[_loc_11]));
                        break;
                    }
                    _loc_11++;
                }
            }
            else if (_loc_6 < 0)
            {
                _loc_11 = 0;
                while (_loc_11 < _DEF_MINUS_RANGE_TABLE.length)
                {
                    
                    if (_loc_6 <= _DEF_MINUS_RANGE_TABLE[_loc_11])
                    {
                        _loc_10.push(this.getLabelName(PARAM_DEF, DOWN, _loc_4[_loc_11]));
                        break;
                    }
                    _loc_11++;
                }
            }
            if (_loc_7 > 0)
            {
                _loc_11 = 0;
                while (_loc_11 < _AGL_PLUS_RANGE_TABLE.length)
                {
                    
                    if (_loc_7 >= _AGL_PLUS_RANGE_TABLE[_loc_11])
                    {
                        _loc_9.push(this.getLabelName(PARAM_AGL, UP, _loc_4[_loc_11]));
                        break;
                    }
                    _loc_11++;
                }
            }
            else if (_loc_7 < 0)
            {
                _loc_11 = 0;
                while (_loc_11 < _AGL_MINUS_RANGE_TABLE.length)
                {
                    
                    if (_loc_7 <= _AGL_MINUS_RANGE_TABLE[_loc_11])
                    {
                        _loc_10.push(this.getLabelName(PARAM_AGL, DOWN, _loc_4[_loc_11]));
                        break;
                    }
                    _loc_11++;
                }
            }
            if (_loc_8 > 0)
            {
                _loc_11 = 0;
                while (_loc_11 < _INT_PLUS_RANGE_TABLE.length)
                {
                    
                    if (_loc_8 >= _INT_PLUS_RANGE_TABLE[_loc_11])
                    {
                        _loc_9.push(this.getLabelName(PARAM_INT, UP, _loc_4[_loc_11]));
                        break;
                    }
                    _loc_11++;
                }
            }
            else if (_loc_8 < 0)
            {
                _loc_11 = 0;
                while (_loc_11 < _INT_MINUS_RANGE_TABLE.length)
                {
                    
                    if (_loc_8 <= _INT_MINUS_RANGE_TABLE[_loc_11])
                    {
                        _loc_10.push(this.getLabelName(PARAM_INT, DOWN, _loc_4[_loc_11]));
                        break;
                    }
                    _loc_11++;
                }
            }
            this.setParam(_loc_9, _loc_10);
            return;
        }// end function

        private function getLabelName(param1:int, param2:int, param3:int) : String
        {
            return _PARAM_LABEL_TABLE[param1] + _UPDOWN_LABEL_TABLE[param2] + _CORRECTION_VALUE_LABEL_TABLE[param3];
        }// end function

        private function clearIcon() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aChanger)
            {
                
                _loc_1.release();
            }
            this._aChanger = [];
            return;
        }// end function

        private function setParam(param1:Array, param2:Array) : void
        {
            this._mc.statusRevisionIconMc1.visible = false;
            this._mc.statusRevisionIconMc2.visible = false;
            this._mc.statusRevisionIconMc3.visible = false;
            if (param1.length > 0 && param2.length > 0)
            {
                this._aChanger.push(new RevisionIconChanger(this._mc.statusRevisionIconMc2, param1));
                this._aChanger.push(new RevisionIconChanger(this._mc.statusRevisionIconMc3, param2));
                this.setIconVisible(true);
            }
            else if (param1.length > 0)
            {
                this._aChanger.push(new RevisionIconChanger(this._mc.statusRevisionIconMc1, param1));
                this.setIconVisible(true);
            }
            else if (param2.length > 0)
            {
                this._aChanger.push(new RevisionIconChanger(this._mc.statusRevisionIconMc1, param2));
                this.setIconVisible(true);
            }
            else
            {
                this.setIconVisible(false);
            }
            return;
        }// end function

    }
}

import flash.display.*;

import formation.*;

import player.*;

import resource.*;

import utility.*;

class RevisionIconChanger extends Object
{
    private var _isoMain:InStayOut;
    private var _iconMc:MovieClip;
    private var _aLabel:Array;
    private var _idx:int;

    function RevisionIconChanger(param1:MovieClip, param2:Array)
    {
        this._isoMain = new InStayOut(param1, true);
        this._iconMc = param1.IconMc;
        this._aLabel = param2;
        this._idx = 0;
        this._iconMc.gotoAndStop(this._aLabel[this._idx]);
        return;
    }// end function

    public function release() : void
    {
        this._aLabel = null;
        this._iconMc = null;
        this._isoMain.release();
        this._isoMain = null;
        return;
    }// end function

    public function change() : void
    {
        if (this._aLabel.length > 1)
        {
            this._isoMain.setIn(this.cbIn);
        }
        return;
    }// end function

    private function cbIn() : void
    {
        if (this._aLabel == null)
        {
            return;
        }
        this._idx = (this._idx + 1) % this._aLabel.length;
        this._iconMc.gotoAndStop(this._aLabel[this._idx]);
        this._isoMain.setOut();
        return;
    }// end function

}

