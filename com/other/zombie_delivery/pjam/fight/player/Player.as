class pjam.fight.player.Player
{
    var root, scene, cdata, bonus, effect, shadowMC, modeMC, mc, _x, area, some, attack, damage, jump, move, ai, manual, onEnterFrame, changeHP, changeSP, __get___bonus, __get___cdata, __get___mc, __get___pnum, __get___state;
    function Player(root, pnum, cdata)
    {
        this.root = root;
        scene = root.stageMC.fightMC;
        this.pnum = pnum;
        this.cdata = cdata;
        bonus = new pjam.fight.Bonus();
        effect = new pjam.fight.Effect(root);
        var _loc2 = 0;
        _loc2 = scene.charMC.getNextHighestDepth();
        shadowMC = scene.charMC.attachMovie("shadowMC", "shadowMC" + pnum, _loc2);
        _loc2 = scene.charMC.getNextHighestDepth();
        modeMC = scene.charMC.createEmptyMovieClip("modeMC" + _loc2, _loc2);
        _loc2 = scene.charMC.getNextHighestDepth();
        mc = scene.charMC.attachMovie(cdata.id, cdata.id + pnum, _loc2);
        mc._x = scene.charMC["charMC" + pnum]._x;
        mc._y = scene.charMC["charMC" + pnum]._y;
        var sc = this;
        shadowMC._y = mc._y;
        shadowMC.onEnterFrame = function ()
        {
            _x = sc.mc._x;
        };
        area = scene.areaMC.getBounds(scene);
        mc._y = area.yMax;
        if (pnum == pjam.fight.player.Player.PLAYER_EN)
        {
            vec = -1;
            mc.gotoAndStop("waitL");
        } // end if
    } // End of the function
    function setAct(some)
    {
        this.some = some;
        attack = new pjam.fight.player.Attack(mc, scene, area, cdata, some, effect);
        damage = new pjam.fight.player.Damage(mc, scene, area);
        jump = new pjam.fight.player.Jump(mc, scene, area);
        move = new pjam.fight.player.Move(mc, scene, area, pnum);
        ai = new pjam.fight.player.AiPlayer(mc, scene, area, some, pnum);
        manual = new pjam.fight.player.Manual(root, scene);
        var sc = this;
        attack.attackEnd = function ()
        {
            sc.nextAct(true);
        };
        attack.actionCansel = function ()
        {
            if (sc.jump.checkJump(sc.__get___cdata().jump) == false)
            {
                return;
            } // end if
            if (sc.aimode == false)
            {
                sc.manual.setCanselKey();
                return;
            } // end if
            if (sc.ai.aiHitJump() == true)
            {
                sc.jumpCmn();
            } // end if
        };
        attack.someHitAway = function ()
        {
            sc.some.damageCmn("down", "H");
            sc.some.damage.hitAway(sc.some.vec);
        };
        attack.someHitBack = function (hit)
        {
            sc.some.damageCmn("wait", hit);
            sc.some.damage.hitBack(sc.some.vec, hit);
        };
        attack.someAerial = function ()
        {
            sc.effect.aerial(sc.some.__get___mc());
            sc.some.damageCmn("down", "M");
            sc.some.damage.aerial(sc.some.vec);
        };
        attack.someReAerial = function ()
        {
            sc.some.damageCmn("down", "M");
            sc.some.damage.reAerial(sc.some.vec);
        };
        attack.someKO = function ()
        {
            sc.some.damageCmn("down", "H");
            sc.some.damage.ko(sc.some.vec);
            sc.manual.removeControl();
            sc.__get___mc().gotoAndStop("wait" + pjam.fight.player.Player.getVecStr(sc.vec));
        };
        attack.setBonus = function (str)
        {
            sc.setBonus(str);
        };
        damage.hitBackMy = function (step)
        {
            sc.some.move.hitBack(step, sc.some.vec);
        };
        damage.end = function (combo)
        {
            if (sc.escapeFlg == true)
            {
                return;
            } // end if
            if (combo > 1)
            {
                var _loc2 = new pjam.fight.TextEffect(sc.root, sc.scene.comboMC);
                _loc2.combo(combo, sc.some.__get___pnum());
            } // end if
            sc.some.__get___bonus().setCombo(combo);
            if (sc.__get___cdata().hp <= 0)
            {
                if (sc.endFlg == true)
                {
                    return;
                } // end if
                sc.endFlg = true;
                sc.destroy();
                sc.gameEnd(sc.__get___pnum());
            }
            else
            {
                sc.nextAct(false);
            } // end else if
        };
        jump.aiActCheck = function ()
        {
            if (sc.__get___state() != pjam.fight.player.Player.NON_STATE)
            {
                return;
            } // end if
            if (sc.aimode == false)
            {
                return;
            } // end if
            if (sc.ai.aiCheckAct() == true)
            {
                sc.ai.nextAct(sc.vec);
            } // end if
        };
        jump.end = function ()
        {
            if (sc.escapeFlg == true)
            {
                return;
            } // end if
            if (sc.__get___state() != pjam.fight.player.Player.NON_STATE)
            {
                return;
            } // end if
            if (sc.some.__get___cdata().hp <= 0)
            {
                return;
            } // end if
            if (sc.move.checkMoveState() == true)
            {
                return;
            } // end if
            sc.nextAct(true);
        };
        move.aiMoveEnd = function ()
        {
            sc.ai.nextAct(sc.vec);
        };
        ai.jump = function ()
        {
            sc.jumpCmn();
        };
        ai.move = function ()
        {
            var _loc1 = Math.floor(Math.random() * 2) ? (1) : (-1);
            if (sc.__get___mc()._y < sc.area.yMax && sc.vec != _loc1)
            {
                sc.jump.changeVec();
            } // end if
            sc.vec = _loc1;
            sc.move.aiMove(sc.vec, sc.__get___cdata().speed, sc.some);
        };
        ai.waitEnd = function ()
        {
            sc.nextAct(true);
        };
        ai.action = function (str)
        {
            sc.actionCmn(str);
        };
        manual.move = function (num)
        {
            if (sc.__get___mc()._y < sc.area.yMax && sc.vec != num)
            {
                sc.jump.changeVec();
            } // end if
            sc.vec = num;
            sc.move.main(sc.vec, sc.__get___cdata().speed);
        };
        manual.moveMouse = function ()
        {
            if (sc.__get___state() != pjam.fight.player.Player.NON_STATE)
            {
                return;
            } // end if
            var _loc1 = sc.scene._xmouse < sc.__get___mc()._x ? (-1) : (1);
            if (sc.__get___mc()._y < sc.area.yMax && sc.vec != _loc1)
            {
                sc.jump.changeVec();
            } // end if
            sc.vec = _loc1;
            sc.move.moveMouse(sc.vec, sc.__get___cdata().speed);
        };
        manual.jump = function ()
        {
            sc.jumpCmn();
        };
        manual.action = function (str)
        {
            sc.actionCmn(str);
        };
    } // End of the function
    function damageCmn(frame, hit)
    {
        var _loc2 = pjam.fight.player.Player.getSomeVecStr(mc, some);
        mc.gotoAndStop(frame + _loc2.str);
        vec = _loc2.vec;
        state = pjam.fight.player.Player.NON_STATE;
        manual.removeControl();
        attack.setActionCansel();
        ai.destroy();
        jump.destroy();
        move.destroy();
        effect.char(pjam.fight.Effect.DAMAGE, mc);
        effect.damage(hit, mc, vec);
    } // End of the function
    function jumpCmn()
    {
        if (jump.checkJump(cdata.jump) == false)
        {
            this.nextAct(true);
            return;
        } // end if
        attack.setActionCansel();
        if (mc._y == area.yMax)
        {
            effect.jump(mc, pjam.fight.player.Player.getVecStr(vec));
        } // end if
        var _loc2 = move.checkMoveState();
        if (_loc2 == true)
        {
            move.destroy();
        } // end if
        jump.main(cdata.speed, vec, _loc2);
        this.nextAct(false);
    } // End of the function
    function actionCmn(str)
    {
        if (str == pjam.fight.player.Player.DEFENSE_STATE && mc._y < area.yMax)
        {
            return;
        } // end if
        if (this.powerExe(str) == false)
        {
            if (aimode == true)
            {
                ai.nextAct(vec);
            } // end if
            return;
        } // end if
        manual.removeControl();
        var _loc3 = move.checkMoveState();
        if (aimode == true && _loc3 == false)
        {
            var _loc4 = pjam.fight.player.Player.getSomeVecStr(mc, some);
            vec = _loc4.vec;
        } // end if
        move.destroy();
        state = str;
        attack.action(str, vec, _loc3);
    } // End of the function
    function nextAct(flg)
    {
        if (escapeFlg == true)
        {
            return;
        } // end if
        if (flg == true)
        {
            mc.gotoAndStop("wait" + pjam.fight.player.Player.getVecStr(vec));
        } // end if
        state = pjam.fight.player.Player.NON_STATE;
        if (aimode == true)
        {
            ai.nextAct(vec);
        }
        else
        {
            manual.setControl();
        } // end else if
    } // End of the function
    function start(control)
    {
        if (pnum == pjam.fight.player.Player.PLAYER_EN || control == -1)
        {
            aimode = true;
            ai.nextAct(vec);
        }
        else
        {
            aimode = false;
            manual.setControl();
        } // end else if
    } // End of the function
    function changeMode()
    {
        delete modeMC.onEnterFrame;
        if (state == pjam.fight.player.Player.NON_STATE || mc._y == area.yMax)
        {
            move.destroy();
            this.setMode();
            return;
        } // end if
        var sc = this;
        modeMC.onEnterFrame = function ()
        {
            if (sc.__get___state() != pjam.fight.player.Player.NON_STATE)
            {
                return;
            } // end if
            if (sc.__get___mc()._y < sc.area.yMax)
            {
                return;
            } // end if
            delete this.onEnterFrame;
            sc.setMode();
        };
    } // End of the function
    function setMode()
    {
        if (aimode == true)
        {
            ai.destroy();
            aimode = false;
            manual.setControl();
        }
        else
        {
            manual.removeControl();
            aimode = true;
            ai.nextAct(vec);
        } // end else if
    } // End of the function
    function escape()
    {
        escapeFlg = true;
        manual.removeControl();
        attack.setActionCansel();
        ai.destroy();
        move.destroy();
        mc.gotoAndStop("wait" + pjam.fight.player.Player.getVecStr(vec));
    } // End of the function
    function destroy()
    {
        manual.removeControl();
        attack.setActionCansel();
        ai.destroy();
        damage.destroy();
        jump.destroy();
        move.destroy();
        if (cdata.hp > 0)
        {
            mc.gotoAndStop("wait" + pjam.fight.player.Player.getVecStr(vec));
        }
        else
        {
            mc.gotoAndStop("ko" + pjam.fight.player.Player.getVecStr(vec));
        } // end else if
    } // End of the function
    function get _mc()
    {
        return (mc);
    } // End of the function
    function get _state()
    {
        return (state);
    } // End of the function
    function get _cdata()
    {
        return (cdata);
    } // End of the function
    function get _bonus()
    {
        return (bonus);
    } // End of the function
    function get _pnum()
    {
        return (pnum);
    } // End of the function
    function dispDamage(num)
    {
        var _loc2 = new pjam.fight.TextEffect(root, scene);
        _loc2.start(num.toString(), mc, 16777215, pjam.fight.TextEffect.DAMAGE_MODE);
        if ((cdata.hp = cdata.hp - num) < 0)
        {
            cdata.hp = 0;
        } // end if
        this.changeHP(cdata.hp, pnum);
        return (cdata.hp);
    } // End of the function
    function setBonus(str)
    {
        cdata.sp = cdata.sp + bonus.action(str);
        if (cdata.sp > 100)
        {
            cdata.sp = 100;
        } // end if
        this.changeSP(cdata.sp, pnum);
    } // End of the function
    function powerExe(str)
    {
        if (str != pjam.fight.player.Player.POWER_STATE)
        {
            return (true);
        } // end if
        if (cdata.sp < 50)
        {
            return (false);
        } // end if
        cdata.sp = cdata.sp - 50;
        this.changeSP(cdata.sp, pnum);
        effect.power(mc, pjam.fight.player.Player.getVecStr(vec));
        return (true);
    } // End of the function
    static function getVecStr(vec)
    {
        return (vec == 1 ? ("R") : ("L"));
    } // End of the function
    static function getSomeVecStr(mc, some)
    {
        //return (mc._x > some._mc()._x ? ({vec: -1, str: "L"}) : ({vec: 1, str: "R"}));
    } // End of the function
    static function checkArea(cmc, scene, area)
    {
        var _loc1 = cmc.getBounds(scene);
        if (_loc1.xMin <= area.xMin || _loc1.xMax >= area.xMax)
        {
            return (true);
        }
        else
        {
            return (false);
        } // end else if
    } // End of the function
    static function setAreaPosition(mc, scene, area)
    {
        var _loc2 = mc.hitMC.getBounds(scene);
        if (_loc2.xMin <= area.xMin)
        {
            mc._x = area.xMin + Math.floor(mc.hitMC._width / 2);
            return (true);
        }
        else if (_loc2.xMax >= area.xMax)
        {
            mc._x = area.xMax - Math.floor(mc.hitMC._width / 2);
            return (true);
        } // end else if
        return (false);
    } // End of the function
    static var PLAYER_MY = 0;
    static var PLAYER_EN = 1;
    var pnum = -1;
    var vec = 1;
    static var ATTACK_STATE = "attack";
    static var MAGIC_STATE = "magic";
    static var DEFENSE_STATE = "defense";
    static var POWER_STATE = "power";
    static var NON_STATE = "";
    var state = "";
    var aimode = false;
    var escapeFlg = false;
    var endFlg = false;
} // End of Class
