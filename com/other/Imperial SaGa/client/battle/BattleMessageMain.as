package battle
{
    import enemy.*;
    import flash.display.*;
    import flash.geom.*;
    import formation.*;
    import player.*;

    public class BattleMessageMain extends Object
    {
        private var _mcMessageTop:MovieClip;
        private var _battleManager:BattleManager;
        private var _battleCharaParent:DisplayObjectContainer;
        private var _formationData:FormationData;
        private var _formationDataEnemy:FormationDataEnemy;
        private var _aName:Array;
        private var _messageTop:BattleMessageTop;
        private var _aMessageCharacter:Array;

        public function BattleMessageMain(param1:MovieClip, param2:DisplayObjectContainer, param3:BattleManager, param4:FormationData, param5:FormationDataEnemy)
        {
            this._battleCharaParent = param2;
            this._battleManager = param3;
            this._formationData = param4;
            this._formationDataEnemy = param5;
            this._mcMessageTop = param1;
            this._messageTop = null;
            this._aMessageCharacter = [];
            this._aName = [];
            return;
        }// end function

        public function get aMessageCharacter() : Array
        {
            return this._aMessageCharacter;
        }// end function

        public function get bMessageCharacterDisp() : Boolean
        {
            return this._aMessageCharacter.length > 0;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            if (this._messageTop)
            {
                this._messageTop.release();
            }
            this._messageTop = null;
            for each (_loc_1 in this._aMessageCharacter)
            {
                
                _loc_1.release();
            }
            this._aMessageCharacter = null;
            for each (_loc_2 in this._aName)
            {
                
                _loc_2.release();
            }
            this._aName = null;
            this._mcMessageTop = null;
            this._battleManager = null;
            this._battleCharaParent = null;
            return;
        }// end function

        public function control(param1:Number) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = this._aMessageCharacter.length - 1;
            while (_loc_2 >= 0)
            {
                
                _loc_3 = this._aMessageCharacter[_loc_2];
                _loc_3.control(param1);
                if (_loc_3.bEnd)
                {
                    this._aMessageCharacter.splice(_loc_2, 1);
                }
                _loc_2 = _loc_2 - 1;
            }
            return;
        }// end function

        public function setMessageTop(param1:String) : void
        {
            if (this._messageTop != null)
            {
                this._messageTop.setClose();
            }
            this._messageTop = new BattleMessageTop(this._mcMessageTop, param1);
            return;
        }// end function

        public function setMessageTopClose() : void
        {
            if (this._messageTop != null)
            {
                this._messageTop.setClose();
            }
            this._messageTop = null;
            return;
        }// end function

        public function addMessageCharacter(param1:uint, param2:String) : BattleMessageCharacter
        {
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_3:* = this._battleManager.getCharacter(param1);
            var _loc_4:* = this._aMessageCharacter.length - 1;
            while (_loc_4 >= 0)
            {
                
                _loc_8 = this._aMessageCharacter[_loc_4];
                if (_loc_8.questUniqueId == param1)
                {
                    _loc_8.setClose();
                    this._aMessageCharacter.splice(_loc_4, 1);
                }
                _loc_4 = _loc_4 - 1;
            }
            var _loc_5:* = false;
            var _loc_6:* = new Point();
            if (_loc_3.division == BattleConstant.DIVISION_PLAYER)
            {
                _loc_6 = _loc_6.add(new Point(0, -50));
                _loc_6 = _loc_6.add(this._formationData.getPosition(_loc_3.formationIndex));
            }
            if (_loc_3.division == BattleConstant.DIVISION_ENEMY)
            {
                _loc_9 = _loc_3.characterAction.characterDisplay as EnemyDisplay;
                if (_loc_9.mc.skillNameNull != null)
                {
                    _loc_6.x = _loc_9.mc.skillNameNull.x;
                    _loc_6.y = _loc_9.mc.skillNameNull.y;
                }
                else
                {
                    _loc_6 = _loc_6.add(new Point(_loc_9.faceNull.x + 25, _loc_9.faceNull.y));
                }
                _loc_6 = _loc_6.add(this._formationDataEnemy.getPosition(_loc_3.formationIndex));
                _loc_5 = true;
            }
            var _loc_7:* = new BattleMessageCharacter(this._battleCharaParent, _loc_6, param1, param2);
            if (_loc_5)
            {
                _loc_7.setEnemySide();
            }
            this._aMessageCharacter.push(_loc_7);
            return _loc_7;
        }// end function

        public function setMessageCharacterClose() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aMessageCharacter)
            {
                
                _loc_1.setClose();
            }
            this._aMessageCharacter = [];
            return;
        }// end function

        public function addCharacterName(param1:uint) : void
        {
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_2:* = this._battleManager.getCharacter(param1);
            var _loc_3:* = false;
            var _loc_4:* = "";
            var _loc_5:* = new Point();
            if (_loc_2.division == BattleConstant.DIVISION_PLAYER)
            {
                _loc_7 = _loc_2.characterAction.characterDisplay as PlayerDisplay;
                _loc_4 = _loc_7.info.name;
                _loc_5 = _loc_5.add(new Point(0, -40));
                _loc_5 = _loc_5.add(this._formationData.getPosition(_loc_2.formationIndex));
            }
            if (_loc_2.division == BattleConstant.DIVISION_ENEMY)
            {
                _loc_8 = _loc_2.characterAction.characterDisplay as EnemyDisplay;
                _loc_4 = _loc_8.info.name;
                if (_loc_8.mc.nameNull != null)
                {
                    _loc_5.x = _loc_8.mc.nameNull.x;
                    _loc_5.y = _loc_8.mc.nameNull.y;
                }
                _loc_5 = _loc_5.add(this._formationDataEnemy.getPosition(_loc_2.formationIndex));
                _loc_3 = true;
            }
            var _loc_6:* = new BattleCharacterName(this._battleCharaParent, _loc_4, _loc_5);
            this._aName.push(_loc_6);
            return;
        }// end function

        public function clearCharacterName() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this._aName)
            {
                
                _loc_1.release();
            }
            this._aName = [];
            return;
        }// end function

    }
}
