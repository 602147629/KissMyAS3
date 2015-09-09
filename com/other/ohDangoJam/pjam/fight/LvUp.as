class pjam.fight.LvUp
{
    var root, pdata, scene, enabled, __get___excNum, __get___upLv;
    function LvUp(root, pdata)
    {
        this.root = root;
        this.pdata = pdata;
    } // End of the function
    function get _excNum()
    {
        return (excNum);
    } // End of the function
    function get _upLv()
    {
        return (upLv);
    } // End of the function
    function check(gex)
    {
        var _loc3 = pdata.getLv();
        var _loc2 = pdata.getExc();
        if (_loc2 == undefined)
        {
            _loc2 = 0;
        } // end if
        upLv = this.getUpLv(_loc3, gex, _loc2);
    } // End of the function
    function getUpLv(lv, gex, exc)
    {
        if (lv < 5)
        {
            return (this.cmn(lv, gex, exc, 5));
        }
        else if (lv < 10)
        {
            return (this.cmn(lv, gex, exc, 10));
        }
        else if (lv < 50)
        {
            return (this.cmn(lv, gex, exc, 50));
        }
        else if (lv < 100)
        {
            return (this.cmn(lv, gex, exc, 100));
        }
        else if (lv < 300)
        {
            return (this.cmn(lv, gex, exc, 300));
        }
        else if (lv < 600)
        {
            return (this.cmn(lv, gex, exc, 600));
        }
        else if (lv < 1000)
        {
            return (this.cmn(lv, gex, exc, 1000));
        }
        else
        {
            return (this.cmn(lv, gex, exc, 5000));
        } // end else if
    } // End of the function
    function cmn(lv, gex, exc, max)
    {
        var _loc2 = 0;
        var _loc3 = Math.floor((exc + gex) / this["LV" + max]);
        if (lv + _loc3 > max)
        {
            _loc2 = max - lv;
            var _loc5 = gex - _loc2 * this["LV" + max];
            _loc2 = _loc2 + this.getUpLv(lv + _loc3, _loc5, 0);
        }
        else
        {
            _loc2 = _loc3;
            excNum = exc + gex - _loc3 * this["LV" + max];
        } // end else if
        return (_loc2);
    } // End of the function
    function getBeMax(max)
    {
        if (max == 5)
        {
            return (0);
        }
        else if (max == 10)
        {
            return (5);
        }
        else if (max == 50)
        {
            return (10);
        }
        else if (max == 100)
        {
            return (50);
        }
        else if (max == 300)
        {
            return (100);
        }
        else if (max == 600)
        {
            return (300);
        }
        else if (max == 1000)
        {
            return (600);
        }
        else
        {
            return (1000);
        } // end else if
    } // End of the function
    function dispLvUp()
    {
        scene = root.stageMC.lvupMC;
        restBonus = upLv * pjam.fight.LvUp.BONUS;
        scene.bonusTxt.text = restBonus;
        scene.hpTxt.text = 0;
        scene.attackTxt.text = 0;
        scene.magicTxt.text = 0;
        scene.defenseTxt.text = 0;
        var _loc2 = pjam.Charactor.getCharData(root, pdata.createRegistData());
        scene.nowHpTxt.text = _loc2.hp;
        scene.nowAttackTxt.text = _loc2.attack;
        scene.nowMagicTxt.text = _loc2.magic;
        scene.nowDefenseTxt.text = _loc2.defense;
        var sc = this;
        scene.okBtn.onRelease = function ()
        {
            enabled = false;
            var _loc2 = {hp: Number(sc.scene.hpTxt.text), attack: Number(sc.scene.attackTxt.text), magic: Number(sc.scene.magicTxt.text), defense: Number(sc.scene.defenseTxt.text)};
            sc.bonusEnd(_loc2);
        };
        this.setBonusBtn("hp");
        this.setBonusBtn("attack");
        this.setBonusBtn("magic");
        this.setBonusBtn("defense");
        if (restBonus > 0)
        {
            scene.okBtn.enabled = false;
            scene.okBtn._alpha = 50;
        }
        else
        {
            scene.okBtn.enabled = true;
            scene.okBtn._alpha = 100;
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
                sc.scene.okBtn.enabled = false;
                sc.scene.okBtn._alpha = 50;
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
                sc.scene.okBtn.enabled = true;
                sc.scene.okBtn._alpha = 100;
            } // end if
        };
    } // End of the function
    static function getPlayerBestLv(lv)
    {
        if (lv < 50)
        {
            return (50);
        }
        else if (lv < 100)
        {
            return (100);
        }
        else if (lv < 300)
        {
            return (300);
        }
        else if (lv < 600)
        {
            return (600);
        }
        else if (lv < 1000)
        {
            return (1000);
        }
        else
        {
            return (999999);
        } // end else if
    } // End of the function
    static function getDownPer(lv)
    {
        if (lv < 50)
        {
            return (0.100000);
        }
        else if (lv < 100)
        {
            return (0.150000);
        }
        else if (lv < 300)
        {
            return (0.200000);
        }
        else if (lv < 600)
        {
            return (0.300000);
        }
        else if (lv < 1000)
        {
            return (0.400000);
        }
        else
        {
            return (0.500000);
        } // end else if
    } // End of the function
    var upLv = 0;
    var excNum = 0;
    var LV5 = 50;
    var LV10 = 100;
    var LV50 = 500;
    var LV100 = 2000;
    var LV300 = 4000;
    var LV600 = 15000;
    var LV1000 = 40000;
    var LV5000 = 200000;
    var LV0 = 0;
    static var BONUS = 3;
    var restBonus = 0;
} // End of Class
