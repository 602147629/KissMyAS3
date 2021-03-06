﻿package lovefox.socket
{

    public class OBJECT_UPDATE_TYPE_ENUM extends Object
    {
        public static var OBJECT_END:Object = 4;
        public static var TYPEID_LEVEL:Object = OBJECT_END;
        public static var TYPEID_HP:Object = OBJECT_END + 1;
        public static var TYPEID_HP_MAX:Object = OBJECT_END + 2;
        public static var TYPEID_MP:Object = OBJECT_END + 3;
        public static var TYPEID_MP_MAX:Object = OBJECT_END + 4;
        public static var TYPEID_ATK_SPEED:Object = OBJECT_END + 6;
        public static var TYPEID_ATK_RANGE:Object = OBJECT_END + 7;
        public static var TYPEID_MOVE_SPEED:Object = OBJECT_END + 8;
        public static var TYPEID_ATK_SPEED_LEVEL:Object = OBJECT_END + 9;
        public static var TYPEID_ATK:Object = OBJECT_END + 11;
        public static var TYPEID_DEF:Object = OBJECT_END + 12;
        public static var TYPEID_ATK_RANGED:Object = OBJECT_END + 13;
        public static var TYPEID_DEF_RANGED:Object = OBJECT_END + 14;
        public static var TYPEID_MATK:Object = OBJECT_END + 15;
        public static var TYPEID_MDEF:Object = OBJECT_END + 16;
        public static var TYPEID_UNIT_FIELD_ATK_ADD:Object = OBJECT_END + 17;
        public static var TYPEID_UNIT_FIELD_DEF_ADD:Object = OBJECT_END + 18;
        public static var TYPEID_ATK_ADD:Object = OBJECT_END + 19;
        public static var TYPEID_DEF_ADD:Object = OBJECT_END + 20;
        public static var TYPEID_ATKRANGE_ADD:Object = OBJECT_END + 21;
        public static var TYPEID_DEFRANGE_ADD:Object = OBJECT_END + 22;
        public static var TYPEID_ATKMAGIC_ADD:Object = OBJECT_END + 23;
        public static var TYPEID_DEFMAGIC_ADD:Object = OBJECT_END + 24;
        public static var TYPEID_RATE:Object = OBJECT_END + 37;
        public static var TYPEID_DODGE:Object = OBJECT_END + 38;
        public static var TYPEID_RATE_SKILL:Object = OBJECT_END + 39;
        public static var TYPEID_DODGE_SKILL:Object = OBJECT_END + 40;
        public static var TYPEID_CRITICAL_PROB:Object = OBJECT_END + 41;
        public static var TYPEID_CRITICAL_VALUE:Object = OBJECT_END + 42;
        public static var TYPEID_CRITICAL_RESIST:Object = OBJECT_END + 43;
        public static var TYPEID_CRITICAL_DODGE:Object = OBJECT_END + 44;
        public static var TYPEID_CRITICAL_PROB_MAGIC:Object = OBJECT_END + 45;
        public static var TYPEID_CRITICAL_VALUE_MAGIC:Object = OBJECT_END + 46;
        public static var TYPEID_CRITICAL_RESIST_MAGIC:Object = OBJECT_END + 47;
        public static var TYPEID_CRITICAL_DODGE_MAGIC:Object = OBJECT_END + 48;
        public static var TYPEID_CRITICAL_ADD:Object = OBJECT_END + 49;
        public static var TYPEID_CRITICAL_MINUS:Object = OBJECT_END + 50;
        public static var TYPEID_ATK_SKILL:Object = OBJECT_END + 51;
        public static var TYPEID_DEF_SKILL:Object = OBJECT_END + 52;
        public static var TYPEID_EXTRA_ATK:Object = OBJECT_END + 57;
        public static var TYPEID_EXTRA_DEF:Object = OBJECT_END + 58;
        public static var UNIT_FIELD_FACTION:Object = OBJECT_END + 85;
        public static var TYPEID_UNIT_FIELD_SKILL_DMG_KILO:Object = OBJECT_END + 95;
        public static var TYPEID_UNIT_SKILL_ADDHIT_KILO:Object = OBJECT_END + 97;
        public static var TYPEID_UNIT_SKILL_REDUCEHIT_KILO:Object = OBJECT_END + 98;
        public static var TYPEID_UNIT_ATTACK_ADDHIT_KILO:Object = OBJECT_END + 99;
        public static var TYPEID_UNIT_ATTACK_REDUCEHIT_KILO:Object = OBJECT_END + 100;
        public static var TYPEID_ATTACK_LUKY:Object = OBJECT_END + 141;
        public static var TYPEID_UNIT_ATTACK:Object = OBJECT_END + 142;
        public static var TYPEID_UNIT_DEFENCE:Object = OBJECT_END + 143;
        public static var TYPEID_UNIT_FIELD_PHY_HIT_KILO:Object = OBJECT_END + 144;
        public static var TYPEID_UNIT_FIELD_PHY_SHUN_KILO:Object = OBJECT_END + 145;
        public static var TYPEID_UNIT_FIELD_SPELL_HIT_KILO:Object = OBJECT_END + 146;
        public static var TYPEID_UNIT_FIELD_SPELL_SHUN_KILO:Object = OBJECT_END + 147;
        public static var TYPEID_UNIT_FIELD_MBIGHIT_VALUE_KILO:Object = OBJECT_END + 148;
        public static var TYPEID_UNIT_FIELD_MBIGHIT_RESIST_KILO:Object = OBJECT_END + 149;
        public static var TYPEID_UNIT_FIELD_BIGHIT_VALUE_KILO:Object = OBJECT_END + 151;
        public static var TYPEID_UNIT_FIELD_BIGHIT_RESIST_KILO:Object = OBJECT_END + 152;
        public static var UNIT_MOVE_SPEED_LEVEL:Object = OBJECT_END + 155;
        public static var DISP_MOVE_SPEED:Object = OBJECT_END + 156;
        public static var DISP_ATK:Object = OBJECT_END + 160;
        public static var DISP_DEF:Object = OBJECT_END + 161;
        public static var DISP_DMG_ADD:Object = OBJECT_END + 162;
        public static var DISP_DMG_REDUCE:Object = OBJECT_END + 163;
        public static var DISP_DMG_ATK_SPEED:Object = OBJECT_END + 164;
        public static var DISP_SPELL_ADD:Object = OBJECT_END + 165;
        public static var DISP_ATK_HIT:Object = OBJECT_END + 166;
        public static var DISP_SPELL_HIT:Object = OBJECT_END + 167;
        public static var DISP_ATK_SHUN:Object = OBJECT_END + 168;
        public static var DISP_SPELL_SHUN:Object = OBJECT_END + 169;
        public static var DISP_ATK_BIGHIT_RATE:Object = OBJECT_END + 170;
        public static var DISP_SPELL_BIGHIT_RATE:Object = OBJECT_END + 171;
        public static var DISP_ATK_BIGHIT_REDUCE:Object = OBJECT_END + 172;
        public static var DISP_SPELL_BIGHIT_REDUCE:Object = OBJECT_END + 173;
        public static var DISP_ATK_BIGHIT_VALUEADD:Object = OBJECT_END + 174;
        public static var DISP_SPELL_BIGHIT_VALUEADD:Object = OBJECT_END + 175;
        public static var DISP_ATK_BIGHIT_VALUEREDUCE:Object = OBJECT_END + 176;
        public static var DISP_SPELL_BIGHIT_VALUEREDUCE:Object = OBJECT_END + 177;
        public static var DISP_SPELL_DMG_GOD:Object = OBJECT_END + 178;
        public static var DISP_SPELL_DMG_LUCK:Object = OBJECT_END + 179;
        public static var UNIT_ATTRIB_END:Object = OBJECT_END + 220;
        public static var UNIT_END:Object = UNIT_ATTRIB_END + 1000;
        public static var TYPEID_HAIR:Object = UNIT_END + 4;
        public static var TYPEID_CLIP:Object = UNIT_END + 6;
        public static var TYPEID_EXP:Object = UNIT_END + 7;
        public static var TYPEID_EXP_UPDATE:Object = UNIT_END + 8;
        public static var GILDID_UPDATE:Object = UNIT_END + 9;
        public static var TITLEID_UPDATE:Object = UNIT_END + 10;
        public static var GOLD_HAND_NUM:Object = UNIT_END + 11;
        public static var PICKS_SOUL_NUM:Object = UNIT_END + 12;
        public static const TYPEID_GOLDCOIN:int = UNIT_END + 13;
        public static const TYPEID_SILVERCOIN:int = UNIT_END + 71;
        public static var TYPEID_MONEY:Object = UNIT_END + 14;
        public static var TYPEID_WOLF_ID:int = UNIT_END + 18;
        public static var TYPEID_WOLF_NUM:int = UNIT_END + 19;
        public static var TYPEID_DAYTASK_REFASH:uint = UNIT_END + 73;
        public static var TYPEID_DAYTASK_NUM:uint = UNIT_END + 75;
        public static var TYPEID_GILDTASK_NUM:uint = UNIT_END + 20;
        public static var TYPEID_EQUIPLUCKY_NUM:uint = UNIT_END + 21;
        public static var TYPEID_BIND_MONEY:uint = UNIT_END + 15;
        public static var TYPEID_PICKS_SOUL:uint = UNIT_END + 27;
        public static var TYPEID_PICKS_ALLNUM:uint = UNIT_END + 28;
        public static var TYPEID_PICKS_TYPE:uint = UNIT_END + 29;
        public static var TYPEID_PICKS_NUM:uint = UNIT_END + 30;
        public static var TYPEID_PICKS_AWARD:uint = UNIT_END + 31;
        public static var TYPEID_EXPBALL_HADE:uint = UNIT_END + 32;
        public static var TYPEID_EXPBALL_ENDEXP:uint = UNIT_END + 33;
        public static var TYPEID_EXPBALL_OPEN:uint = UNIT_END + 34;
        public static var TYPEID_EXPBALL_LEFT:uint = UNIT_END + 35;
        public static var TYPEID_TEAM_LEADER:uint = UNIT_END + 52;
        public static var TYPEID_FCM_STATUS:uint = UNIT_END + 69;
        public static var TYPEID_FIELD_OPENBAG:Object = UNIT_END + 72;
        public static var TYPEID_PLAYER_FIELD_HUNTKILLERID:Object = UNIT_END + 74;
        public static var PLAYER_FIELD_RELIVECOUNT:Object = UNIT_END + 76;
        public static var TYPEID_PLAYER_HUE:Object = UNIT_END + 86;
        public static var PLAYER_FIELD_INSTANCESCORE:Object = UNIT_END + 78;
        public static var PLAYER_FIELD_HONOR:Object = UNIT_END + 87;
        public static var PLAYER_BALL1:Object = UNIT_END + 102;
        public static var PLAYER_BALL2:Object = UNIT_END + 103;
        public static var PLAYER_BALL3:Object = UNIT_END + 104;
        public static var PLAYER_BALL4:Object = UNIT_END + 105;
        public static var PLAYER_BALL5:Object = UNIT_END + 106;
        public static var PLAYER_FIELD_AUTOHP_STORE:Object = UNIT_END + 145;
        public static var PLAYER_FIELD_AUTOMP_STORE:Object = UNIT_END + 146;
        public static var PLAYER_FIELD_ACTIVESCORE:Object = UNIT_END + 149;
        public static var PLAYER_FIELD_ACTIVESCORE_YDAY:Object = UNIT_END + 150;
        public static var PLAYER_FIELD_ACTGIFT:Object = UNIT_END + 151;
        public static var PLAYER_FIELD_ACTGIFT_YDAY:Object = UNIT_END + 152;
        public static var PLAYER_GUILDSCORE:Object = UNIT_END + 159;
        public static var PLAYER_ESCORTTRA:Object = UNIT_END + 160;
        public static var PLAYER_ESCORTROB:Object = UNIT_END + 161;
        public static var PLAYER_FIELD_ESCORT_STATUS:Object = UNIT_END + 162;
        public static var PLAYER_FIELD_ESCORT_ENTRYID:Object = UNIT_END + 164;
        public static var PLAYER_ARENA1V1_SCORE:Object = UNIT_END + 165;
        public static var PLAYER_ARENA1V1_TODAY:Object = UNIT_END + 166;
        public static var PLAYER_ARENA1V1_TOTAL:Object = UNIT_END + 167;
        public static var PLAYER_ARENA1V1_WIN:Object = UNIT_END + 168;
        public static var PLAYER_ARENA1V1_DRAW:Object = UNIT_END + 169;
        public static var PLAYER_ARENA1V1_LOSE:Object = UNIT_END + 170;
        public static var PLAYER_ARENA1V1_COMBO:Object = UNIT_END + 171;
        public static var PLAYER_PET_MERGE_TEMP_ATTACK:Object = UNIT_END + 172;
        public static var PLAYER_PET_MERGE_TEMP_DEFEND:Object = UNIT_END + 173;
        public static var PLAYER_PET_MERGE_TEMP_HP:Object = UNIT_END + 174;
        public static var PLAYER_PET_MERGE_TEMP_MP:Object = UNIT_END + 175;
        public static var MONSTER_END:Object = UNIT_END + 1000;
        public static var TYPEID_BELONG_PLAYER:Object = MONSTER_END + 35;
        public static var TYPEID_BELONG_TEAM:Object = MONSTER_END + 36;
        public static var GO_END:Object = OBJECT_END + 3000;
        public static var GO_FIELD_BLOCK:Object = GO_END + 10;

        public function OBJECT_UPDATE_TYPE_ENUM()
        {
            return;
        }// end function

    }
}
