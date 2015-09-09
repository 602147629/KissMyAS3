class pjam.fight.Fight
{
    var root, scene, pdata, mode, next, myObj, enObj, lvUp, gauge, enabled, nextFrame, pryEn, pryMy, _currentframe, _totalframes, onEnterFrame, bonus, end;
    function Fight(root, pdata, enObj, mode, next)
    {
        this.root = root;
        scene = root.stageMC.fightMC;
        this.pdata = pdata;
        this.mode = mode;
        this.next = next;
        myObj = pjam.Charactor.getCharData(root, pdata.createRegistData());
        this.enObj = enObj;
        lvUp = new pjam.fight.LvUp(root, pdata);
    } // End of the function
    function start()
    {
        pdata.setFakeFlg(true);
        this.createPlayer();
        scene.finMC._visible = false;
        if (pdata.getControl() == 1)
        {
            scene.btnMMC.nextFrame();
            scene.btnAMC.gotoAndStop(1);
        }
        else
        {
            scene.btnAMC.nextFrame();
            scene.btnMMC.gotoAndStop(1);
        } // end else if
        gauge = new pjam.fight.Gauge(root, myObj.hp, enObj.hp, myObj.sp);
        if (pdata.getControl() == -1)
        {
            scene.btnAMC.nextFrame();
        }
        else
        {
            scene.btnMMC.nextFrame();
        } // end else if
        var sc = this;
        scene.btnAMC.onPress = function ()
        {
            sc.pdata.changeControl();
            sc.pryMy.changeMode();
            sc.scene.btnMMC.enabled = true;
            sc.scene.btnMMC.gotoAndStop(1);
            enabled = false;
            this.nextFrame();
        };
        scene.btnMMC.onPress = function ()
        {
            sc.pdata.changeControl();
            sc.pryMy.changeMode();
            sc.scene.btnAMC.enabled = true;
            sc.scene.btnAMC.gotoAndStop(1);
            enabled = false;
            this.nextFrame();
        };
        scene.escapeBtn.onPress = function ()
        {
            sc.pryEn.escape();
            sc.pryMy.escape();
            sc.judge();
        };
        scene.btnAMC.onRollOver = function ()
        {
            pjam.SysLog.disp(sc.root, "操作をオートに切り替えます。");
        };
        scene.btnMMC.onRollOver = function ()
        {
            pjam.SysLog.disp(sc.root, "操作をマニュアルに切り替えます。\n操作方法はHELPを参照してください。");
        };
        scene.escapeBtn.onRollOver = function ()
        {
            pjam.SysLog.disp(sc.root, "戦闘から脱出します。\nランダムでお金を失います。");
        };
        scene.btnAMC.enabled = false;
        scene.btnMMC.enabled = false;
        scene.escapeBtn.enabled = false;
        var _loc2 = new pjam.fight.StageEffect(root);
        _loc2.start();
        this.hideCheck();
    } // End of the function
    function createPlayer()
    {
        pryEn.destroy();
        pryMy.destroy();
        delete this.pryEn;
        delete this.pryMy;
        pryEn = new pjam.fight.player.Player(root, pjam.fight.player.Player.PLAYER_EN, enObj);
        pryMy = new pjam.fight.player.Player(root, pjam.fight.player.Player.PLAYER_MY, myObj);
        pryEn.setAct(pryMy);
        pryMy.setAct(pryEn);
        var sc = this;
        pryEn.changeHP = function (hp, num)
        {
            sc.gauge.setHP(hp, num);
        };
        pryEn.changeSP = function (sp, num)
        {
            sc.gauge.setSP(sp, num);
        };
        pryMy.changeHP = function (hp, num)
        {
            sc.gauge.setHP(hp, num);
        };
        pryMy.changeSP = function (sp, num)
        {
            sc.gauge.setSP(sp, num);
        };
        pryEn.gameEnd = function (num)
        {
            sc.loseNum = num;
            sc.judge();
        };
        pryMy.gameEnd = pryEn.gameEnd;
    } // End of the function
    function hideCheck()
    {
        var sc = this;
        scene.hideMC.play();
        scene.hideMC.onEnterFrame = function ()
        {
            if (_currentframe < _totalframes)
            {
                return;
            } // end if
            delete this.onEnterFrame;
            sc.ready();
        };
    } // End of the function
    function ready()
    {
        var sc = this;
        scene.gotoAndStop("ready");
        scene.readyMC.blackMC.onEnterFrame = function ()
        {
            if (_currentframe < _totalframes)
            {
                return;
            } // end if
            delete this.onEnterFrame;
            sc.scene.readyMC.nextFrame();
            sc.scene.readyMC.blackMC.onEnterFrame = function ()
            {
                if (_currentframe < _totalframes)
                {
                    return;
                } // end if
                delete this.onEnterFrame;
                sc.scene.readyMC._visible = false;
            };
            sc.pryMy.start(sc.pdata.getControl());
            sc.pryEn.start(-1);
            if (sc.pdata.getControl() == -1)
            {
                sc.scene.btnMMC.enabled = true;
            }
            else
            {
                sc.scene.btnAMC.enabled = true;
            } // end else if
            sc.scene.escapeBtn.enabled = true;
        };
    } // End of the function
    function judge()
    {
        scene.btnAMC.enabled = false;
        scene.btnMMC.enabled = false;
        scene.escapeBtn.enabled = false;
        if (loseNum == -1)
        {
            this.fin();
            return;
        } // end if
        scene.gotoAndStop("judge");
        if (loseNum == pjam.fight.player.Player.PLAYER_EN)
        {
            scene.judgeMC.msgTxt.text = "YOU WIN";
        }
        else
        {
            scene.judgeMC.msgTxt.text = "YOU LOSE";
        } // end else if
        var sc = this;
        scene.btn.onPress = function ()
        {
            sc.fin();
        };
    } // End of the function
    function fin()
    {
        bonus = pryMy.__get___bonus().getBonus(loseNum, enObj, root);
        var sc = this;
        scene.gotoAndStop("fin");
        scene.finMC.frameMC.onEnterFrame = function ()
        {
            if (_currentframe < _totalframes)
            {
                return;
            } // end if
            delete this.onEnterFrame;
            sc.finPoint();
        };
    } // End of the function
    function finPoint()
    {
        if (loseNum == -1)
        {
            this.finEscape();
            return;
        }
        else if (loseNum == pjam.fight.player.Player.PLAYER_MY)
        {
            this.finStatus();
            return;
        } // end else if
        scene.finMC.gotoAndStop("point");
        scene.finMC.exTxt.text = bonus.ex;
        scene.finMC.moneyTxt.text = bonus.money;
        var sc = this;
        scene.btn.onPress = function ()
        {
            sc.finStatus();
        };
    } // End of the function
    function finStatus()
    {
        scene.finMC.gotoAndStop("status");
        scene.finMC.attackTxt.text = bonus.attack;
        scene.finMC.magicTxt.text = bonus.magic;
        scene.finMC.defenseTxt.text = bonus.defense;
        var sc = this;
        scene.btn.onPress = function ()
        {
            sc.finCombo();
        };
    } // End of the function
    function finCombo()
    {
        if (bonus.combo == 0)
        {
            this.finItem();
            return;
        } // end if
        scene.finMC.gotoAndStop("combo");
        scene.finMC.comboTxt.text = bonus.comboMax;
        scene.finMC.moneyTxt.text = bonus.combo;
        var sc = this;
        scene.btn.onPress = function ()
        {
            sc.finItem();
        };
    } // End of the function
    function finItem()
    {
        if (loseNum == pjam.fight.player.Player.PLAYER_MY)
        {
            this.finDrop();
            return;
        }
        else if (bonus.item == -1)
        {
            this.finLv();
            return;
        } // end else if
        scene.finMC.gotoAndStop("item");
        var _loc2 = pjam.Charactor.getItemName(root, bonus.item);
        scene.finMC.itemTxt.text = _loc2;
        var sc = this;
        scene.btn.onPress = function ()
        {
            sc.finLv();
        };
    } // End of the function
    function finLv()
    {
        lvUp.check(bonus.ex);
        if (lvUp.__get___upLv() <= 0)
        {
            this.destroy();
            this.dispFullItem();
            return;
        } // end if
        scene.finMC.gotoAndStop("lv");
        var sc = this;
        scene.btn.onPress = function ()
        {
            sc.destroy();
            sc.dispFullItem();
        };
    } // End of the function
    function finEscape()
    {
        scene.finMC.gotoAndStop("escape");
        var sc = this;
        scene.btn.onPress = function ()
        {
            sc.finDrop();
        };
    } // End of the function
    function finDrop()
    {
        scene.finMC.gotoAndStop("drop");
        var _loc2 = 0;
        var _loc3 = pjam.fight.LvUp.getDownPer(pdata.getLv());
        if (loseNum == -1)
        {
            _loc2 = Math.floor(Math.random() * (pryMy.__get___cdata().money * _loc3));
        }
        else
        {
            _loc2 = Math.floor(pryMy.__get___cdata().money * _loc3);
        } // end else if
        scene.finMC.moneyTxt.text = _loc2;
        bonus.money = bonus.money - _loc2;
        var sc = this;
        scene.btn.onPress = function ()
        {
            sc.destroy();
            sc.saveData(null);
        };
    } // End of the function
    function dispFullItem()
    {
        var _loc2 = pdata.checkItemFull();
        if (bonus.item != -1 && _loc2 != -1)
        {
            pdata.setItem(_loc2, bonus.item);
            this.dispLvUp();
            return;
        }
        else if (bonus.item == -1)
        {
            this.dispLvUp();
            return;
        } // end else if
        var sc = this;
        next.end = function ()
        {
            var _loc1 = new pjam.fight.ItemRest(sc.root, sc.pdata);
            _loc1.end = function ()
            {
                sc.dispLvUp();
            };
            _loc1.start(sc.bonus.item);
        };
        next.start("itemRestMC", -1);
    } // End of the function
    function dispLvUp()
    {
        if (lvUp.__get___upLv() <= 0)
        {
            this.saveData(null);
            return;
        } // end if
        var sc = this;
        next.end = function ()
        {
            sc.lvUp.bonusEnd = function (data)
            {
                sc.saveData(data);
            };
            sc.lvUp.dispLvUp();
        };
        next.start("lvupMC", -1);
    } // End of the function
    function saveData(data)
    {
        var _loc6 = 0;
        var _loc3 = 0;
        var _loc5 = 0;
        var _loc2 = 0;
        var _loc7 = loseNum == pjam.fight.player.Player.PLAYER_MY ? (pdata.getExc()) : (lvUp.__get___excNum());
        if (data != null)
        {
            _loc6 = data.hp + 1;
            _loc3 = data.attack + bonus.attack;
            _loc5 = data.magic + bonus.magic;
            _loc2 = data.defense + bonus.defense;
        }
        else
        {
            _loc3 = bonus.attack;
            _loc5 = bonus.magic;
            _loc2 = bonus.defense;
        } // end else if
        pdata.setFightData(bonus.money + bonus.combo, lvUp.__get___upLv(), bonus.ex, _loc7, _loc6, _loc3, _loc5, _loc2, pryMy.__get___cdata().sp);
        pdata.setFakeFlg(false);
        this.end();
    } // End of the function
    function destroy()
    {
        scene.btn.enabled = false;
    } // End of the function
    var loseNum = -1;
} // End of Class
