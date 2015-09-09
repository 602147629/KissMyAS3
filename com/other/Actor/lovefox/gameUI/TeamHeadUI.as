package lovefox.gameUI
{
    import com.bit101.components.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import lovefox.unit.*;
    import lovefox.util.*;

    public class TeamHeadUI extends MouseSprite
    {
        private var _bg:Bitmap;
        private var _headBmp:Bitmap;
        private var _hpBar:ProgressBar;
        private var _mpBar:ProgressBar;
        private var _hpLb:Label;
        private var _mpLb:Label;
        private var _nameLB:Label;
        private var _levelTxt:TextField;
        public var _unit:Unit;
        private var teamobj:Object;
        private var memberobj:Object;
        private var selectarr:uint = 0;
        private var maptip:Sprite;
        private var tipname:Label;
        private var tipmap:Label;
        private var tipline:Label;
        private var _mouseOn:Boolean = false;
        private static var _bgBmpd:BitmapData;

        public function TeamHeadUI(param1:Object, param2:Object)
        {
            this.initpanel(param1, param2);
            return;
        }// end function

        private function initpanel(param1:Object, param2:Object) : void
        {
            this._bg = new Bitmap(_bgBmpd);
            addChild(this._bg);
            this.teamobj = param1;
            this.memberobj = param2;
            this._headBmp = new Bitmap();
            this._headBmp.x = 2;
            this._headBmp.y = 0;
            addChild(this._headBmp);
            this._hpBar = new ProgressBar(this, 37, 18);
            this._hpBar.border = 0;
            this._hpBar.bgColor = 5459528;
            this._hpBar.gradientFillDirection = Math.PI;
            this._hpBar.color = 103481221;
            this._hpBar.subColor = 1681495;
            this._hpBar.height = 4;
            this._hpBar.width = 68;
            this._mpBar = new ProgressBar(this, 37, 24);
            this._mpBar.border = 0;
            this._mpBar.bgColor = 5459528;
            this._mpBar.gradientFillDirection = Math.PI;
            this._mpBar.color = 4972287;
            this._mpBar.subColor = 26519;
            this._mpBar.height = 4;
            this._mpBar.width = 68;
            this._nameLB = new Label(this, 34, -2);
            this._nameLB.textColor = Style.WHITE_FONT;
            this._levelTxt = Config.getSimpleTextField();
            this._levelTxt.textColor = Style.WHITE_FONT;
            this._levelTxt.x = 0;
            this._levelTxt.y = 20;
            this._levelTxt.text = param2.level;
            this._levelTxt.filters = [new GlowFilter(Style.WINDOW_FONT, 1, 3, 3, 10, 1)];
            addChild(this._levelTxt);
            this._headBmp.bitmapData = Config.findHead("s" + ((param2.sex - 1) * 12 + param2.job), 28, 28);
            this.update(this.memberobj.hp, this.memberobj.mxhp, this.memberobj.mp, this.memberobj.mxmp, this.memberobj.level);
            this.buttonMode = true;
            this.addEventListener("sglClick", this.showtipslist);
            this.addEventListener("dblClick", this.selectAsTArget);
            this.addEventListener(MouseEvent.ROLL_OVER, this.headrollOver);
            this.addEventListener(MouseEvent.ROLL_OUT, this.headrollOut);
            Skill.addSelectListener(this.handleSkillSelect);
            this.maptip = new Sprite();
            this.tipname = new Label(this.maptip, 10, 5);
            this.tipname.textColor = 16777215;
            this.tipmap = new Label(this.maptip, 10, 25);
            this.tipmap.textColor = 16777215;
            this.tipline = new Label(this.maptip, 10, 45);
            this.tipline.textColor = 16777215;
            return;
        }// end function

        private function selectAsTArget(param1)
        {
            Config.player.tracingTarget = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, this.memberobj.memberid);
            return;
        }// end function

        private function handleSkillSelect()
        {
            var _loc_1:* = undefined;
            var _loc_2:* = undefined;
            if (this._mouseOn)
            {
                if (Skill.selectedSkill)
                {
                    _loc_1 = Skill.selectedSkill._skillData.camp;
                    _loc_2 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, this.memberobj.memberid);
                    if (_loc_2 != null)
                    {
                        if (_loc_1 == 1 || _loc_1 == 2)
                        {
                            if (!_loc_2.die)
                            {
                                if (Config.player != null)
                                {
                                    this.filters = [Style.GREENLIGHT];
                                    return;
                                }
                            }
                        }
                        else if (_loc_1 == 3)
                        {
                            if (_loc_2.die)
                            {
                                if (Config.player != null)
                                {
                                    this.filters = [Style.GREENLIGHT];
                                    return;
                                }
                            }
                        }
                    }
                }
                this.filters = [];
            }
            return;
        }// end function

        public function update(param1:int, param2:int, param3:int, param4:int, param5:int) : void
        {
            this._nameLB.text = this.memberobj.name;
            this._hpBar.maximum = param2;
            this._hpBar.value = param1;
            if (param1 == 0)
            {
                this.filters = [new ColorMatrixFilter([1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0])];
            }
            else
            {
                this.filters = [];
            }
            this._mpBar.maximum = param4;
            this._mpBar.value = param3;
            this._levelTxt.text = String(param5);
            return;
        }// end function

        private function showtipslist(event:MouseEvent) : void
        {
            var _loc_5:* = undefined;
            var _loc_6:* = undefined;
            var _loc_7:* = undefined;
            trace(this.memberobj);
            if (Skill.selectedSkill)
            {
                _loc_5 = Skill.selectedSkill._skillData.camp;
                _loc_6 = Skill.selectedSkill._skillData.range;
                _loc_7 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, this.memberobj.memberid);
                if (_loc_7 != null)
                {
                    if (_loc_5 == 1 || _loc_5 == 2)
                    {
                        if (!_loc_7.die)
                        {
                            if (Config.player != null)
                            {
                                if (Config.player.testDistance(_loc_7) <= _loc_6 - 24)
                                {
                                    Config.player.castSkill(Skill.selectedSkill, _loc_7);
                                }
                                else
                                {
                                    BubbleUI.bubble(Config.language("TeamHeadUI", 1) + Skill.selectedSkill._skillData.name);
                                }
                            }
                        }
                    }
                    else if (_loc_5 == 3)
                    {
                        if (_loc_7.die)
                        {
                            if (Config.player != null)
                            {
                                if (Config.player.testDistance(_loc_7) <= _loc_6 - 24)
                                {
                                    Config.player.castSkill(Skill.selectedSkill, _loc_7);
                                }
                                else
                                {
                                    BubbleUI.bubble(Config.language("TeamHeadUI", 1));
                                }
                            }
                        }
                    }
                    return;
                }
            }
            var _loc_2:* = new Array();
            var _loc_3:* = [Config.language("TeamHeadUI", 2), Config.language("TeamHeadUI", 3), Config.language("TeamHeadUI", 4), Config.language("TeamHeadUI", 5), Config.language("TeamHeadUI", 6), Config.language("TeamHeadUI", 7), Config.language("TeamHeadUI", 8), Config.language("TeamHeadUI", 9)];
            var _loc_4:* = [Config.language("TeamHeadUI", 4), Config.language("TeamHeadUI", 5), Config.language("TeamHeadUI", 6), Config.language("TeamHeadUI", 7), Config.language("TeamHeadUI", 8), Config.language("TeamHeadUI", 9)];
            if (this.teamobj.right == 3)
            {
                _loc_2 = _loc_3;
                this.selectarr = 0;
            }
            else
            {
                _loc_2 = _loc_4;
                this.selectarr = 1;
            }
            if (this.alpha < 1)
            {
                _loc_2.pop();
            }
            DropDown.dropDown(_loc_2, this.handleDropDownClick);
            return;
        }// end function

        private function handleDropDownClick(param1:int) : void
        {
            if (this.selectarr == 1)
            {
                param1 = param1 + 2;
            }
            switch(param1)
            {
                case 0:
                {
                    Config.ui._teamUI.sendLeader(this.memberobj.memberid);
                    break;
                }
                case 1:
                {
                    Config.ui._teamUI.sendRemove(this.memberobj.memberid);
                    break;
                }
                case 2:
                {
                    Config.player.tracingTarget = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, this.memberobj.memberid);
                    break;
                }
                case 3:
                {
                    Config.ui._equippanel.sendequip(this.memberobj.memberid);
                    break;
                }
                case 4:
                {
                    Config.ui._friendUI.addFriend(this.memberobj.name);
                    break;
                }
                case 5:
                {
                    Config.ui._mailpanel.sendmailshow(null, this.memberobj.name);
                    Config.ui._mailpanel.open();
                    break;
                }
                case 6:
                {
                    Config.ui._dealUI.sendtodeal(this.memberobj.memberid);
                    break;
                }
                case 7:
                {
                    Config.ui._chatUI.whisperTo(this.memberobj.name);
                    break;
                }
                default:
                {
                    break;
                }
            }
            DropDown.close();
            return;
        }// end function

        private function headrollOver(event:MouseEvent) : void
        {
            var _loc_3:* = undefined;
            var _loc_4:* = undefined;
            this._mouseOn = true;
            if (Config.ui._radar._unitDic[Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, this.memberobj.memberid)] != null)
            {
                Config.ui._radar._unitDic[Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, this.memberobj.memberid)].filters = [Style.HIGHLIGHT];
            }
            Config.ui._layer3.addChild(this.maptip);
            this.maptip.x = Config.stage.mouseX;
            this.maptip.y = Config.stage.mouseY;
            var _loc_2:* = 100;
            this.tipname.text = this.memberobj.name;
            if (Config._mapMap[this.memberobj.map] == null)
            {
                this.tipmap.text = Config.language("TeamHeadUI", 10);
            }
            else
            {
                this.tipmap.text = Config.language("TeamHeadUI", 11) + Config._mapMap[this.memberobj.map].mapData.name;
            }
            _loc_2 = Math.max(_loc_2, this.tipmap.width + 10);
            this.tipline.text = Config.language("TeamHeadUI", 12) + int(this.memberobj.line) + Config.language("TeamHeadUI", 13);
            this.maptip.graphics.clear();
            this.maptip.graphics.beginFill(0, 0.5);
            this.maptip.graphics.drawRoundRect(0, 0, _loc_2, 70, 5);
            this.maptip.graphics.endFill();
            if (Skill.selectedSkill)
            {
                _loc_3 = Skill.selectedSkill._skillData.camp;
                _loc_4 = Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, this.memberobj.memberid);
                if (_loc_4 != null)
                {
                    if (_loc_3 == 1 || _loc_3 == 2)
                    {
                        if (!_loc_4.die)
                        {
                            if (Config.player != null)
                            {
                                this.filters = [Style.GREENLIGHT];
                            }
                        }
                    }
                    else if (_loc_3 == 3)
                    {
                        if (_loc_4.die)
                        {
                            if (Config.player != null)
                            {
                                this.filters = [Style.GREENLIGHT];
                            }
                        }
                    }
                }
            }
            return;
        }// end function

        private function headrollOut(event:MouseEvent) : void
        {
            this._mouseOn = false;
            if (Config.ui._radar._unitDic[Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, this.memberobj.memberid)] != null)
            {
                Config.ui._radar._unitDic[Unit.getUnit(UNIT_TYPE_ENUM.TYPEID_PLAYER, this.memberobj.memberid)].filters = [];
            }
            if (this.maptip.parent != null)
            {
                this.maptip.parent.removeChild(this.maptip);
            }
            this.filters = [];
            return;
        }// end function

        public function destroy()
        {
            if (this._headBmp != null && this._headBmp.bitmapData != null)
            {
                this._headBmp.bitmapData.dispose();
            }
            this.removeEventListener("sglClick", this.showtipslist);
            this.removeEventListener("dblClick", this.selectAsTArget);
            this.removeEventListener(MouseEvent.ROLL_OVER, this.headrollOver);
            this.removeEventListener(MouseEvent.ROLL_OUT, this.headrollOut);
            Skill.removeSelectListener(this.handleSkillSelect);
            if (this.maptip.parent != null)
            {
                this.maptip.parent.removeChild(this.maptip);
            }
            return;
        }// end function

        public static function init()
        {
            _bgBmpd = BitmapLoader.pick(String(Config.findUI("headui").team_bg.dir));
            return;
        }// end function

    }
}
