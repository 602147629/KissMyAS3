package battle
{
    import enemy.*;
    import flash.display.*;
    import formation.*;
    import layer.*;
    import player.*;
    import skill.*;
    import sound.*;
    import utility.*;

    public class BattleManager extends Object
    {
        private var _aPlayer:Array;
        private var _commanderPlayer:BattlePlayer;
        private var _deadPlayer:BattlePlayer;
        private var _changedCommanderUniueId:int;
        private var _aEnemy:Array;
        private var _aEnemyMetamorphose:Array;
        private var _aDamage:Array;
        private var _battleScreen:DisplayObjectContainer;
        private static var _battleRandom:Array = [[234, 101, 90, 123, 244, 71, 14, 170, 71, 159, 57, 155, 90, 227, 177, 132], [141, 238, 114, 128, 84, 52, 51, 24, 121, 169, 210, 228, 35, 25, 34, 97], [9, 215, 93, 202, 3, 40, 220, 43, 94, 179, 201, 232, 39, 102, 102, 248], [80, 158, 48, 13, 100, 242, 235, 220, 46, 132, 231, 103, 7, 35, 122, 191], [174, 48, 147, 206, 96, 142, 226, 152, 145, 12, 97, 236, 252, 137, 209, 20], [115, 216, 245, 222, 144, 145, 147, 43, 77, 80, 10, 68, 142, 40, 10, 45], [166, 182, 185, 191, 241, 30, 209, 51, 246, 96, 0, 229, 59, 208, 152, 12], [182, 37, 102, 28, 20, 210, 34, 17, 34, 66, 223, 104, 46, 137, 124, 236], [168, 176, 88, 177, 200, 184, 104, 86, 17, 228, 113, 111, 236, 124, 108, 52], [72, 133, 239, 70, 85, 181, 155, 182, 228, 141, 90, 156, 8, 229, 9, 223], [215, 223, 68, 148, 33, 122, 240, 248, 205, 74, 204, 127, 74, 8, 11, 249], [192, 122, 78, 60, 102, 244, 144, 226, 58, 96, 56, 6, 105, 150, 115, 3], [67, 1, 30, 52, 226, 188, 193, 174, 135, 188, 246, 106, 182, 43, 188, 231], [165, 254, 135, 183, 134, 134, 157, 118, 177, 100, 130, 165, 204, 49, 10, 110], [101, 205, 83, 56, 163, 147, 188, 39, 131, 227, 31, 94, 193, 89, 215, 37], [103, 137, 238, 205, 32, 30, 106, 238, 71, 191, 143, 88, 86, 135, 41, 86]];

        public function BattleManager()
        {
            this._aPlayer = [];
            this._commanderPlayer = null;
            this._deadPlayer = null;
            this._changedCommanderUniueId = Constant.EMPTY_ID;
            this._aEnemy = [];
            this._aEnemyMetamorphose = [];
            this._aDamage = [];
            this._battleScreen = null;
            return;
        }// end function

        public function get aPlayer() : Array
        {
            return this._aPlayer;
        }// end function

        public function get commanderPlayer() : BattlePlayer
        {
            return this._commanderPlayer;
        }// end function

        public function get deadPlayer() : BattlePlayer
        {
            return this._deadPlayer;
        }// end function

        public function get changedCommanderUniueId() : int
        {
            return this._changedCommanderUniueId;
        }// end function

        public function get aEnemy() : Array
        {
            return this._aEnemy;
        }// end function

        public function get aEnemyMetamorphose() : Array
        {
            return this._aEnemyMetamorphose;
        }// end function

        public function get battleScreen() : DisplayObjectContainer
        {
            return this._battleScreen;
        }// end function

        public function setBattleScreen(param1:DisplayObjectContainer) : void
        {
            this._battleScreen = param1;
            return;
        }// end function

        public function release() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            for each (_loc_1 in this._aPlayer)
            {
                
                _loc_1.release();
            }
            this._aPlayer = [];
            if (this._commanderPlayer)
            {
                this._commanderPlayer.release();
            }
            this._commanderPlayer = null;
            if (this._deadPlayer)
            {
                this._deadPlayer.release();
            }
            this._deadPlayer = null;
            for each (_loc_2 in this._aEnemy)
            {
                
                _loc_2.release();
            }
            this._aEnemy = [];
            this._battleScreen = null;
            return;
        }// end function

        public function addPlayer(param1:LayerBattle, param2:PlayerPersonal, param3:int) : BattlePlayer
        {
            var _loc_4:* = new BattlePlayer(param1.getLayer(LayerBattle.CHARACTER), param2, param3);
            new BattlePlayer(param1.getLayer(LayerBattle.CHARACTER), param2, param3).parentDamage = param1.getLayer(LayerBattle.DAMAGE);
            if (param3 == FormationSetData.FORMATION_INDEX_COMMANDER)
            {
                if (this._commanderPlayer)
                {
                    this._commanderPlayer.release();
                }
                this._commanderPlayer = null;
                this._commanderPlayer = _loc_4;
            }
            else
            {
                this._aPlayer.push(_loc_4);
            }
            return _loc_4;
        }// end function

        public function setCommander(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            while (_loc_3 < this._aPlayer.length)
            {
                
                _loc_2 = this._aPlayer[_loc_3];
                if (_loc_2.playerPersonal.uniqueId == param1)
                {
                    if (this._commanderPlayer)
                    {
                        this._aPlayer[_loc_3] = this._commanderPlayer;
                        this._commanderPlayer = _loc_2;
                    }
                    else
                    {
                        this._aPlayer.splice(_loc_3, 1);
                        this._commanderPlayer = _loc_2;
                    }
                    break;
                }
                _loc_3++;
            }
            return;
        }// end function

        public function changeCommander(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            while (_loc_3 < this._aPlayer.length)
            {
                
                _loc_2 = this._aPlayer[_loc_3];
                if (_loc_2.playerPersonal.uniqueId == param1)
                {
                    if (this._commanderPlayer)
                    {
                        this._aPlayer[_loc_3] = this._commanderPlayer;
                        this._changedCommanderUniueId = this._commanderPlayer.playerPersonal.uniqueId;
                        this._commanderPlayer = null;
                    }
                    else
                    {
                        this._aPlayer.splice(_loc_3, 1);
                        this._changedCommanderUniueId = Constant.EMPTY_ID;
                    }
                    this._deadPlayer = _loc_2;
                    break;
                }
                _loc_3++;
            }
            return;
        }// end function

        public function addEnemy(param1:LayerBattle, param2:EnemyPersonal, param3:int, param4:int, param5:Array) : void
        {
            var _loc_6:* = null;
            switch(param2.infoId)
            {
                case EnemyId.id_mons_Destryer_1st_RS3:
                {
                    _loc_6 = new BattleEnemyDestroyer(param1.getLayer(LayerBattle.CHARACTER), param2, param3, param5);
                    this.aEnemyMetamorphose.push(_loc_6);
                    break;
                }
                case EnemyId.id_mons_SevenHeroes_First_RS2:
                {
                    _loc_6 = new BattleEnemySevenHeroes(param1.getLayer(LayerBattle.CHARACTER), param2, param3, param5);
                    this.aEnemyMetamorphose.push(_loc_6);
                    break;
                }
                case EnemyId.id_mons_VagaDara_Sword_IS:
                {
                    _loc_6 = new BattleEnemyVagaDara(param1.getLayer(LayerBattle.CHARACTER), param2, param3, param5);
                    this.aEnemyMetamorphose.push(_loc_6);
                    break;
                }
                default:
                {
                    _loc_6 = new BattleEnemy(param1.getLayer(LayerBattle.CHARACTER), param2, param3);
                    break;
                    break;
                }
            }
            _loc_6.parentDamage = param1.getLayer(LayerBattle.DAMAGE);
            _loc_6.setUserSkill(param4);
            this._aEnemy.push(_loc_6);
            return;
        }// end function

        public function createDamageHp(param1:int, param2:int, param3:int, param4:int, param5:Boolean = false, param6:Boolean = false, param7:Boolean = false, param8:Boolean = false, param9:Boolean = false) : void
        {
            var _loc_10:* = new DamageData(param1, param2, param3, DamageData.TYPE_HP);
            new DamageData(param1, param2, param3, DamageData.TYPE_HP).hitType = param4;
            _loc_10.bDeadDisable = param5;
            _loc_10.bCounter = param6;
            _loc_10.bBigDisp = param7;
            _loc_10.bSkip = param8;
            _loc_10.bAllyEffect = param9;
            this._aDamage.push(_loc_10);
            return;
        }// end function

        public function createRecoveryHp(param1:int, param2:int, param3:int) : void
        {
            var _loc_4:* = new DamageData(param1, param2, param3, DamageData.TYPE_RECOVERY_HP);
            this._aDamage.push(_loc_4);
            return;
        }// end function

        public function createDamageLp(param1:int, param2:int, param3:int = 1, param4:Boolean = false) : void
        {
            var _loc_5:* = new DamageData(param1, param2, param3, DamageData.TYPE_LP);
            new DamageData(param1, param2, param3, DamageData.TYPE_LP).bBrokenItem = param4;
            this._aDamage.push(_loc_5);
            return;
        }// end function

        public function createDamageBadStatus(param1:int, param2:int, param3:BattleBadStatus, param4:Boolean = false) : void
        {
            var _loc_5:* = new DamageData(param1, param2, 0, DamageData.TYPE_BAD_STATUS);
            new DamageData(param1, param2, 0, DamageData.TYPE_BAD_STATUS).addBadStatus = param3.clone();
            _loc_5.bBrokenItem = param4;
            this._aDamage.push(_loc_5);
            return;
        }// end function

        public function createDamageBadStatusRecovery(param1:int, param2:int, param3:BattleRecoveryBadStatus) : void
        {
            var _loc_4:* = new DamageData(param1, param2, 0, DamageData.TYPE_BAD_STATUS_RECOVERY);
            new DamageData(param1, param2, 0, DamageData.TYPE_BAD_STATUS_RECOVERY).recoveryBadStatus = param3.clone();
            this._aDamage.push(_loc_4);
            return;
        }// end function

        public function createDamageBadStatusResist(param1:int, param2:int) : void
        {
            var _loc_3:* = new DamageData(param1, param2, 0, DamageData.TYPE_BAD_STATUS_RESIST);
            this._aDamage.push(_loc_3);
            return;
        }// end function

        public function playDamage(param1:int, param2:Function) : void
        {
            var aDmgHp:Array;
            var aDmgLp:Array;
            var aDmgBadStatusResist:Array;
            var aDmgBadStatus:Array;
            var aDmgBadStatusRecovery:Array;
            var aDmgRecoveryHp:Array;
            var i:int;
            var dmgHp:DamageData;
            var dmgLp:DamageData;
            var dmgBadStatusResist:DamageData;
            var aTempDamage:Array;
            var dmgBadStatus:DamageData;
            var badStatusDamage:DamageData;
            var dmgBadStatusRecovery:DamageData;
            var dmgRecoveryHp:DamageData;
            var dmg:DamageData;
            var resist:DamageData;
            var aBadStatusData:Array;
            var ii:int;
            var badStatusData:BattleBadStatusData;
            var temp:DamageData;
            var questUniqueId:* = param1;
            var cbDamageHp:* = param2;
            var chr:* = this.getCharacter(questUniqueId);
            if (chr != null)
            {
                aDmgHp;
                aDmgLp;
                aDmgBadStatusResist;
                aDmgBadStatus;
                aDmgBadStatusRecovery;
                aDmgRecoveryHp;
                i = (this._aDamage.length - 1);
                while (i >= 0)
                {
                    
                    dmg = this._aDamage[i];
                    if (dmg.questUniqueId != questUniqueId)
                    {
                    }
                    else
                    {
                        if (dmg.type == DamageData.TYPE_HP)
                        {
                            aDmgHp.push(dmg);
                        }
                        if (dmg.type == DamageData.TYPE_LP)
                        {
                            aDmgLp.push(dmg);
                        }
                        if (dmg.type == DamageData.TYPE_BAD_STATUS_RESIST)
                        {
                            aDmgBadStatusResist.push(dmg);
                        }
                        if (dmg.type == DamageData.TYPE_BAD_STATUS)
                        {
                            aDmgBadStatus.push(dmg);
                        }
                        if (dmg.type == DamageData.TYPE_BAD_STATUS_RECOVERY)
                        {
                            aDmgBadStatusRecovery.push(dmg);
                        }
                        if (dmg.type == DamageData.TYPE_RECOVERY_HP)
                        {
                            aDmgRecoveryHp.push(dmg);
                        }
                        this._aDamage.splice(i, 1);
                    }
                    i = (i - 1);
                }
                var _loc_4:* = 0;
                var _loc_5:* = aDmgHp;
                while (_loc_5 in _loc_4)
                {
                    
                    dmgHp = _loc_5[_loc_4];
                    chr.addDaamgeHp(dmgHp);
                    chr.personal.damageHp(dmgHp.damage);
                    if (dmgHp.bDeadDisable)
                    {
                        chr.setDeadDisable();
                    }
                    if (cbDamageHp != null && dmg.bAllyEffect == false)
                    {
                        this.cbDamageHp(dmgHp);
                    }
                    if (dmgHp.bCounter)
                    {
                        chr.setCbCounterHit(function () : void
            {
                playDamage(dmgHp.attacerQuestUniqueId, cbDamageHp);
                return;
            }// end function
            );
                    }
                }
                var _loc_4:* = 0;
                var _loc_5:* = aDmgLp;
                while (_loc_5 in _loc_4)
                {
                    
                    dmgLp = _loc_5[_loc_4];
                    chr.addDamageLp(dmgLp);
                    if (chr.personal is PlayerPersonal)
                    {
                        if (!dmgLp.bBrokenItem)
                        {
                            (chr.personal as PlayerPersonal).damageLp(dmgLp.damage);
                        }
                        if (chr.personal.bDead)
                        {
                            chr.setUseDeadEffect();
                            if (dmgLp.bBrokenItem)
                            {
                                chr.setBrokenItem();
                            }
                        }
                    }
                }
                var _loc_4:* = 0;
                var _loc_5:* = aDmgBadStatusResist;
                while (_loc_5 in _loc_4)
                {
                    
                    dmgBadStatusResist = _loc_5[_loc_4];
                    resist = new DamageData(dmgBadStatusResist.questUniqueId, dmgBadStatusResist.attacerQuestUniqueId, dmgBadStatusResist.damage, dmgBadStatusResist.type);
                    chr.addDamageBadStatus(resist);
                }
                aTempDamage;
                var _loc_4:* = 0;
                var _loc_5:* = aDmgBadStatus;
                while (_loc_5 in _loc_4)
                {
                    
                    dmgBadStatus = _loc_5[_loc_4];
                    aBadStatusData = dmgBadStatus.addBadStatus.aBadStatusData;
                    ii;
                    while (ii < aBadStatusData.length)
                    {
                        
                        badStatusData = aBadStatusData[ii];
                        if (DamageUtility.isBadStatusDisplay(badStatusData.id) == false)
                        {
                        }
                        else if (chr.status.badStatus.conflictCheck(badStatusData.id))
                        {
                        }
                        else
                        {
                            temp = new DamageData(dmgBadStatus.questUniqueId, dmgBadStatus.attacerQuestUniqueId, dmgBadStatus.damage, dmgBadStatus.type);
                            temp.dispStatusId = badStatusData.id;
                            if (temp.dispStatusId == BattleConstant.BAD_STATUS_ID_INSTANT_DEATH)
                            {
                                chr.addDamageBadStatus(temp);
                            }
                            else
                            {
                                aTempDamage.push(temp);
                            }
                        }
                        ii = (ii + 1);
                    }
                    chr.status.badStatusAdd(dmgBadStatus.addBadStatus);
                    if (BattleManager.isBadStatusInstantDeath(dmgBadStatus.addBadStatus))
                    {
                        chr.personal.setDeath();
                        chr.setUseDeadEffect();
                        if (dmgBadStatus.bBrokenItem)
                        {
                            chr.setBrokenItem();
                        }
                    }
                }
                var _loc_4:* = 0;
                var _loc_5:* = aTempDamage;
                while (_loc_5 in _loc_4)
                {
                    
                    badStatusDamage = _loc_5[_loc_4];
                    chr.addDamageBadStatus(badStatusDamage);
                }
                var _loc_4:* = 0;
                var _loc_5:* = aDmgBadStatusRecovery;
                while (_loc_5 in _loc_4)
                {
                    
                    dmgBadStatusRecovery = _loc_5[_loc_4];
                    chr.status.badStatusRecovery(dmgBadStatusRecovery.recoveryBadStatus);
                }
                var _loc_4:* = 0;
                var _loc_5:* = aDmgRecoveryHp;
                while (_loc_5 in _loc_4)
                {
                    
                    dmgRecoveryHp = _loc_5[_loc_4];
                    if (chr.personal is EnemyPersonal)
                    {
                        chr.addRecoveryHp(dmgRecoveryHp);
                        (chr.personal as EnemyPersonal).recoveryHp(dmgRecoveryHp.damage);
                    }
                }
            }
            return;
        }// end function

        public function getDamageData() : Array
        {
            return this._aDamage.concat();
        }// end function

        public function isRemainingDamage(param1:int) : Boolean
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_2:* = this.getCharacter(param1);
            if (_loc_2 != null)
            {
                _loc_3 = this._aDamage.length - 1;
                while (_loc_3 >= 0)
                {
                    
                    _loc_4 = this._aDamage[_loc_3];
                    if (_loc_4.questUniqueId == param1)
                    {
                        return true;
                    }
                    _loc_3 = _loc_3 - 1;
                }
            }
            return false;
        }// end function

        public function getCharacter(param1:int) : BattleCharacterBase
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            for each (_loc_2 in this._aPlayer)
            {
                
                if (_loc_2.personal.questUniqueId == param1)
                {
                    return _loc_2;
                }
            }
            if (this._commanderPlayer)
            {
                if (this._commanderPlayer.personal.questUniqueId == param1)
                {
                    return this._commanderPlayer;
                }
            }
            if (this._deadPlayer)
            {
                if (this._deadPlayer.personal.questUniqueId == param1)
                {
                    return this._deadPlayer;
                }
            }
            for each (_loc_3 in this._aEnemy)
            {
                
                if (_loc_3.personal.questUniqueId == param1)
                {
                    return _loc_3;
                }
            }
            return null;
        }// end function

        public function getEntryPlayer() : Array
        {
            return this._aPlayer.concat();
        }// end function

        public function getEntryPlayerAll() : Array
        {
            var _loc_1:* = this._aPlayer.concat();
            if (this._commanderPlayer)
            {
                _loc_1.push(this._commanderPlayer);
            }
            if (this._deadPlayer)
            {
                _loc_1.push(this._deadPlayer);
            }
            return _loc_1;
        }// end function

        public function getEntryEnemy() : Array
        {
            return this._aEnemy.concat();
        }// end function

        public function getEntryEnemyMetamorphose() : Array
        {
            return this._aEnemyMetamorphose.concat();
        }// end function

        public function getEntryCharacter() : Array
        {
            var _loc_1:* = [];
            _loc_1 = _loc_1.concat(this._aPlayer);
            _loc_1 = _loc_1.concat(this._aEnemy);
            return _loc_1;
        }// end function

        public function getFormationPlayerQuestUniqueId(param1:FormationSetData) : Array
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_2:* = [];
            for each (_loc_3 in param1.aPlayerUniqueId)
            {
                
                for each (_loc_4 in this._aPlayer)
                {
                    
                    if (_loc_3 == _loc_4.playerPersonal.uniqueId)
                    {
                        _loc_2.push(_loc_4.playerPersonal.questUniqueId);
                        break;
                    }
                }
            }
            return _loc_2;
        }// end function

        public function getPartnerCharacterId(param1:int) : Array
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = [];
            for each (_loc_3 in this.getEntryPlayerAll())
            {
                
                if (_loc_3.personal.questUniqueId == param1 || _loc_3.personal.bDead)
                {
                    continue;
                }
                _loc_4 = PlayerManager.getInstance().getPlayerInformation(_loc_3.playerPersonal.playerId);
                _loc_2.push(_loc_4.characterId);
            }
            return _loc_2;
        }// end function

        public static function getRandomParam() : int
        {
            var _loc_1:* = Random.range(0, (_battleRandom[0].length - 1));
            var _loc_2:* = Random.range(0, (_battleRandom.length - 1));
            return _battleRandom[_loc_2][_loc_1];
        }// end function

        public static function getDefaultSkillId(param1:PlayerInformation) : int
        {
            var _loc_2:* = Constant.EMPTY_ID;
            _loc_2 = param1.normalSkillId;
            if (_loc_2 == Constant.EMPTY_ID)
            {
                switch(param1.weaponType)
                {
                    case CommonConstant.CHARACTER_WEAPONTYPE_SWORD:
                    {
                        _loc_2 = SkillId.ATTACK_SWORD;
                        break;
                    }
                    case CommonConstant.CHARACTER_WEAPONTYPE_SPEAR:
                    {
                        _loc_2 = SkillId.ATTACK_SPEAR;
                        break;
                    }
                    case CommonConstant.CHARACTER_WEAPONTYPE_AX:
                    {
                        _loc_2 = SkillId.ATTACK_AXE;
                        break;
                    }
                    case CommonConstant.CHARACTER_WEAPONTYPE_SHORTSWORD:
                    {
                        _loc_2 = SkillId.ATTACK_SMALL_SWORD;
                        break;
                    }
                    case CommonConstant.CHARACTER_WEAPONTYPE_BOW:
                    {
                        _loc_2 = SkillId.ATTACK_BOW;
                        break;
                    }
                    case CommonConstant.CHARACTER_WEAPONTYPE_CLUB:
                    {
                        _loc_2 = SkillId.ATTACK_CLUB;
                        break;
                    }
                    case CommonConstant.CHARACTER_WEAPONTYPE_MATERIALARTS:
                    {
                        _loc_2 = SkillId.ATTACK_PUNCH_LEFT;
                        break;
                    }
                    case CommonConstant.CHARACTER_WEAPONTYPE_GREATSWORD:
                    {
                        _loc_2 = SkillId.ATTACK_LARGE_SWORD;
                        break;
                    }
                    default:
                    {
                        _loc_2 = SkillId.ATTACK_SWORD;
                        break;
                        break;
                    }
                }
            }
            return _loc_2;
        }// end function

        public static function isDefaultSkill(param1:BattleCharacterBase, param2:SkillInformation) : Boolean
        {
            var _loc_3:* = 0;
            if (param2.rank == 0)
            {
                return true;
            }
            if (param1 as BattlePlayer)
            {
                _loc_3 = param2.id;
                if (_loc_3 != Constant.EMPTY_ID && _loc_3 == (param1 as BattlePlayer).defaultSkillId)
                {
                    return true;
                }
            }
            return false;
        }// end function

        public static function isBadStatusPoison(param1:BattleBadStatus) : Boolean
        {
            return param1.isBadStatus(BattleConstant.BAD_STATUS_ID_POISON);
        }// end function

        public static function isRecoveryBadStatusPoison(param1:BattleRecoveryBadStatus) : Boolean
        {
            return param1.isStatus(BattleConstant.BAD_STATUS_ID_POISON);
        }// end function

        public static function isBadStatusParalysis(param1:BattleBadStatus) : Boolean
        {
            return param1.isBadStatus(BattleConstant.BAD_STATUS_ID_PARALYSIS);
        }// end function

        public static function isRecoveryBadStatusParalysis(param1:BattleRecoveryBadStatus) : Boolean
        {
            return param1.isStatus(BattleConstant.BAD_STATUS_ID_PARALYSIS);
        }// end function

        public static function isBadStatusDarkness(param1:BattleBadStatus) : Boolean
        {
            return param1.isBadStatus(BattleConstant.BAD_STATUS_ID_DARKNESS);
        }// end function

        public static function isRecoveryBadStatusDarkness(param1:BattleRecoveryBadStatus) : Boolean
        {
            return param1.isStatus(BattleConstant.BAD_STATUS_ID_DARKNESS);
        }// end function

        public static function isBadStatusSleep(param1:BattleBadStatus) : Boolean
        {
            return param1.isBadStatus(BattleConstant.BAD_STATUS_ID_SLEEP);
        }// end function

        public static function isRecoveryBadStatusSleep(param1:BattleRecoveryBadStatus) : Boolean
        {
            return param1.isStatus(BattleConstant.BAD_STATUS_ID_SLEEP);
        }// end function

        public static function isBadStatusConfusion(param1:BattleBadStatus) : Boolean
        {
            return param1.isBadStatus(BattleConstant.BAD_STATUS_ID_CONFUSION);
        }// end function

        public static function isRecoveryBadStatusConfusion(param1:BattleRecoveryBadStatus) : Boolean
        {
            return param1.isStatus(BattleConstant.BAD_STATUS_ID_CONFUSION);
        }// end function

        public static function isBadStatusStan(param1:BattleBadStatus) : Boolean
        {
            return param1.isBadStatus(BattleConstant.BAD_STATUS_ID_STAN);
        }// end function

        public static function isRecoveryBadStatusStan(param1:BattleRecoveryBadStatus) : Boolean
        {
            return param1.isStatus(BattleConstant.BAD_STATUS_ID_STAN);
        }// end function

        public static function isBadStatusCharm(param1:BattleBadStatus) : Boolean
        {
            return param1.isBadStatus(BattleConstant.BAD_STATUS_ID_CHARM);
        }// end function

        public static function isRecoveryBadStatusCharm(param1:BattleRecoveryBadStatus) : Boolean
        {
            return param1.isStatus(BattleConstant.BAD_STATUS_ID_CHARM);
        }// end function

        public static function isBadStatusInstantDeath(param1:BattleBadStatus) : Boolean
        {
            return param1.isBadStatus(BattleConstant.BAD_STATUS_ID_INSTANT_DEATH);
        }// end function

        public static function isRecoveryBadStatusInstantDeath(param1:BattleRecoveryBadStatus) : Boolean
        {
            return param1.isStatus(BattleConstant.BAD_STATUS_ID_INSTANT_DEATH);
        }// end function

        public static function isBadStatusStone(param1:BattleBadStatus) : Boolean
        {
            return param1.isBadStatus(BattleConstant.BAD_STATUS_ID_STONE);
        }// end function

        public static function isRecoveryBadStatusStone(param1:BattleRecoveryBadStatus) : Boolean
        {
            return param1.isStatus(BattleConstant.BAD_STATUS_ID_STONE);
        }// end function

        public static function isBadStatusAttackDown(param1:BattleBadStatus) : Boolean
        {
            return param1.isBadStatus(BattleConstant.BAD_STATUS_ID_ATTACK_DOWN);
        }// end function

        public static function isBadStatusAttackUp(param1:BattleBadStatus) : Boolean
        {
            return param1.isBadStatus(BattleConstant.BAD_STATUS_ID_ATTACK_UP);
        }// end function

        public static function isBadStatusDefenceDown(param1:BattleBadStatus) : Boolean
        {
            return param1.isBadStatus(BattleConstant.BAD_STATUS_ID_DEFENSE_DOWN);
        }// end function

        public static function isBadStatusDefenceUp(param1:BattleBadStatus) : Boolean
        {
            return param1.isBadStatus(BattleConstant.BAD_STATUS_ID_DEFENSE_UP);
        }// end function

        public static function isBadStatusSpeedDown(param1:BattleBadStatus) : Boolean
        {
            return param1.isBadStatus(BattleConstant.BAD_STATUS_ID_SPEED_DOWN);
        }// end function

        public static function isBadStatusSpeedUp(param1:BattleBadStatus) : Boolean
        {
            return param1.isBadStatus(BattleConstant.BAD_STATUS_ID_SPEED_UP);
        }// end function

        public static function isBadStatusMagicDown(param1:BattleBadStatus) : Boolean
        {
            return param1.isBadStatus(BattleConstant.BAD_STATUS_ID_MAGIC_DOWN);
        }// end function

        public static function isBadStatusMagicUp(param1:BattleBadStatus) : Boolean
        {
            return param1.isBadStatus(BattleConstant.BAD_STATUS_ID_MAGIC_UP);
        }// end function

        public static function isSelectNoBe(param1:BattleCharacterStatus) : Boolean
        {
            if (isActionNotBe(param1.badStatus))
            {
                return true;
            }
            if (isBadStatusCharm(param1.badStatus))
            {
                return true;
            }
            if (isBadStatusConfusion(param1.badStatus))
            {
                return true;
            }
            return false;
        }// end function

        public static function isActionNotBe(param1:BattleBadStatus) : Boolean
        {
            if (isBadStatusParalysis(param1))
            {
                return true;
            }
            if (isBadStatusStan(param1))
            {
                return true;
            }
            if (isBadStatusSleep(param1))
            {
                return true;
            }
            if (isBadStatusStone(param1))
            {
                return true;
            }
            return false;
        }// end function

        public static function isShieldNoBe(param1:BattleBadStatus) : Boolean
        {
            if (isBadStatusParalysis(param1))
            {
                return true;
            }
            if (isBadStatusStan(param1))
            {
                return true;
            }
            if (isBadStatusInstantDeath(param1))
            {
                return true;
            }
            if (isBadStatusSleep(param1))
            {
                return true;
            }
            if (isBadStatusStone(param1))
            {
                return true;
            }
            return false;
        }// end function

        public static function isShieldTurnNoBe(param1:BattleRecoveryBadStatus) : Boolean
        {
            if (isRecoveryBadStatusParalysis(param1))
            {
                return true;
            }
            if (isRecoveryBadStatusStan(param1))
            {
                return true;
            }
            if (isRecoveryBadStatusInstantDeath(param1))
            {
                return true;
            }
            if (isRecoveryBadStatusSleep(param1))
            {
                return true;
            }
            if (isRecoveryBadStatusStone(param1))
            {
                return true;
            }
            return false;
        }// end function

        public static function canCounterStatus(param1:BattleBadStatus, param2:BattleRecoveryBadStatus) : Boolean
        {
            if (isBadStatusParalysis(param1) || isRecoveryBadStatusParalysis(param2))
            {
                return false;
            }
            if (isBadStatusStan(param1) || isRecoveryBadStatusStan(param2))
            {
                return false;
            }
            if (isBadStatusInstantDeath(param1) || isRecoveryBadStatusInstantDeath(param2))
            {
                return false;
            }
            if (isBadStatusSleep(param1) || isRecoveryBadStatusSleep(param2))
            {
                return false;
            }
            if (isBadStatusStone(param1) || isRecoveryBadStatusStone(param2))
            {
                return false;
            }
            if (!isBadStatusCharm(param1) && isRecoveryBadStatusCharm(param2))
            {
                return false;
            }
            if (!isBadStatusConfusion(param1) && isRecoveryBadStatusConfusion(param2))
            {
                return false;
            }
            return true;
        }// end function

        public static function getFeverBgmId(param1:int) : int
        {
            var _loc_2:* = SoundId.BGM_BATTLE_ARMYATTACK_CMN;
            switch(param1)
            {
                case CommonConstant.SERIES_RS1:
                {
                    _loc_2 = SoundId.BGM_BATTLE_ARMYATTACK_RS1;
                    break;
                }
                case CommonConstant.SERIES_RS2:
                {
                    _loc_2 = SoundId.BGM_BATTLE_ARMYATTACK_RS2;
                    break;
                }
                case CommonConstant.SERIES_RS3:
                {
                    _loc_2 = SoundId.BGM_BATTLE_ARMYATTACK_RS3;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return _loc_2;
        }// end function

        public static function getComboGrade(param1:int) : int
        {
            var _loc_2:* = BattleConstant.COMBO_GRADE0;
            if (param1 == 2)
            {
                _loc_2 = BattleConstant.COMBO_GRADE1;
            }
            if (param1 >= 3 && param1 <= 5)
            {
                _loc_2 = BattleConstant.COMBO_GRADE2;
            }
            if (param1 >= 6 && param1 <= 7)
            {
                _loc_2 = BattleConstant.COMBO_GRADE3;
            }
            if (param1 >= 8 && param1 <= 9)
            {
                _loc_2 = BattleConstant.COMBO_GRADE4;
            }
            if (param1 >= 10)
            {
                _loc_2 = BattleConstant.COMBO_GRADE5;
            }
            return _loc_2;
        }// end function

    }
}
