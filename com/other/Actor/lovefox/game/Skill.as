package lovefox.game
{
    import flash.events.*;
    import flash.utils.*;
    import lovefox.gameUI.*;

    public class Skill extends EventDispatcher
    {
        public var _data:Object;
        public var _skillData:Object;
        public var _bmpd:Object;
        private var _relatedItemId:uint = 0;
        private var _aura:Boolean;
        private var _attackAdd:Boolean;
        private var _preCdStartTime:Object;
        public var _slot:QuickSlot;
        public var _id:uint = 0;
        private var _level:Object = 0;
        private var _exp:Object = 0;
        private var _locked:Boolean;
        public static var _skillBookMap:Object = {};
        public static var _skillMap:Object = [];
        private static var _selectedSkill:Object;
        public static var _cdStack:Array = [];
        public static var _cdMaxStack:Array = [];
        public static var _giftReviseMap:Object = {};
        public static var _chantTime:Object;
        public static var _chantSkill:Object;
        private static var _chantLevel:Object;
        private static var _chantTarget:Object;
        public static var _chanting:Boolean = false;
        public static var _entertainCdStack:Array = [];
        public static var _petPickSkill:Object = <list>r
n	t	t	t	t	t	t	t	t	t	t	t	t<id>100004</id>r
n	t	t	t	t	t	t	t	t	t	t	t	t<preBranch>1</preBranch>r
n	t	t	t	t	t	t	t	t	t	t	t	t<baseId>10001</baseId>r
n	t	t	t	t	t	t	t	t	t	t	t	t<level>1</level>r
n	t	t	t	t	t	t	t	t	t	t	t	t<name></name>//抓精灵r
n	t	t	t	t	t	t	t	t	t	t	t	t<camp>0</camp>r
n	t	t	t	t	t	t	t	t	t	t	t	t<description>r
n//	t	t	t	t	t	t	t	t	t	t	t	t<![CDATA[]]>r
n	t	t	t	t	t	t	t	t	t	t	t	t</description>r
n	t	t	t	t	t	t	t	t	t	t	t	t<icon>s00023</icon>r
n	t	t	t	t	t	t	t	t	t	t	t	t<range>10000</range>r
n	t	t	t	t	t	t	t	t	t	t	t	t<reqJob>0</reqJob>r
n	t	t	t	t	t	t	t	t	t	t	t	t<coolDown>300000</coolDown>r
n	t	t	t	t	t	t	t	t	t	t	t	t<targetType>2</targetType>r
n	t	t	t	t	t	t	t	t	t	t	t</list>")("<list>
												<id>100004</id>
												<preBranch>1</preBranch>
												<baseId>10001</baseId>
												<level>1</level>
												<name></name>//?�精?�\r
												<camp>0</camp>
												<description>
//												<![CDATA[]]>
												</description>
												<icon>s00023</icon>
												<range>10000</range>
												<reqJob>0</reqJob>
												<coolDown>300000</coolDown>
												<targetType>2</targetType>
											</list>;
        public static var _petChangeSkill:Object = <list>r
n	t	t	t	t	t	t	t	t	t	t	t	t	t	t<id>100005</id>r
n	t	t	t	t	t	t	t	t	t	t	t	t	t	t<preBranch>1</preBranch>r
n	t	t	t	t	t	t	t	t	t	t	t	t	t	t<baseId>10001</baseId>r
n	t	t	t	t	t	t	t	t	t	t	t	t	t	t<level>1</level>r
n	t	t	t	t	t	t	t	t	t	t	t	t	t	t<name></name>r
n	t	t	t	t	t	t	t	t	t	t	t	t	t	t<camp>0</camp>r
n	t	t	t	t	t	t	t	t	t	t	t	t	t	t<description>r
n	t	t	t	t	t	t	t	t	t	t	t	t	t	t<![CDATA[]]>r
n	t	t	t	t	t	t	t	t	t	t	t	t	t	t</description>r
n	t	t	t	t	t	t	t	t	t	t	t	t	t	t<icon>s00023</icon>r
n	t	t	t	t	t	t	t	t	t	t	t	t	t	t<range>10000</range>r
n	t	t	t	t	t	t	t	t	t	t	t	t	t	t<reqJob>0</reqJob>r
n	t	t	t	t	t	t	t	t	t	t	t	t	t	t<coolDown>300000</coolDown>r
n	t	t	t	t	t	t	t	t	t	t	t	t	t	t<targetType>1</targetType>r
n	t	t	t	t	t	t	t	t	t	t	t	t	t</list>")("<list>
														<id>100005</id>
														<preBranch>1</preBranch>
														<baseId>10001</baseId>
														<level>1</level>
														<name></name>
														<camp>0</camp>
														<description>
														<![CDATA[]]>
														</description>
														<icon>s00023</icon>
														<range>10000</range>
														<reqJob>0</reqJob>
														<coolDown>300000</coolDown>
														<targetType>1</targetType>
													</list>;
        public static var _petBackSkill:Object = <list>r
n	t	t	t	t	t	t	t	t	t	t	t	t	t	t<id>100006</id>r
n	t	t	t	t	t	t	t	t	t	t	t	t	t	t<preBranch>1</preBranch>r
n	t	t	t	t	t	t	t	t	t	t	t	t	t	t<baseId>10001</baseId>r
n	t	t	t	t	t	t	t	t	t	t	t	t	t	t<level>1</level>r
n	t	t	t	t	t	t	t	t	t	t	t	t	t	t<name></name>//变回人形r
n	t	t	t	t	t	t	t	t	t	t	t	t	t	t<camp>0</camp>r
n	t	t	t	t	t	t	t	t	t	t	t	t	t	t<description>r
n	t	t	t	t	t	t	t	t	t	t	t	t	t	t<![CDATA[]]>r
n	t	t	t	t	t	t	t	t	t	t	t	t	t	t</description>r
n	t	t	t	t	t	t	t	t	t	t	t	t	t	t<icon>s00063</icon>r
n	t	t	t	t	t	t	t	t	t	t	t	t	t	t<range>10000</range>r
n	t	t	t	t	t	t	t	t	t	t	t	t	t	t<reqJob>0</reqJob>r
n	t	t	t	t	t	t	t	t	t	t	t	t	t	t<coolDown>300000</coolDown>r
n	t	t	t	t	t	t	t	t	t	t	t	t	t	t<targetType>1</targetType>r
n	t	t	t	t	t	t	t	t	t	t	t	t	t</list>")("<list>
														<id>100006</id>
														<preBranch>1</preBranch>
														<baseId>10001</baseId>
														<level>1</level>
														<name></name>//?��?人形
														<camp>0</camp>
														<description>
														<![CDATA[]]>
														</description>
														<icon>s00063</icon>
														<range>10000</range>
														<reqJob>0</reqJob>
														<coolDown>300000</coolDown>
														<targetType>1</targetType>
													</list>;
        public static var _goldhandSkill:Object = <list>r
n	t	t	t	t	t	t	t	t	t	t	t	t<id>100001</id>r
n	t	t	t	t	t	t	t	t	t	t	t	t<preBranch>1</preBranch>r
n	t	t	t	t	t	t	t	t	t	t	t	t<baseId>10001</baseId>r
n	t	t	t	t	t	t	t	t	t	t	t	t<level>1</level>r
n	t	t	t	t	t	t	t	t	t	t	t	t<name></name>r
n	t	t	t	t	t	t	t	t	t	t	t	t<camp>0</camp>r
n	t	t	t	t	t	t	t	t	t	t	t	t<description>r
n	t	t	t	t	t	t	t	t	t	t	t	t<![CDATA[]]>r
n	t	t	t	t	t	t	t	t	t	t	t	t</description>r
n	t	t	t	t	t	t	t	t	t	t	t	t<icon>s00023</icon>r
n	t	t	t	t	t	t	t	t	t	t	t	t<range>10000</range>r
n	t	t	t	t	t	t	t	t	t	t	t	t<reqJob>0</reqJob>r
n	t	t	t	t	t	t	t	t	t	t	t	t<coolDown>300000</coolDown>r
n	t	t	t	t	t	t	t	t	t	t	t	t<targetType>2</targetType>r
n	t	t	t	t	t	t	t	t	t	t	t</list>")("<list>
												<id>100001</id>
												<preBranch>1</preBranch>
												<baseId>10001</baseId>
												<level>1</level>
												<name></name>
												<camp>0</camp>
												<description>
												<![CDATA[]]>
												</description>
												<icon>s00023</icon>
												<range>10000</range>
												<reqJob>0</reqJob>
												<coolDown>300000</coolDown>
												<targetType>2</targetType>
											</list>;
        public static var _picksoulSkill:Object = <list>r
n	t	t	t	t	t	t	t	t	t	t	t	t<id>100003</id>r
n	t	t	t	t	t	t	t	t	t	t	t	t<preBranch>1</preBranch>r
n	t	t	t	t	t	t	t	t	t	t	t	t<baseId>10003</baseId>r
n	t	t	t	t	t	t	t	t	t	t	t	t<level>1</level>r
n	t	t	t	t	t	t	t	t	t	t	t	t<name></name>r
n	t	t	t	t	t	t	t	t	t	t	t	t<description><![CDATA[]]></description>r
n	t	t	t	t	t	t	t	t	t	t	t	t<icon>s00024</icon>r
n	t	t	t	t	t	t	t	t	t	t	t	t<range>10000</range>r
n	t	t	t	t	t	t	t	t	t	t	t	t<reqJob>0</reqJob>r
n	t	t	t	t	t	t	t	t	t	t	t	t<coolDown>300000</coolDown>r
n	t	t	t	t	t	t	t	t	t	t	t	t<targetType>1</targetType>r
n	t	t	t	t	t	t	t	t	t	t	t</list>")("<list>
												<id>100003</id>
												<preBranch>1</preBranch>
												<baseId>10003</baseId>
												<level>1</level>
												<name></name>
												<description><![CDATA[]]></description>
												<icon>s00024</icon>
												<range>10000</range>
												<reqJob>0</reqJob>
												<coolDown>300000</coolDown>
												<targetType>1</targetType>
											</list>;
        private static var _goldhandTime:uint = 0;
        private static var _picksoulTime:uint = 0;
        private static var _selectListenerDict:Dictionary = new Dictionary();
        private static var _soulTimer:Object;

        public function Skill(param1)
        {
            this.setData(param1);
            this.cd = 0;
            return;
        }// end function

        public function set locked(param1)
        {
            this._locked = param1;
            return;
        }// end function

        public function get locked()
        {
            return this._locked;
        }// end function

        public function set level(param1)
        {
            var _loc_2:* = undefined;
            this._level = param1;
            if (this._level == 0)
            {
                this.setData(Config._skillMap[this._skillData.baseId * 10]);
            }
            else
            {
                if (this._level <= 4)
                {
                    _loc_2 = Config._skillMap[this._skillData.baseId * 10 + this._level - 1];
                }
                else
                {
                    _loc_2 = Config._skillMap[this._skillData.baseId * 100 + this._level + 100000];
                }
                if (_loc_2 != null)
                {
                    this.setData(_loc_2);
                }
            }
            return;
        }// end function

        public function get level()
        {
            return this._level;
        }// end function

        public function set exp(param1)
        {
            this._exp = param1;
            return;
        }// end function

        public function get exp()
        {
            return this._exp;
        }// end function

        public function get expMax()
        {
            return this._skillData.reqSkillPoint;
        }// end function

        public function checkSlot()
        {
            if (this._slot != null)
            {
                this._slot.sendAdd();
            }
            return;
        }// end function

        public function get name()
        {
            return String(this._skillData.name);
        }// end function

        public function set aura(param1)
        {
            this._aura = param1;
            return;
        }// end function

        public function get aura()
        {
            return this._aura;
        }// end function

        public function set attackAdd(param1)
        {
            this._attackAdd = param1;
            return;
        }// end function

        public function get attackAdd()
        {
            return this._attackAdd;
        }// end function

        public function set relatedItemId(param1)
        {
            this._relatedItemId = param1;
            return;
        }// end function

        public function get relatedItemId()
        {
            return this._relatedItemId;
        }// end function

        public function select(param1 = 0)
        {
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = undefined;
            trace("select");
            this.relatedItemId = param1;
            if (selectedSkill != this)
            {
                _loc_5 = this._skillData.useType1;
                _loc_6 = this._skillData.useType2;
                _loc_7 = this._skillData.useParam1;
                _loc_8 = this._skillData.useParam2;
                if (_giftReviseMap.hasOwnProperty(this._skillData.baseId))
                {
                    for (_loc_9 in _giftReviseMap[this._skillData.baseId])
                    {
                        
                        _loc_5 = _loc_5 + _giftReviseMap[this._skillData.baseId][_loc_9].useType1;
                        _loc_6 = _loc_6 + _giftReviseMap[this._skillData.baseId][_loc_9].useType2;
                        _loc_7 = _loc_7 + _giftReviseMap[this._skillData.baseId][_loc_9].useParam1;
                        _loc_8 = _loc_8 + _giftReviseMap[this._skillData.baseId][_loc_9].useParam2;
                    }
                }
                if (_loc_5 == 1)
                {
                    if (Config.player.mp < _loc_7)
                    {
                        BubbleUI.bubble(Config.language("Skill", 1));
                        return false;
                    }
                }
                else if (_loc_5 == 2)
                {
                    if (Config.player.hp < _loc_7)
                    {
                        BubbleUI.bubble(Config.language("Skill", 2));
                        return false;
                    }
                }
                if (_loc_6 == 1)
                {
                    if (Config.player.mp < _loc_8)
                    {
                        BubbleUI.bubble(Config.language("Skill", 1));
                        return false;
                    }
                }
                else if (_loc_6 == 2)
                {
                    if (Config.player.hp < _loc_8)
                    {
                        BubbleUI.bubble(Config.language("Skill", 2));
                        return false;
                    }
                }
                if (this.cd <= 0 || isNaN(this.cd))
                {
                }
                else
                {
                    BubbleUI.bubble(Config.language("Skill", 3));
                    return false;
                }
            }
            var _loc_4:* = this._skillData.camp;
            if (this._data == Skill._picksoulSkill)
            {
                _loc_3 = new DataSet();
                _loc_3.addHead(CONST_ENUM.C2G_PICKSOUL_OPEN);
                ClientSocket.send(_loc_3);
                this.locked = true;
            }
            else if (this._skillData.targetType == 0)
            {
            }
            else if (this._skillData.targetType == 1)
            {
                if (this._skillData.lockTarget)
                {
                    Config.player.castSkill(this, Config.player.tracingTarget);
                }
                else
                {
                    Config.player.castSkill(this);
                }
            }
            else if (this._skillData.targetType == 2)
            {
                if (selectedSkill == this)
                {
                    selectedSkill = null;
                    if (this._data == Skill._goldhandSkill)
                    {
                        Config.ui._quickUI._goldhandSlot.selected = false;
                    }
                }
                else if (this.cd <= 0 || isNaN(this.cd))
                {
                    selectedSkill = this;
                    if (this._data == Skill._goldhandSkill)
                    {
                        Config.ui._quickUI._goldhandSlot.selected = true;
                    }
                    if (this._skillData.lockTarget)
                    {
                        if (Config.player.tracingTarget != null && (_loc_4 == 2 || _loc_4 == 3 || _loc_4 == 0 && Config.player.tracingTarget.testPk() || _loc_4 == 1 && !Config.player.tracingTarget.testPk()))
                        {
                            Config.player.target = Config.player.tracingTarget;
                        }
                    }
                }
            }
            else if (this._skillData.targetType == 3)
            {
                if (selectedSkill == this)
                {
                    selectedSkill = null;
                }
                else if (this.cd <= 0 || isNaN(this.cd))
                {
                    selectedSkill = this;
                    if (this._skillData.lockTarget)
                    {
                        if (Config.player.tracingTarget != null && (_loc_4 == 2 || _loc_4 == 3 || _loc_4 == 0 && Config.player.tracingTarget.testPk() || _loc_4 == 1 && !Config.player.tracingTarget.testPk()))
                        {
                            Config.player.target = Config.player.tracingTarget;
                        }
                    }
                }
            }
            return true;
        }// end function

        private function setData(param1)
        {
            this._data = param1;
            this._skillData = this._data;
            this._id = this._skillData.id;
            _skillMap[this._skillData.id] = this;
            return;
        }// end function

        public function set cdMax(param1)
        {
            _cdMaxStack[this._skillData.id] = param1;
            return;
        }// end function

        public function set cd(param1)
        {
            if (param1 == null || isNaN(param1))
            {
                return;
            }
            if (_cdMaxStack[this._skillData.id] == null)
            {
                _cdMaxStack[this._skillData.id] = param1;
            }
            else
            {
                _cdMaxStack[this._skillData.id] = Math.max(param1, _cdMaxStack[this._skillData.id]);
            }
            var _loc_2:* = new Date();
            this._preCdStartTime = _loc_2.getTime() + param1;
            _cdStack[this._skillData.id] = this._preCdStartTime;
            Config.ui._quickUI.handleSkillCd(this._skillData.id, param1);
            return;
        }// end function

        public function get cd()
        {
            var _loc_1:* = undefined;
            if (this._preCdStartTime != null)
            {
                _loc_1 = new Date();
                return Math.max(0, this._preCdStartTime - _loc_1.getTime());
            }
            return 0;
        }// end function

        public function outputInfoSimple()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_3:* = undefined;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            if (this._skillData.preBranch == 1)
            {
                _loc_1 = "<font color=\'#FF9E3E\'><b>" + this._skillData.name + "</b></font>";
                _loc_2 = this._skillData.description.split("|");
                if (_loc_2.length == 1)
                {
                    _loc_1 = _loc_1 + ("\n\n<font color=\'#30C74C\'>" + _loc_2[0] + "</font>");
                }
                else
                {
                    _loc_1 = _loc_1 + ("\n\n<font color=\'#30C74C\'>" + _loc_2[1] + "</font>");
                }
                return _loc_1;
            }
            _loc_1 = "<font color=\'#FF9E3E\'><b>" + Config.language("Skill", 4, this._skillData.name, Number((this._skillData.level - 1))) + ")</b></font>";
            _loc_1 = _loc_1 + "\n";
            var _loc_4:* = this._skillData.useType1;
            var _loc_5:* = this._skillData.useType2;
            var _loc_6:* = this._skillData.useParam1;
            var _loc_7:* = this._skillData.useParam2;
            var _loc_8:* = this._skillData["coolDown"];
            if (_giftReviseMap.hasOwnProperty(this._skillData.baseId))
            {
                for (_loc_12 in _giftReviseMap[this._skillData.baseId])
                {
                    
                    if (_giftReviseMap[this._skillData.baseId][_loc_12].coolDown != 0)
                    {
                        _loc_8 = _loc_8 + _giftReviseMap[this._skillData.baseId][_loc_12].coolDown;
                    }
                    _loc_4 = _loc_4 + _giftReviseMap[this._skillData.baseId][_loc_12].useType1;
                    _loc_5 = _loc_5 + _giftReviseMap[this._skillData.baseId][_loc_12].useType2;
                    _loc_6 = _loc_6 + _giftReviseMap[this._skillData.baseId][_loc_12].useParam1;
                    _loc_7 = _loc_7 + _giftReviseMap[this._skillData.baseId][_loc_12].useParam2;
                }
            }
            _loc_11 = 0;
            if (_loc_4 == 1)
            {
                _loc_9 = "" + Config.language("Skill", 5, _loc_6);
            }
            else if (_loc_4 == 2)
            {
                _loc_9 = "" + Config.language("Skill", 16, _loc_6);
            }
            if (_loc_5 == 1)
            {
                _loc_9 = "" + Config.language("Skill", 5, _loc_7);
            }
            else if (_loc_4 == 2)
            {
                _loc_9 = "" + Config.language("Skill", 16, _loc_7);
            }
            if (_loc_9 != null)
            {
                _loc_11 = _loc_11 + 3;
            }
            else
            {
                _loc_9 = Config.language("Skill", 6);
                _loc_11 = _loc_11 + 3;
            }
            _loc_10 = "" + Config.language("Skill", 7, Math.floor(this._skillData.range / (Map._ptPerTile / 2)));
            _loc_11 = _loc_11 + 3;
            _loc_1 = _loc_1 + _loc_9;
            _loc_3 = 0;
            while (_loc_3 < 36 - (_loc_9.length + _loc_10.length + _loc_11))
            {
                
                _loc_1 = _loc_1 + "  ";
                _loc_3 = _loc_3 + 1;
            }
            _loc_1 = _loc_1 + _loc_10;
            _loc_1 = _loc_1 + "\n";
            _loc_11 = 0;
            if (this._skillData.isChant == 0)
            {
                _loc_9 = Config.language("Skill", 8);
                _loc_11 = _loc_11 + 2;
            }
            else if (this._skillData.skillType == 4)
            {
                _loc_9 = Config.language("Skill", 9, this._skillData.chantTime / 1000 / 10);
                _loc_11 = _loc_11 + 4;
            }
            else
            {
                _loc_9 = Config.language("Skill", 10, this._skillData.chantTime / 1000);
                _loc_11 = _loc_11 + 3;
            }
            if (Math.floor(_loc_8 / 1000) > 60)
            {
                if (Math.floor(_loc_8 % 60000 / 1000) > 0)
                {
                    _loc_10 = "" + Config.language("Skill", 11, Math.floor(_loc_8 / 60000), Math.floor(_loc_8 % 60000 / 1000));
                }
                else
                {
                    _loc_10 = "" + Config.language("Skill", 12, Math.floor(_loc_8 / 60000));
                }
                _loc_11 = _loc_11 + 4;
            }
            else if (Math.floor(_loc_8 / 1000) >= 0)
            {
                _loc_10 = "" + Config.language("Skill", 13, Math.floor(_loc_8 / 1000));
                _loc_11 = _loc_11 + 3;
            }
            _loc_1 = _loc_1 + _loc_9;
            _loc_3 = 0;
            while (_loc_3 < 36 - (_loc_9.length + _loc_10.length + _loc_11))
            {
                
                _loc_1 = _loc_1 + "  ";
                _loc_3 = _loc_3 + 1;
            }
            _loc_1 = _loc_1 + _loc_10;
            _loc_2 = this._skillData.description.split("|");
            if (_loc_2.length == 1)
            {
                _loc_1 = _loc_1 + ("\n\n<font color=\'#30C74C\'>" + _loc_2[0] + "</font>");
            }
            else
            {
                _loc_1 = _loc_1 + ("\n\n<font color=\'#30C74C\'>" + _loc_2[1] + "</font>");
            }
            return _loc_1;
        }// end function

        public function outputInfo()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = undefined;
            var _loc_10:* = undefined;
            var _loc_11:* = undefined;
            var _loc_12:* = undefined;
            var _loc_13:* = undefined;
            if (this.level == 0)
            {
                _loc_2 = "<b>" + this._skillData.name + " (" + Config.language("Skill", 14) + ")</b>";
            }
            else
            {
                _loc_2 = "<font color=\'#FF9E3E\'><b>" + Config.language("Skill", 4, this._skillData.name, Number((this._skillData.level - 1))) + ")</b></font>";
            }
            _loc_2 = _loc_2 + "\n";
            if (this._skillData.skillType == 1)
            {
                _loc_2 = _loc_2 + Config.language("Skill", 15);
            }
            else
            {
                _loc_4 = this._skillData.useType1;
                _loc_5 = this._skillData.useType2;
                _loc_6 = this._skillData.useParam1;
                _loc_7 = this._skillData.useParam2;
                _loc_8 = this._skillData["coolDown"];
                _loc_11 = 0;
                if (_loc_4 == 1)
                {
                    _loc_9 = "" + Config.language("Skill", 5, _loc_6);
                }
                else if (_loc_4 == 2)
                {
                    _loc_9 = "" + Config.language("Skill", 16, _loc_6);
                }
                if (_loc_5 == 1)
                {
                    _loc_9 = "" + Config.language("Skill", 5, _loc_7);
                }
                else if (_loc_4 == 2)
                {
                    _loc_9 = "" + Config.language("Skill", 16, _loc_7);
                }
                if (_loc_9 != null)
                {
                    _loc_11 = _loc_11 + 3;
                }
                else
                {
                    _loc_9 = Config.language("Skill", 6);
                    _loc_11 = _loc_11 + 3;
                }
                _loc_10 = "" + Config.language("Skill", 7, Math.floor(this._skillData.range / (Map._ptPerTile / 2)));
                _loc_11 = _loc_11 + 3;
                _loc_2 = _loc_2 + _loc_9;
                _loc_1 = 0;
                while (_loc_1 < 36 - (_loc_9.length + _loc_10.length + _loc_11))
                {
                    
                    _loc_2 = _loc_2 + "  ";
                    _loc_1 = _loc_1 + 1;
                }
                _loc_2 = _loc_2 + _loc_10;
                _loc_2 = _loc_2 + "\n";
                _loc_11 = 0;
                if (this._skillData.isChant == 0)
                {
                    _loc_9 = Config.language("Skill", 8);
                    _loc_11 = _loc_11 + 2;
                }
                else if (this._skillData.skillType == 4)
                {
                    _loc_9 = Config.language("Skill", 9, this._skillData.chantTime / 1000 / 10);
                    _loc_11 = _loc_11 + 4;
                }
                else
                {
                    _loc_9 = Config.language("Skill", 10, this._skillData.chantTime / 1000);
                    _loc_11 = _loc_11 + 3;
                }
                if (Math.floor(_loc_8 / 1000) > 60)
                {
                    if (Math.floor(_loc_8 % 60000 / 1000) > 0)
                    {
                        _loc_10 = "" + Config.language("Skill", 11, Math.floor(_loc_8 / 60000), Math.floor(_loc_8 % 60000 / 1000));
                    }
                    else
                    {
                        _loc_10 = "" + Config.language("Skill", 12, Math.floor(_loc_8 / 60000));
                    }
                    _loc_11 = _loc_11 + 4;
                }
                else if (Math.floor(_loc_8 / 1000) >= 0)
                {
                    _loc_10 = "" + Config.language("Skill", 13, Math.floor(_loc_8 / 1000));
                    _loc_11 = _loc_11 + 3;
                }
                _loc_2 = _loc_2 + _loc_9;
                _loc_1 = 0;
                while (_loc_1 < 36 - (_loc_9.length + _loc_10.length + _loc_11))
                {
                    
                    _loc_2 = _loc_2 + "  ";
                    _loc_1 = _loc_1 + 1;
                }
                _loc_2 = _loc_2 + _loc_10;
            }
            var _loc_3:* = this._skillData.description.split("|");
            _loc_2 = _loc_2 + ("\n\n<font color=\'#30C74C\'>" + _loc_3[0] + "</font>");
            if (_loc_3.length > 1)
            {
                _loc_2 = _loc_2 + ("\n<font color=\'#30C74C\'>" + _loc_3[1] + "</font>");
            }
            if (Number(this._skillData.giftFlag) == 0)
            {
                if (this.level < 4)
                {
                    _loc_12 = Config._skillMap[Number(this._skillData.baseId + "" + this.level)];
                }
                else
                {
                    _loc_12 = Config._skillMap[Number(this._skillData.baseId) * 100 + this.level + 1 + 100000];
                }
                if (_loc_12 != null)
                {
                    if (this.level > 0)
                    {
                        _loc_3 = String(_loc_12.description).split("|");
                        if (_loc_3.length > 0)
                        {
                            _loc_2 = _loc_2 + Config.language("Skill", 18, _loc_3[1]);
                        }
                    }
                    if (Number(_loc_12.reqLevel) <= Config.player.level)
                    {
                        _loc_2 = _loc_2 + "\n\n<font color=\'#ffffff\'>";
                    }
                    else
                    {
                        _loc_2 = _loc_2 + "\n\n<font color=\'#ad1b2e\'>";
                    }
                    _loc_2 = _loc_2 + (Config.language("Skill", 19, _loc_12.reqLevel) + "</font>");
                    if (this.level == 0)
                    {
                        _loc_13 = _skillBookMap[Number(_loc_12.id)];
                        if (Config.ui._charUI.getOneItem(_loc_13) == null)
                        {
                            _loc_2 = _loc_2 + ("\n<font color=\'#ad1b2e\'>" + Config.language("Skill", 20, String(Config._itemMap[_skillBookMap[Number(_loc_12.id)]].name)) + "</font>");
                        }
                        else
                        {
                            _loc_2 = _loc_2 + ("\n" + Config.language("Skill", 20, String(Config._itemMap[_skillBookMap[Number(_loc_12.id)]].name)));
                        }
                    }
                }
            }
            else if (this.level == 0)
            {
                _loc_2 = _loc_2 + ("\n\n<font color=\'#ad1b2e\'>" + Config.language("Skill", 21) + "</font>");
            }
            return _loc_2;
        }// end function

        public function getDisplay()
        {
            if (this._bmpd == null)
            {
                this._bmpd = Config.findIcon(this._skillData.icon);
            }
            return new Bitmap(this._bmpd);
        }// end function

        public function getIcon()
        {
            if (this._bmpd == null)
            {
                this._bmpd = Config.findIcon(this._skillData.icon);
            }
            return this._bmpd;
        }// end function

        public static function set goldhandTime(param1)
        {
            _goldhandTime = param1;
            Config.ui._quickUI._goldhandSlot.amount = 3 - param1;
            if (3 - param1 <= 0)
            {
                Config.ui._quickUI.closeGoldhand();
            }
            else if (Config.ui._taskpanel.getTaskState(53) == 3)
            {
                Config.ui._quickUI.openGoldhand();
            }
            return;
        }// end function

        public static function get goldhandTime()
        {
            return _goldhandTime;
        }// end function

        public static function get picksoulTimeStd()
        {
            var _loc_1:* = 0;
            if (Config.ui._taskpanel.getTaskState(101) == 3)
            {
                _loc_1 = 1;
            }
            else if (Config.ui._taskpanel.getTaskState(32) == 3)
            {
                _loc_1 = 3;
            }
            return _loc_1;
        }// end function

        public static function set picksoulTime(param1)
        {
            clearTimeout(_soulTimer);
            if (Config.ui._taskpanel._taskFinishListInit)
            {
                subPicksoulTime(param1);
            }
            else
            {
                _soulTimer = setTimeout(rePicksoulTime, 1000, param1);
            }
            return;
        }// end function

        private static function rePicksoulTime(param1)
        {
            picksoulTime = param1;
            return;
        }// end function

        private static function subPicksoulTime(param1)
        {
            var _loc_2:* = picksoulTimeStd;
            _picksoulTime = param1;
            Config.ui._quickUI._picksoulSlot.amount = _loc_2 - param1;
            if (_loc_2 - param1 <= 0)
            {
                Config.ui._quickUI.closePicksoul();
            }
            else if (_loc_2 > 0)
            {
                Config.ui._quickUI.openPicksoul();
            }
            return;
        }// end function

        public static function get picksoulTime()
        {
            return _picksoulTime;
        }// end function

        public static function getSkill(param1)
        {
            if (_skillMap[param1] == null)
            {
                return new Skill(Config._skillMap[param1]);
            }
            return _skillMap[param1];
        }// end function

        public static function set chantLevel(param1:uint)
        {
            if (_chantSkill == null)
            {
                return;
            }
            _chantLevel = param1;
            if (param1 > 0)
            {
                Config.player.burstWord("" + _chantSkill._skillData.name + _chantLevel);
                UnitEffect.charge(Config.player, param1);
            }
            if (param1 < 10)
            {
                if (Number(_chantSkill._skillData.skillType) == 4)
                {
                    Config.player.startGather(_chantSkill._skillData.chantTime / 10, _chantSkill._skillData.chantTime / 10);
                }
                else
                {
                    Config.player.startGather(_chantSkill._skillData.chantTime, _chantSkill._skillData.chantTime);
                }
            }
            return;
        }// end function

        public static function get chantLevel()
        {
            return _chantLevel;
        }// end function

        public static function get chantSkill()
        {
            return _chantSkill;
        }// end function

        public static function get chantTarget()
        {
            return _chantTarget;
        }// end function

        public static function get chanting()
        {
            return _chanting;
        }// end function

        public static function startChant(param1)
        {
            if (Config.player.target == null)
            {
                _chantTarget = null;
            }
            else
            {
                _chantTarget = Config.player.target._data;
            }
            _chantSkill = param1;
            _chantLevel = 0;
            _chanting = true;
            chantLevel = 0;
            if (Config.player.target != null && Config.player.target is Unit)
            {
                Config.player.target.addHalo(1161);
            }
            Config.setMouseState("spell", true);
            return;
        }// end function

        public static function stopChant()
        {
            if (Config.player.target != null && Config.player.target is Unit)
            {
                Config.player.target.removeHalo(1161);
            }
            UnitEffect.killCharge(Config.player);
            _chantSkill = null;
            _chantLevel = 0;
            _chanting = false;
            Config.setMouseState("", true);
            Config.player.stopGather();
            return;
        }// end function

        public static function castChant()
        {
            var _loc_1:* = new DataSet();
            _loc_1.addHead(CONST_ENUM.C2G_SKILL_BREAK);
            ClientSocket.send(_loc_1);
            return;
        }// end function

        public static function set selectedSkill(param1:Skill)
        {
            var _loc_2:* = undefined;
            if (param1 == null || param1.cd <= 0 || isNaN(param1.cd))
            {
                if (_selectedSkill != null)
                {
                    EventMouse.setCircle();
                    _selectedSkill.dispatchEvent(new Event("unselect"));
                    if (_selectedSkill._data == Skill._goldhandSkill)
                    {
                        Config.ui._quickUI._goldhandSlot.selected = false;
                    }
                }
                _selectedSkill = param1;
                if (_selectedSkill != null)
                {
                    if (param1._skillData.isAmbit == 1 && param1._skillData.ambitType > 0 && param1._skillData.ambitType < 5 && param1._skillData.targetType > 1)
                    {
                        EventMouse.setCircle(param1._skillData.ambitType, param1._skillData.ambit1, param1._skillData.ambit2);
                    }
                    _selectedSkill.dispatchEvent(new Event("select"));
                }
                for (_loc_2 in _selectListenerDict)
                {
                    
                    Skill._loc_2();
                }
            }
            return;
        }// end function

        public static function addSelectListener(param1)
        {
            _selectListenerDict[param1] = true;
            return;
        }// end function

        public static function removeSelectListener(param1)
        {
            delete _selectListenerDict[param1];
            return;
        }// end function

        public static function get selectedSkill() : Skill
        {
            return _selectedSkill;
        }// end function

        public static function testSkillReady(param1)
        {
            var _loc_2:* = undefined;
            _loc_2 = 1;
            while (_loc_2 < 3)
            {
                
                if (param1._skillData["useType" + _loc_2] == 1)
                {
                    if (Config.player.mp < param1._skillData["useParam" + _loc_2])
                    {
                        return false;
                    }
                }
                else if (param1._skillData["useType" + _loc_2] == 2)
                {
                    if (Config.player.hp < param1._skillData["useParam" + _loc_2])
                    {
                        return false;
                    }
                }
                _loc_2 = _loc_2 + 1;
            }
            if (param1 is Skill && param1.level == 0)
            {
                return false;
            }
            if (param1.cd <= 0 || isNaN(param1.cd))
            {
            }
            else
            {
                return false;
            }
            return true;
        }// end function

        public static function getSkillRange(param1)
        {
            var _loc_3:* = undefined;
            var _loc_2:* = Number(param1.range);
            for (_loc_3 in _giftReviseMap[param1.baseId])
            {
                
                _loc_2 = _loc_2 + _giftReviseMap[param1.baseId][_loc_3].range;
            }
            return _loc_2;
        }// end function

        _petBackSkill.name = Config.language("Skill", 22);
        _petBackSkill.description = Config.language("Skill", 23);
        _petChangeSkill.name = Config.language("Skill", 24);
        _petChangeSkill.description = Config.language("Skill", 25);
        _petBackSkill.name = Config.language("Skill", 26);
        _petBackSkill.description = Config.language("Skill", 27);
        _goldhandSkill.name = Config.language("Skill", 28);
        _goldhandSkill.description = Config.language("Skill", 29);
        _picksoulSkill.name = Config.language("Skill", 30);
        _picksoulSkill.description = Config.language("Skill", 31);
    }
}
