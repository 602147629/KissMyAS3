class pjam.scene.CharCreate
{
    var root, pdata, scene, mode, dataObj;
    function CharCreate(root, pdata, mode)
    {
        root.gotoAndStop("create");
        this.root = root;
        this.pdata = pdata;
        scene = root.createMC;
        this.mode = mode;
        dataObj = new Object();
        var _loc2 = new Sound();
        _loc2.attachSound("nameSound");
        _loc2.start();
    } // End of the function
    function start()
    {
        scene.gotoAndStop("name");
        if (dataObj.name != undefined)
        {
            scene.nameTxt.text = dataObj.name;
        } // end if
        scene.nameTxt.restrict = pjam.scene.CharCreate.OUT_STR;
        var sc = this;
        scene.nextBtn.onRelease = function ()
        {
            if (sc.scene.nameTxt.text == "")
            {
                return;
            } // end if
            sc.dataObj.name = sc.scene.nameTxt.text;
            sc.charSelect();
        };
    } // End of the function
    function charSelect()
    {
        scene.gotoAndStop("char");
        var path = root.charSet;
        if (dataObj.charNum != undefined)
        {
            path.selectedIndex = dataObj.charNum;
        }
        else
        {
            path.first();
        } // end else if
        var _loc2 = path.currentItem.id;
        scene.charMC.attachMovie(_loc2, _loc2, 0);
        var sc = this;
        scene.backBtn.onRelease = function ()
        {
            sc.start();
        };
        scene.nextBtn.onRelease = function ()
        {
            sc.dataObj.charNum = path.selectedIndex;
            sc.enterCharName();
        };
        scene.charBackBtn.onPress = function ()
        {
            sc.selectChar(-1);
        };
        scene.charNextBtn.onPress = function ()
        {
            sc.selectChar(1);
        };
    } // End of the function
    function selectChar(num)
    {
        var _loc2 = root.charSet;
        if (num == 1 && _loc2.selectedIndex + num >= _loc2.getLength())
        {
            _loc2.selectedIndex = 0;
        }
        else if (num == -1 && _loc2.selectedIndex + num < 0)
        {
            _loc2.selectedIndex = _loc2.getLength() - 1;
        }
        else
        {
            _loc2.selectedIndex = _loc2.selectedIndex + num;
        } // end else if
        var _loc4 = _loc2.currentItem.id;
        scene.charMC.attachMovie(_loc4, _loc4, 0);
        if (mode == pjam.CmnProject.TEST_MODE)
        {
            return;
        } // end if
        if (_loc2.currentItem.various == pjam.Charactor.VARIOUS_NORMAL)
        {
            return;
        } // end if
        this.selectChar(num);
    } // End of the function
    function enterCharName()
    {
        scene.gotoAndStop("charName");
        if (dataObj.charName != undefined)
        {
            scene.charNameTxt.text = dataObj.charName;
        } // end if
        scene.charNameTxt.restrict = pjam.scene.CharCreate.OUT_STR;
        var sc = this;
        scene.backBtn.onRelease = function ()
        {
            sc.charSelect();
        };
        scene.nextBtn.onRelease = function ()
        {
            if (sc.scene.charNameTxt.text == "")
            {
                return;
            } // end if
            sc.dataObj.charName = sc.scene.charNameTxt.text;
            sc.setBonus();
        };
    } // End of the function
    function setBonus()
    {
        scene.gotoAndStop("bonus");
        scene.bonusTxt.text = restBonus;
        scene.hpTxt.text = 0;
        scene.attackTxt.text = 0;
        scene.magicTxt.text = 0;
        scene.defenseTxt.text = 0;
        if (dataObj.hp != undefined)
        {
            scene.hpTxt.text = dataObj.hp;
        } // end if
        if (dataObj.attack != undefined)
        {
            scene.attackTxt.text = dataObj.attack;
        } // end if
        if (dataObj.magic != undefined)
        {
            scene.magicTxt.text = dataObj.magic;
        } // end if
        if (dataObj.defense != undefined)
        {
            scene.defenseTxt.text = dataObj.defense;
        } // end if
        var sc = this;
        scene.backBtn.onRelease = function ()
        {
            sc.enterCharName();
        };
        scene.nextBtn.onRelease = function ()
        {
            sc.dataObj.hp = Number(sc.scene.hpTxt.text);
            sc.dataObj.attack = Number(sc.scene.attackTxt.text);
            sc.dataObj.magic = Number(sc.scene.magicTxt.text);
            sc.dataObj.defense = Number(sc.scene.defenseTxt.text);
            sc.enterURL();
        };
        this.setBonusBtn("hp");
        this.setBonusBtn("attack");
        this.setBonusBtn("magic");
        this.setBonusBtn("defense");
        if (restBonus > 0)
        {
            scene.nextBtn.enabled = false;
            scene.nextBtn._alpha = 50;
        }
        else
        {
            scene.nextBtn.enabled = true;
            scene.nextBtn._alpha = 100;
        } // end else if
    } // End of the function
    function setBonusBtn(txt)
    {
        var sc = this;
        scene[txt + "BackBtn"].onPress = function ()
        {
            if (sc.scene[txt + "Txt"].text > 0)
            {
                ++sc.restBonus;
                sc.scene.bonusTxt.text = sc.restBonus;
                --sc.scene[txt + "Txt"].text;
                if (sc.restBonus == 0)
                {
                    return;
                } // end if
                sc.scene.nextBtn.enabled = false;
                sc.scene.nextBtn._alpha = 50;
            } // end if
        };
        scene[txt + "NextBtn"].onPress = function ()
        {
            if (sc.restBonus > 0)
            {
                --sc.restBonus;
                sc.scene.bonusTxt.text = sc.restBonus;
                ++sc.scene[txt + "Txt"].text;
                if (sc.restBonus > 0)
                {
                    return;
                } // end if
                sc.scene.nextBtn.enabled = true;
                sc.scene.nextBtn._alpha = 100;
            } // end if
        };
    } // End of the function
    function enterURL()
    {
        scene.gotoAndStop("url");
        if (dataObj.url != undefined)
        {
            scene.urlTxt.text = dataObj.url;
        } // end if
        scene.urlTxt.restrict = pjam.scene.CharCreate.OUT_STR;
        var sc = this;
        scene.backBtn.onRelease = function ()
        {
            sc.setBonus();
        };
        scene.nextBtn.onRelease = function ()
        {
            sc.dataObj.url = sc.scene.urlTxt.text;
            sc.createCheck();
        };
    } // End of the function
    function createCheck()
    {
        scene.gotoAndStop("check");
        var sc = this;
        scene.backBtn.onRelease = function ()
        {
            sc.enterURL();
        };
        scene.okBtn.onRelease = function ()
        {
            sc.registData();
        };
        var _loc2 = root.charSet.currentItem;
        scene.nameTxt.text = dataObj.name;
        scene.charNameTxt.text = dataObj.charName;
        scene.urlTxt.text = dataObj.url;
        var _loc3 = _loc2.id;
        scene.charMC.attachMovie(_loc3, _loc3, scene.getNextHighestDepth());
        scene.hpTxt.text = _loc2.plusHp + dataObj.hp;
        scene.attackTxt.text = _loc2.plusAttack + dataObj.attack;
        scene.magicTxt.text = _loc2.plusMagic + dataObj.magic;
        scene.defenseTxt.text = _loc2.plusDefense + dataObj.defense;
        scene.speedTxt.text = _loc2.speed;
        scene.luckTxt.text = _loc2.luck;
        scene.itemTxt0.text = _loc2.item;
    } // End of the function
    function registData()
    {
        root.loadMC._visible = true;
        root.loadMC.maruMC.gotoAndPlay(1);
        root.gotoAndStop("menu");
        root.loadMC.gotoAndStop("end");
        var _loc3 = root.charSet.currentItem;
        pdata.create(_loc3.charNum, dataObj.name, dataObj.charName, dataObj.hp, dataObj.attack, dataObj.magic, dataObj.defense, dataObj.url);
        _global.setTimeout(function (sc)
        {
            sc.registMsg();
        }, pjam.CmnProject.LOADEND_TIME, this);
    } // End of the function
    function registMsg()
    {
        root.loadMC.gotoAndStop("msg");
        root.loadMC.msgTxt.text = "キャラクター作成完了";
        var sc = this;
        root.loadMC.okBtn.onPress = function ()
        {
            sc.root.loadMC._visible = false;
            sc.createEnd();
        };
    } // End of the function
    var BONUS_MAX = 5;
    var restBonus = pjam.scene.CharCreate.prototype.BONUS_MAX;
    static var OUT_STR = "^,%=";
} // End of Class
