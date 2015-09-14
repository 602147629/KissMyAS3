package formation
{
    import flash.display.*;
    import flash.geom.*;
    import resource.*;
    import utility.*;

    public class FormationData extends Object
    {
        private var _formationId:int;
        private var _formationMc:MovieClip;
        private var _aCharaMc:Array;
        private var _commanderMc:MovieClip;
        private var _commanderOutMc:MovieClip;
        private var _aCharacterPos:Array;
        private var _commanderPos:Point;
        private var _commanderOutPos:Point;
        private var _formationInfo:FormationInformation;
        private static const _FORMATION:String = "Formation";

        public function FormationData(param1:DisplayObjectContainer, param2:int)
        {
            this._formationMc = ResourceManager.getInstance().createMovieClip(ResourcePath.BATTLE_PATH + "BattleFormation.swf", "BattleFormation");
            param1.addChild(this._formationMc);
            this.init();
            this.setFormationLabel(param2);
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            if (this._formationMc)
            {
                if (this._formationMc.parent)
                {
                    this._formationMc.parent.removeChild(this._formationMc);
                }
            }
            this._formationMc = null;
            for each (_loc_1 in this._aCharaMc)
            {
                
                _loc_1.removeChildren();
            }
            this._commanderMc = null;
            this._commanderOutMc = null;
            return;
        }// end function

        public function removeFormationMc() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aCharaMc)
            {
                
                if (_loc_1.numChildren > 1)
                {
                    _loc_1.removeChildAt(1);
                }
            }
            return;
        }// end function

        public function setFormationLabel(param1:int) : void
        {
            this._formationId = param1;
            this._formationInfo = FormationManager.getInstance().getFormationInformation(this._formationId);
            var _loc_2:* = _FORMATION + param1.toString();
            if (this._formationMc.currentLabel != _loc_2)
            {
                this._formationMc.gotoAndStop(_loc_2);
            }
            this.updateCharacterPos();
            return;
        }// end function

        public function isHitFormationMc(param1:Point, param2:int) : int
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_3:* = 0;
            for each (_loc_5 in this._aCharaMc)
            {
                
                if (_loc_3 != param2 && _loc_3 < this._formationInfo.member && _loc_5.getChildAt(0).hitTestPoint(param1.x, param1.y))
                {
                    return _loc_3;
                }
                _loc_3++;
            }
            return -1;
        }// end function

        public function isHitFormationMc2(param1:Point, param2:int) : int
        {
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_3:* = 0;
            for each (_loc_5 in this._aCharaMc)
            {
                
                if (_loc_3 != param2 && _loc_3 < this._formationInfo.member && _loc_5.getChildAt(0).hitTestPoint(param1.x, param1.y))
                {
                    if (!HitTest.isObstructHitTest(_loc_5.getChildAt(0), param1.x, param1.y))
                    {
                        break;
                    }
                    return _loc_3;
                }
                _loc_3++;
            }
            return -1;
        }// end function

        public function getPosition(param1:int) : Point
        {
            var _loc_2:* = param1 == FormationSetData.FORMATION_INDEX_COMMANDER ? (this._commanderPos) : (this._aCharacterPos[param1]);
            return _loc_2;
        }// end function

        public function getOutPosition(param1:int) : Point
        {
            var _loc_2:* = param1 == FormationSetData.FORMATION_INDEX_COMMANDER ? (this._commanderOutPos) : (this._aCharacterPos[param1]);
            return _loc_2;
        }// end function

        public function getCommanderPosition() : Point
        {
            return this._commanderPos;
        }// end function

        public function getCommanderOutPosition() : Point
        {
            return this._commanderOutPos;
        }// end function

        public function get formationId() : int
        {
            return this._formationId;
        }// end function

        public function get formationMc() : MovieClip
        {
            return this._formationMc;
        }// end function

        public function get aCharaMc() : Array
        {
            return this._aCharaMc;
        }// end function

        private function init() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            this._aCharaMc = [this._formationMc.charaLay1, this._formationMc.charaLay2, this._formationMc.charaLay3, this._formationMc.charaLay4, this._formationMc.charaLay5];
            this._commanderMc = this._formationMc.charaLay6;
            this._commanderOutMc = this._formationMc.charaLay7;
            this.updateCharacterPos();
            for each (_loc_1 in this._aCharaMc)
            {
                
                _loc_2 = new Sprite();
                _loc_1.addChild(_loc_2);
                _loc_3 = _loc_2.graphics;
                _loc_3.beginFill(16729156);
                _loc_3.drawRect(-30, -70, 60, 85);
                _loc_3.endFill();
                _loc_2.visible = false;
                _loc_1.hitArea = _loc_2;
            }
            return;
        }// end function

        private function updateCharacterPos() : void
        {
            var _loc_1:* = null;
            this._aCharacterPos = [];
            for each (_loc_1 in this._aCharaMc)
            {
                
                this._aCharacterPos.push(_loc_1.localToGlobal(new Point()));
            }
            if (this._commanderMc)
            {
                this._commanderPos = this._commanderMc.localToGlobal(new Point());
            }
            if (this._commanderOutMc)
            {
                this._commanderOutPos = this._commanderOutMc.localToGlobal(new Point());
            }
            return;
        }// end function

        public function updatePos() : void
        {
            this.updateCharacterPos();
            return;
        }// end function

    }
}
