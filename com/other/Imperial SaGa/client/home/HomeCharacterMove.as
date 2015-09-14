package home
{
    import flash.display.*;
    import flash.geom.*;
    import player.*;
    import resource.*;
    import tutorial.*;
    import user.*;
    import utility.*;

    public class HomeCharacterMove extends Object
    {
        private var _aMoveFacirityId:Array;
        private const _aFacilityOffset:Array;
        private const _CHARACTER_ADD_TIME:Number = 2;
        private var _sprite:Sprite;
        private var _aCharacterLabelAndTime:Array;
        private var _aHaveFacilityId:Array;
        private var _aFacilityPoint:Array;
        private var _aCharacterId:Array;
        private var _aPlayerDisplay:Array;
        private var _stopTime:Number;
        private var _addTime:Number;
        private var _addCharaId:int;
        private var _bStop:Boolean;
        private static const _CHARACTER_WOLK_TIME:Number = 7;
        private static const _CHARACTER_DASH_TIME:Number = 3;
        private static const _MOVE_LENGHT_X:Number = 200;
        private static const _MOVE_LENGHT_Y:Number = 250;

        public function HomeCharacterMove(param1:MovieClip, param2:Array)
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            this._aMoveFacirityId = [{id1:CommonConstant.FACILITY_ID_MYPAGE, id2:CommonConstant.FACILITY_ID_WEARHOUSE}, {id1:CommonConstant.FACILITY_ID_MYPAGE, id2:CommonConstant.FACILITY_ID_SKILL_INITIATE}, {id1:CommonConstant.FACILITY_ID_MYPAGE, id2:CommonConstant.FACILITY_ID_MAGIC_DEVELOP}, {id1:CommonConstant.FACILITY_ID_MYPAGE, id2:CommonConstant.FACILITY_ID_TRAINING_ROOM}, {id1:CommonConstant.FACILITY_ID_MYPAGE, id2:CommonConstant.FACILITY_ID_MAKE_EQUIP}, {id1:CommonConstant.FACILITY_ID_MYPAGE, id2:CommonConstant.FACILITY_ID_PRACTICE}, {id1:CommonConstant.FACILITY_ID_MYPAGE, id2:CommonConstant.FACILITY_ID_TRADING}, {id1:CommonConstant.FACILITY_ID_WEARHOUSE, id2:CommonConstant.FACILITY_ID_MYPAGE}, {id1:CommonConstant.FACILITY_ID_WEARHOUSE, id2:CommonConstant.FACILITY_ID_SKILL_INITIATE}, {id1:CommonConstant.FACILITY_ID_WEARHOUSE, id2:CommonConstant.FACILITY_ID_TRAINING_ROOM}, {id1:CommonConstant.FACILITY_ID_WEARHOUSE, id2:CommonConstant.FACILITY_ID_COMMAND_ROOM}, {id1:CommonConstant.FACILITY_ID_WEARHOUSE, id2:CommonConstant.FACILITY_ID_BARRACKS}, {id1:CommonConstant.FACILITY_ID_WEARHOUSE, id2:CommonConstant.FACILITY_ID_SORTIE}, {id1:CommonConstant.FACILITY_ID_WEARHOUSE, id2:CommonConstant.FACILITY_ID_MAKE_EQUIP}, {id1:CommonConstant.FACILITY_ID_WEARHOUSE, id2:CommonConstant.FACILITY_ID_PRACTICE}, {id1:CommonConstant.FACILITY_ID_WEARHOUSE, id2:CommonConstant.FACILITY_ID_TRADING}, {id1:CommonConstant.FACILITY_ID_SKILL_INITIATE, id2:CommonConstant.FACILITY_ID_MYPAGE}, {id1:CommonConstant.FACILITY_ID_SKILL_INITIATE, id2:CommonConstant.FACILITY_ID_MAGIC_DEVELOP}, {id1:CommonConstant.FACILITY_ID_SKILL_INITIATE, id2:CommonConstant.FACILITY_ID_TRAINING_ROOM}, {id1:CommonConstant.FACILITY_ID_SKILL_INITIATE, id2:CommonConstant.FACILITY_ID_COMMAND_ROOM}, {id1:CommonConstant.FACILITY_ID_SKILL_INITIATE, id2:CommonConstant.FACILITY_ID_BARRACKS}, {id1:CommonConstant.FACILITY_ID_SKILL_INITIATE, id2:CommonConstant.FACILITY_ID_SORTIE}, {id1:CommonConstant.FACILITY_ID_SKILL_INITIATE, id2:CommonConstant.FACILITY_ID_MAKE_EQUIP}, {id1:CommonConstant.FACILITY_ID_SKILL_INITIATE, id2:CommonConstant.FACILITY_ID_PRACTICE}, {id1:CommonConstant.FACILITY_ID_MAGIC_DEVELOP, id2:CommonConstant.FACILITY_ID_MYPAGE}, {id1:CommonConstant.FACILITY_ID_MAGIC_DEVELOP, id2:CommonConstant.FACILITY_ID_SKILL_INITIATE}, {id1:CommonConstant.FACILITY_ID_MAGIC_DEVELOP, id2:CommonConstant.FACILITY_ID_TRAINING_ROOM}, {id1:CommonConstant.FACILITY_ID_MAGIC_DEVELOP, id2:CommonConstant.FACILITY_ID_COMMAND_ROOM}, {id1:CommonConstant.FACILITY_ID_MAGIC_DEVELOP, id2:CommonConstant.FACILITY_ID_BARRACKS}, {id1:CommonConstant.FACILITY_ID_MAGIC_DEVELOP, id2:CommonConstant.FACILITY_ID_SORTIE}, {id1:CommonConstant.FACILITY_ID_MAGIC_DEVELOP, id2:CommonConstant.FACILITY_ID_MAKE_EQUIP}, {id1:CommonConstant.FACILITY_ID_MAGIC_DEVELOP, id2:CommonConstant.FACILITY_ID_PRACTICE}, {id1:CommonConstant.FACILITY_ID_TRAINING_ROOM, id2:CommonConstant.FACILITY_ID_MYPAGE}, {id1:CommonConstant.FACILITY_ID_TRAINING_ROOM, id2:CommonConstant.FACILITY_ID_SKILL_INITIATE}, {id1:CommonConstant.FACILITY_ID_TRAINING_ROOM, id2:CommonConstant.FACILITY_ID_MAGIC_DEVELOP}, {id1:CommonConstant.FACILITY_ID_TRAINING_ROOM, id2:CommonConstant.FACILITY_ID_COMMAND_ROOM}, {id1:CommonConstant.FACILITY_ID_TRAINING_ROOM, id2:CommonConstant.FACILITY_ID_SORTIE}, {id1:CommonConstant.FACILITY_ID_TRAINING_ROOM, id2:CommonConstant.FACILITY_ID_MAKE_EQUIP}, {id1:CommonConstant.FACILITY_ID_TRAINING_ROOM, id2:CommonConstant.FACILITY_ID_TRADING}, {id1:CommonConstant.FACILITY_ID_COMMAND_ROOM, id2:CommonConstant.FACILITY_ID_WEARHOUSE}, {id1:CommonConstant.FACILITY_ID_COMMAND_ROOM, id2:CommonConstant.FACILITY_ID_SKILL_INITIATE}, {id1:CommonConstant.FACILITY_ID_COMMAND_ROOM, id2:CommonConstant.FACILITY_ID_MAGIC_DEVELOP}, {id1:CommonConstant.FACILITY_ID_COMMAND_ROOM, id2:CommonConstant.FACILITY_ID_BARRACKS}, {id1:CommonConstant.FACILITY_ID_COMMAND_ROOM, id2:CommonConstant.FACILITY_ID_SORTIE}, {id1:CommonConstant.FACILITY_ID_COMMAND_ROOM, id2:CommonConstant.FACILITY_ID_MAKE_EQUIP}, {id1:CommonConstant.FACILITY_ID_COMMAND_ROOM, id2:CommonConstant.FACILITY_ID_PRACTICE}, {id1:CommonConstant.FACILITY_ID_BARRACKS, id2:CommonConstant.FACILITY_ID_WEARHOUSE}, {id1:CommonConstant.FACILITY_ID_BARRACKS, id2:CommonConstant.FACILITY_ID_SKILL_INITIATE}, {id1:CommonConstant.FACILITY_ID_BARRACKS, id2:CommonConstant.FACILITY_ID_MAGIC_DEVELOP}, {id1:CommonConstant.FACILITY_ID_BARRACKS, id2:CommonConstant.FACILITY_ID_COMMAND_ROOM}, {id1:CommonConstant.FACILITY_ID_BARRACKS, id2:CommonConstant.FACILITY_ID_SORTIE}, {id1:CommonConstant.FACILITY_ID_BARRACKS, id2:CommonConstant.FACILITY_ID_MAKE_EQUIP}, {id1:CommonConstant.FACILITY_ID_BARRACKS, id2:CommonConstant.FACILITY_ID_PRACTICE}, {id1:CommonConstant.FACILITY_ID_BARRACKS, id2:CommonConstant.FACILITY_ID_TRADING}, {id1:CommonConstant.FACILITY_ID_SORTIE, id2:CommonConstant.FACILITY_ID_WEARHOUSE}, {id1:CommonConstant.FACILITY_ID_SORTIE, id2:CommonConstant.FACILITY_ID_SKILL_INITIATE}, {id1:CommonConstant.FACILITY_ID_SORTIE, id2:CommonConstant.FACILITY_ID_MAGIC_DEVELOP}, {id1:CommonConstant.FACILITY_ID_SORTIE, id2:CommonConstant.FACILITY_ID_TRAINING_ROOM}, {id1:CommonConstant.FACILITY_ID_SORTIE, id2:CommonConstant.FACILITY_ID_COMMAND_ROOM}, {id1:CommonConstant.FACILITY_ID_SORTIE, id2:CommonConstant.FACILITY_ID_BARRACKS}, {id1:CommonConstant.FACILITY_ID_SORTIE, id2:CommonConstant.FACILITY_ID_MAKE_EQUIP}, {id1:CommonConstant.FACILITY_ID_SORTIE, id2:CommonConstant.FACILITY_ID_PRACTICE}, {id1:CommonConstant.FACILITY_ID_SORTIE, id2:CommonConstant.FACILITY_ID_TRADING}, {id1:CommonConstant.FACILITY_ID_MAKE_EQUIP, id2:CommonConstant.FACILITY_ID_MYPAGE}, {id1:CommonConstant.FACILITY_ID_MAKE_EQUIP, id2:CommonConstant.FACILITY_ID_WEARHOUSE}, {id1:CommonConstant.FACILITY_ID_MAKE_EQUIP, id2:CommonConstant.FACILITY_ID_SKILL_INITIATE}, {id1:CommonConstant.FACILITY_ID_MAKE_EQUIP, id2:CommonConstant.FACILITY_ID_MAGIC_DEVELOP}, {id1:CommonConstant.FACILITY_ID_MAKE_EQUIP, id2:CommonConstant.FACILITY_ID_TRAINING_ROOM}, {id1:CommonConstant.FACILITY_ID_MAKE_EQUIP, id2:CommonConstant.FACILITY_ID_COMMAND_ROOM}, {id1:CommonConstant.FACILITY_ID_MAKE_EQUIP, id2:CommonConstant.FACILITY_ID_BARRACKS}, {id1:CommonConstant.FACILITY_ID_MAKE_EQUIP, id2:CommonConstant.FACILITY_ID_SORTIE}, {id1:CommonConstant.FACILITY_ID_MAKE_EQUIP, id2:CommonConstant.FACILITY_ID_PRACTICE}, {id1:CommonConstant.FACILITY_ID_PRACTICE, id2:CommonConstant.FACILITY_ID_WEARHOUSE}, {id1:CommonConstant.FACILITY_ID_PRACTICE, id2:CommonConstant.FACILITY_ID_SKILL_INITIATE}, {id1:CommonConstant.FACILITY_ID_PRACTICE, id2:CommonConstant.FACILITY_ID_MAGIC_DEVELOP}, {id1:CommonConstant.FACILITY_ID_PRACTICE, id2:CommonConstant.FACILITY_ID_COMMAND_ROOM}, {id1:CommonConstant.FACILITY_ID_PRACTICE, id2:CommonConstant.FACILITY_ID_BARRACKS}, {id1:CommonConstant.FACILITY_ID_PRACTICE, id2:CommonConstant.FACILITY_ID_SORTIE}, {id1:CommonConstant.FACILITY_ID_PRACTICE, id2:CommonConstant.FACILITY_ID_MAKE_EQUIP}, {id1:CommonConstant.FACILITY_ID_TRADING, id2:CommonConstant.FACILITY_ID_MYPAGE}, {id1:CommonConstant.FACILITY_ID_TRADING, id2:CommonConstant.FACILITY_ID_WEARHOUSE}, {id1:CommonConstant.FACILITY_ID_TRADING, id2:CommonConstant.FACILITY_ID_MAGIC_DEVELOP}, {id1:CommonConstant.FACILITY_ID_TRADING, id2:CommonConstant.FACILITY_ID_TRAINING_ROOM}, {id1:CommonConstant.FACILITY_ID_TRADING, id2:CommonConstant.FACILITY_ID_BARRACKS}, {id1:CommonConstant.FACILITY_ID_TRADING, id2:CommonConstant.FACILITY_ID_SORTIE}, {id1:CommonConstant.FACILITY_ID_TRADING, id2:CommonConstant.FACILITY_ID_PRACTICE}];
            this._aFacilityOffset = [{id:CommonConstant.FACILITY_ID_MYPAGE, pos:new Point(-20, 45)}, {id:CommonConstant.FACILITY_ID_WEARHOUSE, pos:new Point(30, 40)}, {id:CommonConstant.FACILITY_ID_SKILL_INITIATE, pos:new Point(0, 40)}, {id:CommonConstant.FACILITY_ID_MAGIC_DEVELOP, pos:new Point(-8, 50)}, {id:CommonConstant.FACILITY_ID_TRAINING_ROOM, pos:new Point(-6, 50)}, {id:CommonConstant.FACILITY_ID_COMMAND_ROOM, pos:new Point(-10, 40)}, {id:CommonConstant.FACILITY_ID_BARRACKS, pos:new Point(25, 35)}, {id:CommonConstant.FACILITY_ID_SORTIE, pos:new Point(-11, 35)}, {id:CommonConstant.FACILITY_ID_MAKE_EQUIP, pos:new Point(0, 50)}, {id:CommonConstant.FACILITY_ID_PRACTICE, pos:new Point(-10, 45)}, {id:CommonConstant.FACILITY_ID_TRADING, pos:new Point(-10, 40)}];
            this._sprite = new Sprite();
            param1.addChild(this._sprite);
            this._addTime = 0;
            this._stopTime = Random.range(this._CHARACTER_ADD_TIME, 10);
            this._bStop = false;
            this._aFacilityPoint = [];
            this._aHaveFacilityId = [];
            this._aPlayerDisplay = [];
            this._aCharacterId = [];
            this._aCharacterLabelAndTime = [{label:PlayerDisplay.LABEL_SIDE_WALK, time:_CHARACTER_WOLK_TIME}, {label:PlayerDisplay.LABEL_SIDE_DASH, time:_CHARACTER_DASH_TIME}];
            for each (_loc_3 in param2)
            {
                
                _loc_8 = new Point(_loc_3.x - param1.x, _loc_3.y - param1.y);
                this._aFacilityPoint.push(_loc_8);
            }
            _loc_4 = UserDataManager.getInstance().userData.aInstitution;
            for each (_loc_5 in _loc_4)
            {
                
                this._aHaveFacilityId.push(_loc_5.id);
            }
            _loc_6 = UserDataManager.getInstance().userData.aPlayerPersonal;
            if (TutorialManager.getInstance().isBasicTutorial(CommonConstant.USER_STATE_TUTORIAL_3, TutorialManager.BASIC_TUTORIAL_FLAG_WORLD_MAP))
            {
                for each (_loc_7 in _loc_6)
                {
                    
                    if (_loc_7.playerId != CommonConstant.INIT_PLAYER_ID_5)
                    {
                        this._aCharacterId.push(_loc_7.playerId);
                    }
                }
            }
            else
            {
                for each (_loc_7 in _loc_6)
                {
                    
                    this._aCharacterId.push(_loc_7.playerId);
                }
            }
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            this._aFacilityPoint = null;
            this._aCharacterId = null;
            for each (_loc_1 in this._aPlayerDisplay)
            {
                
                _loc_1.release();
            }
            this._aPlayerDisplay = null;
            if (this._sprite && this._sprite.parent != null)
            {
                this._sprite.parent.removeChild(this._sprite);
            }
            this._sprite = null;
            return;
        }// end function

        public function constrol(param1:Number) : void
        {
            var _loc_3:* = null;
            this._addTime = this._addTime + param1;
            var _loc_2:* = this._aPlayerDisplay.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = this._aPlayerDisplay[_loc_2];
                _loc_3.control(param1);
                if (_loc_3.bMoveing == false)
                {
                    _loc_3.release();
                    this._aPlayerDisplay.splice(_loc_2, 1);
                }
                _loc_2 = _loc_2 - 1;
            }
            if (this._stopTime < this._addTime && ResourceManager.getInstance().isLoaded())
            {
                this.createCharacter();
                this._stopTime = Random.range(this._CHARACTER_ADD_TIME, 5);
                this._addTime = 0;
            }
            return;
        }// end function

        public function bStop() : void
        {
            this._bStop = true;
            return;
        }// end function

        private function createCharacter() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            if (this._aCharacterId.length <= 0)
            {
                return;
            }
            if (this._aPlayerDisplay.length < 4 && this._aHaveFacilityId.length > 0)
            {
                _loc_1 = this._aCharacterId.length - 1;
                _loc_2 = Random.range(0, _loc_1);
                this._addCharaId = this._aCharacterId[_loc_2];
                _loc_3 = PlayerManager.getInstance().getPlayerInformation(this._addCharaId);
                ResourceManager.getInstance().loadResource(ResourcePath.PLAYER_PATH + _loc_3.swf, this.cbResourceComple);
            }
            return;
        }// end function

        private function getFacilityOffset(param1:int) : Point
        {
            var _loc_3:* = null;
            var _loc_2:* = new Point();
            for each (_loc_3 in this._aFacilityOffset)
            {
                
                if (_loc_3.id == param1)
                {
                    _loc_2 = _loc_3.pos;
                    break;
                }
            }
            return _loc_2;
        }// end function

        private function cbResourceComple() : void
        {
            var _loc_1:* = 0;
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = false;
            var _loc_14:* = null;
            if (this._bStop == false)
            {
                _loc_1 = 0;
                _loc_2 = this._aMoveFacirityId[Random.range(0, (this._aMoveFacirityId.length - 1))];
                _loc_3 = _loc_2.id1;
                _loc_4 = _loc_2.id2;
                _loc_5 = this.getFacilityOffset(_loc_3);
                _loc_6 = this.getFacilityOffset(_loc_4);
                _loc_7 = this._aFacilityPoint[(_loc_3 - 1)];
                _loc_8 = this._aFacilityPoint[(_loc_4 - 1)];
                _loc_9 = new Point(_loc_7.x + _loc_5.x, _loc_7.y + _loc_5.y);
                _loc_10 = new Point(_loc_8.x + _loc_6.x, _loc_8.y + _loc_6.y);
                _loc_11 = new Point(_loc_7.x - _loc_8.x, _loc_7.y - _loc_8.y);
                if (_loc_11.x < 0)
                {
                    _loc_11.x = _loc_11.x * -1;
                }
                if (_loc_11.y < 0)
                {
                    _loc_11.y = _loc_11.y * -1;
                }
                _loc_12 = this._aCharacterLabelAndTime[_loc_1].label;
                if ((_loc_11.x > _MOVE_LENGHT_X || _loc_11.y > _MOVE_LENGHT_Y) && Random.range(0, 100) < 10)
                {
                    _loc_1 = 1;
                    _loc_12 = this._aCharacterLabelAndTime[_loc_1].label;
                }
                if (_loc_11.x < _loc_11.y)
                {
                    if (this.isCheckFrontBackMotion(_loc_11.x, _loc_11.y))
                    {
                        if (_loc_7.y < _loc_8.y)
                        {
                            _loc_12 = PlayerDisplay.LABEL_FRONT_WALK;
                        }
                        else
                        {
                            _loc_12 = PlayerDisplay.LABEL_BACK_WALK;
                        }
                    }
                }
                _loc_13 = _loc_7.x < _loc_8.x ? (true) : (false);
                _loc_14 = new FacilityMovePlayerDisplay(this._sprite, this._addCharaId, 0);
                _loc_14.pos = _loc_9;
                _loc_14.setTargetPoint(_loc_10, this._aCharacterLabelAndTime[_loc_1].time);
                _loc_14.mc.scaleX = 0.8;
                _loc_14.mc.scaleY = 0.8;
                _loc_14.setReverse(_loc_13);
                _loc_14.setAnimation(_loc_12);
                this._aPlayerDisplay.push(_loc_14);
            }
            return;
        }// end function

        private function isCheckFrontBackMotion(param1:Number, param2:Number) : Boolean
        {
            var _loc_3:* = Math.atan2(param2, param1);
            var _loc_4:* = 90;
            var _loc_5:* = _loc_3 * 180 / Math.PI;
            var _loc_6:* = _loc_3 * 180 / Math.PI - _loc_4;
            _loc_6 = _loc_3 * 180 / Math.PI - _loc_4 - Math.floor(_loc_6 / 360) * 360;
            if (_loc_6 > 180)
            {
                _loc_6 = _loc_6 - 360;
            }
            if (_loc_6 < 0)
            {
                _loc_6 = _loc_6 * -1;
            }
            if (_loc_6 < 20)
            {
                return true;
            }
            return false;
        }// end function

    }
}
