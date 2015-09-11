class pjam.fight.player.Attack
{
    var mc, scene, area, cdata, some, effect, someKO, attackEnd, setBonus, someHitAway, someReAerial, someAerial, someHitBack, actionCansel;
    function Attack(mc, scene, area, cdata, some, effect)
    {
        this.mc = mc;
        this.scene = scene;
        this.area = area;
        this.cdata = cdata;
        this.some = some;
        this.effect = effect;
    } // End of the function
    function setActionCansel()
    {
        actionCanselFlg = true;
    } // End of the function
    function action(str, vec, moveFlg)
    {
        actionCanselFlg = false;
        actStep = 0;
        if (str == pjam.fight.player.Player.POWER_STATE)
        {
            spFlg = true;
        } // end if
        mc.gotoAndStop(str + pjam.fight.player.Player.getVecStr(vec));
        var sc = this;
        mc.mc.onEnterFrame = function ()
        {
            sc.actionAct(str, vec, moveFlg);
        };
    } // End of the function
    function actionAct(str, vec, flg)
    {
        if (actionCanselFlg == true)
        {
            this.actionEndCmn(vec);
            return;
        } // end if
        if (spFlg == true && str == pjam.fight.player.Player.POWER_STATE)
        {
            mc._x = mc._x + cdata.spMove * vec;
        } // end if
        if (flg == true && ++actStep < ATTACK_MOVE)
        {
            mc._x = mc._x + (Math.floor(cdata.speed / 3) + 1) * vec;
        } // end if
        if (pjam.fight.player.Player.setAreaPosition(mc, scene, area) == true)
        {
            flg = false;
            spFlg = false;
        } // end if
        if (some.__get___cdata().hp > 0)
        {
            this.readyHit(vec, str);
        }
        else
        {
            this.someKO();
        } // end else if
        if (mc.mc._currentframe != mc.mc._totalframes)
        {
            return;
        } // end if
        this.actionEndCmn(vec);
        if (some.__get___cdata().hp > 0)
        {
            this.attackEnd();
        } // end if
    } // End of the function
    function actionEndCmn(vec)
    {
        delete mc.mc.onEnterFrame;
    } // End of the function
    function readyHit(vec, str)
    {
        if (str == pjam.fight.player.Player.MAGIC_STATE && some.__get___state() == pjam.fight.player.Player.ATTACK_STATE)
        {
            return;
        } // end if
        if (str == pjam.fight.player.Player.ATTACK_STATE && some.__get___state() == pjam.fight.player.Player.DEFENSE_STATE)
        {
            return;
        } // end if
        if (str != pjam.fight.player.Player.DEFENSE_STATE)
        {
            this.hitCheck(vec, mc.mc.hitS, str);
            this.hitCheck(vec, mc.mc.hitM, str);
            this.hitCheck(vec, mc.mc.hitH, str);
            this.hitCheck(vec, mc.mc.hitUP, str);
        }
        else
        {
            this.defense(vec, some.__get___mc().mc.hitS);
            this.defense(vec, some.__get___mc().mc.hitM);
            this.defense(vec, some.__get___mc().mc.hitH);
            this.defense(vec, some.__get___mc().mc.hitUP);
        } // end else if
    } // End of the function
    function hitCheck(vec, cMC, str)
    {
        if (cMC == undefined)
        {
            return;
        } // end if
        if (cMC._visible == false)
        {
            return;
        } // end if
        if (cMC.hitTest(some.__get___mc().hitMC) == false)
        {
            return;
        } // end if
        cMC._visible = false;
        var _loc3 = cMC._name.substring(3, cMC._name.length);
        if (str != pjam.fight.player.Player.POWER_STATE)
        {
            this.setBonus(str);
        } // end if
        if (this.damageGet(vec, cMC, str, _loc3) == 0)
        {
            return;
        } // end if
        if (mc._y == area.yMax && some.__get___mc()._y < area.yMax)
        {
            this.someHitAway();
        }
        else if (some.__get___mc()._y < area.yMax)
        {
            this.someReAerial();
        }
        else if (_loc3 == "UP")
        {
            this.someAerial();
        }
        else
        {
            this.someHitBack(_loc3);
        } // end else if
        this.actionCansel();
    } // End of the function
    function damageGet(vec, cMC, str, hit)
    {
        var _loc2 = 0;
        if (str != pjam.fight.player.Player.POWER_STATE && pjam.fight.DamageGet.smashCheck(cdata.luck) == true)
        {
            _loc2 = pjam.fight.DamageGet.smash(str, cdata);
            effect.smash(mc, pjam.fight.player.Player.getVecStr(vec));
        }
        else if (str != pjam.fight.player.Player.POWER_STATE)
        {
            _loc2 = pjam.fight.DamageGet.normal(str, hit, cdata, some.__get___cdata());
        }
        else
        {
            _loc2 = pjam.fight.DamageGet.power(hit, cdata, some.__get___cdata());
        } // end else if
        return (some.dispDamage(_loc2));
    } // End of the function
    function defense(vec, cMC)
    {
        if (cMC == undefined)
        {
            return;
        } // end if
        if (cMC._visible == false)
        {
            return;
        } // end if
        if (cMC.hitTest(mc.hitMC) == false)
        {
            return;
        } // end if
        if (some.__get___state() == pjam.fight.player.Player.MAGIC_STATE)
        {
            return;
        } // end if
        this.setBonus(pjam.fight.player.Player.DEFENSE_STATE);
        effect.defense(mc, pjam.fight.player.Player.getVecStr());
        this.someAerial();
        this.actionCansel();
    } // End of the function
    var ATTACK_MOVE = 6;
    var actStep = 0;
    var spFlg = true;
    var actionCanselFlg = false;
} // End of Class
