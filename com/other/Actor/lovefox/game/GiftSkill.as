package lovefox.game
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import lovefox.gameUI.*;

    public class GiftSkill extends Slot
    {
        private var _level:int;
        private var _baseId:int;
        private var icon:Bitmap;
        private var _giftSkillData:Object;
        private var gifttip:Sprite;
        private var lvlabel:Label;

        public function GiftSkill(param1:int, param2:int)
        {
            super(param1, param2);
            init();
            this.icon = new Bitmap();
            this.lvlabel = new Label(this, 34, 16);
            this.lvlabel.textColor = 16777215;
            this.lvlabel.filters = [new GlowFilter(1847129, 1, 3, 3, 10)];
            return;
        }// end function

        public function set giftSkill(param1:Object) : void
        {
            if (param1 == null)
            {
                if (this.baseId != 0)
                {
                    this.id = 0;
                    this.baseId = 0;
                    this.level = 0;
                    this.icon.bitmapData.dispose();
                    _container.removeChild(this.icon);
                    this.removeEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                    this.removeEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
                }
            }
            else
            {
                this.id = param1.baseId * 100 + param1.level;
                if (param1.level == 0)
                {
                    (this.id + 1);
                }
                this.baseId = param1.baseId;
                this.level = param1.level;
                this.icon.bitmapData = Config.findIcon(this._giftSkillData.icon);
                _container.addChild(this.icon);
                this.addEventListener(MouseEvent.ROLL_OVER, this.handleSlotOver);
                this.addEventListener(MouseEvent.ROLL_OUT, this.handleSlotOut);
            }
            return;
        }// end function

        public function get level() : int
        {
            return this._level;
        }// end function

        public function set level(param1:int) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            var _loc_4:* = undefined;
            var _loc_5:* = 0;
            var _loc_6:* = undefined;
            this.id = this.baseId * 100 + param1;
            if (param1 == 0)
            {
                (this.id + 1);
            }
            if (this.id > 1)
            {
                this._giftSkillData = Config._giftSkillMap[this.id];
                if (param1 > 0)
                {
                    _loc_2 = new Object();
                    _loc_3 = 1;
                    while (_loc_3 < 6)
                    {
                        
                        if (int(this._giftSkillData["affectskills" + _loc_3]) > 0)
                        {
                            _loc_4 = new Object();
                            _loc_5 = 0;
                            while (_loc_5 < Config._giftAttachMap[int(this._giftSkillData["giftlist" + _loc_3])].children().length())
                            {
                                
                                _loc_6 = Config._giftAttachMap[int(this._giftSkillData["giftlist" + _loc_3])].children()[_loc_5];
                                if (isNaN(Number(_loc_6)))
                                {
                                    _loc_4[Config._giftAttachMap[int(this._giftSkillData["giftlist" + _loc_3])].children()[_loc_5].name()] = String(_loc_6);
                                }
                                else
                                {
                                    _loc_4[Config._giftAttachMap[int(this._giftSkillData["giftlist" + _loc_3])].children()[_loc_5].name()] = Number(_loc_6);
                                }
                                _loc_5 = _loc_5 + 1;
                            }
                            if (!Skill._giftReviseMap.hasOwnProperty(this._giftSkillData["affectskills" + _loc_3]))
                            {
                                Skill._giftReviseMap[this._giftSkillData["affectskills" + _loc_3]] = {};
                            }
                            Skill._giftReviseMap[this._giftSkillData["affectskills" + _loc_3]][this.baseId] = _loc_4;
                        }
                        _loc_3 = _loc_3 + 1;
                    }
                }
            }
            if (param1 == 0)
            {
                this.gray = true;
            }
            else
            {
                this.gray = false;
            }
            this._level = param1;
            this.lvlabel.text = param1 + "/" + this._giftSkillData.maxLevel;
            if (param1 < this._giftSkillData.maxLevel && Config.ui._skillUI.getgiftpoint(int(this._giftSkillData.branch)) >= int(this._giftSkillData.reqPoint))
            {
                this.addEventListener(MouseEvent.CLICK, this.upDateGift);
                this.buttonMode = true;
                this.lvlabel.textColor = 3196748;
                this.setColorBorder(3196748);
            }
            else
            {
                this.removeEventListener(MouseEvent.CLICK, this.upDateGift);
                this.buttonMode = false;
                if (param1 == 0)
                {
                    this.lvlabel.textColor = 16777215;
                    this.setColorBorder(16777215);
                }
                else
                {
                    this.lvlabel.textColor = 12281894;
                    this.setColorBorder(12281894);
                }
            }
            return;
        }// end function

        public function get id() : int
        {
            return _id;
        }// end function

        public function set id(param1:int) : void
        {
            _id = param1;
            return;
        }// end function

        public function get baseId() : int
        {
            return this._baseId;
        }// end function

        public function set baseId(param1:int) : void
        {
            this._baseId = param1;
            return;
        }// end function

        private function handleSlotOver(event:MouseEvent = null)
        {
            var _loc_2:* = null;
            if (this.id != 0)
            {
                _loc_2 = this.parent.localToGlobal(new Point(this.x, this.y));
                Holder.showInfo(this.outputInfo(), new Rectangle(_loc_2.x, _loc_2.y, this._size, this._size), false, 0, 200);
            }
            return;
        }// end function

        private function handleSlotOut(event:MouseEvent = null)
        {
            Holder.closeInfo();
            return;
        }// end function

        public function reSlotOver() : void
        {
            Holder.closeInfo();
            this.handleSlotOver();
            return;
        }// end function

        private function outputInfo() : String
        {
            var _loc_1:* = "";
            _loc_1 = _loc_1 + (this._giftSkillData.name + "\n");
            _loc_1 = _loc_1 + ("\n" + Config.language("GiftSkill", 1) + this.level + "/" + this._giftSkillData.maxLevel);
            if (int(this._giftSkillData.reqPoint) > 0)
            {
                if (Config.ui._skillUI.getgiftpoint(int(this._giftSkillData.branch)) >= int(this._giftSkillData.reqPoint))
                {
                }
                else
                {
                    _loc_1 = _loc_1 + ("\n<font color=\'" + Style.FONT_Red + "\'>" + Config.language("GiftSkill", 2, this._giftSkillData.reqPoint, Config.ui._skillUI.getgname(this._giftSkillData.branch)) + "</font>");
                }
            }
            if (this.level > 0)
            {
                if (this.level == this._giftSkillData.maxLevel)
                {
                    _loc_1 = _loc_1 + ("\n<font color=\'" + Style.FONT_White + "\'>" + this._giftSkillData.description + "</font>");
                }
                else
                {
                    _loc_1 = _loc_1 + ("\n<font color=\'" + Style.FONT_White + "\'>" + this._giftSkillData.description + "</font>\n");
                    _loc_1 = _loc_1 + ("\n<font color=\'" + Style.FONT_White + "\'>" + Config.language("GiftSkill", 3) + "</font>");
                    _loc_1 = _loc_1 + ("\n<font color=\'" + Style.FONT_White + "\'>" + Config._giftSkillMap[int((this.id + 1))].description + "</font>");
                }
            }
            else
            {
                _loc_1 = _loc_1 + ("\n<font color=\'" + Style.FONT_White + "\'>" + this._giftSkillData.description + "</font>");
            }
            var _loc_2:* = 0;
            if (this._giftSkillData.maxLevel == 1)
            {
                if (this.level == 1)
                {
                    _loc_2 = 3;
                }
            }
            else if (this.level == 20)
            {
                _loc_2 = 3;
            }
            else if (this.level >= 15 && this.level < 20)
            {
                _loc_2 = 2;
            }
            else if (this.level >= 10 && this.level < 15)
            {
                _loc_2 = 1;
            }
            var _loc_3:* = 0;
            while (_loc_3 < 3)
            {
                
                if (this._giftSkillData.hasOwnProperty("proficient" + int((_loc_3 + 1))))
                {
                    if (String(this._giftSkillData["proficient" + int((_loc_3 + 1))]).length > 1)
                    {
                        if (_loc_3 == 0)
                        {
                            _loc_1 = _loc_1 + "\n";
                        }
                        if (_loc_3 < _loc_2)
                        {
                            _loc_1 = _loc_1 + ("\n<font color=\'" + Style.FONT_Green + "\'>" + this._giftSkillData["proficient" + int((_loc_3 + 1))] + "</font>");
                        }
                        else
                        {
                            _loc_1 = _loc_1 + ("\n<font color=\'" + Style.FONT_Gray + "\'>" + this._giftSkillData["proficient" + int((_loc_3 + 1))] + "</font>");
                        }
                    }
                }
                _loc_3 = _loc_3 + 1;
            }
            if (this.level == 0 && Config.ui._skillUI.getgiftpoint(int(this._giftSkillData.branch)) >= int(this._giftSkillData.reqPoint))
            {
                _loc_1 = _loc_1 + ("\n\n<font color=\'" + Style.FONT_Green + "\'>" + Config.language("GiftSkill", 4) + "</font>");
            }
            return _loc_1;
        }// end function

        public function set levelabel(param1:String) : void
        {
            this.lvlabel.text = param1;
            return;
        }// end function

        private function upDateGift(event:MouseEvent) : void
        {
            var _loc_2:* = new MouseEvent("giftupdate");
            this.dispatchEvent(_loc_2);
            return;
        }// end function

    }
}
