class pjam.fight.player.AiPlayer
{
    var mc, scene, area, some, aiEndFlg, waitID, move, jump, action;
    function AiPlayer(mc, scene, area, some, pnum)
    {
        this.mc = mc;
        this.scene = scene;
        this.area = area;
        this.some = some;
        if (pnum == pjam.fight.player.Player.PLAYER_EN)
        {
            actMode = Math.floor(Math.random() * AI_ACT_MAX);
        } // end if
    } // End of the function
    function destroy()
    {
        aiEndFlg = true;
        clearInterval(waitID);
    } // End of the function
    function nextAct(vec)
    {
        aiEndFlg = false;
        var _loc2 = this["ACT_MODE" + actMode];
        var _loc3 = Math.floor(Math.random() * _loc2.special);
        if (_loc3 < _loc2.wait)
        {
            this.wait(vec);
            return;
        }
        else if (_loc3 < _loc2.move)
        {
            this.move();
            return;
        }
        else if (_loc3 < _loc2.jump)
        {
            this.jump();
            return;
        } // end else if
        if (pjam.fight.player.AiPlayer.aiCheckNear(mc, scene, some) == false)
        {
            if (Math.floor(Math.random() * 10) != 0)
            {
                this.wait(vec);
                return;
            } // end if
        } // end if
        if (_loc3 < _loc2.attack)
        {
            this.action(pjam.fight.player.Player.ATTACK_STATE);
        }
        else if (_loc3 < _loc2.magic)
        {
            this.action(pjam.fight.player.Player.MAGIC_STATE);
        }
        else if (_loc3 < _loc2.defense)
        {
            this.action(pjam.fight.player.Player.DEFENSE_STATE);
        }
        else
        {
            this.action(pjam.fight.player.Player.POWER_STATE);
        } // end else if
    } // End of the function
    function wait(vec)
    {
        mc.gotoAndStop("wait" + pjam.fight.player.Player.getVecStr(vec));
        clearInterval(waitID);
        var _loc2 = Math.floor(Math.random() * WAIT_TIME);
        waitID = setInterval(function (sc)
        {
            if (sc.aiEndFlg == true)
            {
                return;
            } // end if
            clearInterval(sc.waitID);
            sc.waitEnd();
        }, _loc2, this);
    } // End of the function
    function aiCheckAct()
    {
        if (pjam.fight.player.AiPlayer.aiCheckNear(mc, scene, some) == true && Math.floor(Math.random() * NEAR_NXT_PER) >= NEAR_NON_PER || Math.floor(Math.random() * RAN_NXT_PER) >= RAN_NON_PER)
        {
            return (true);
        }
        else
        {
            return (false);
        } // end else if
    } // End of the function
    static function aiCheckNear(mc, scene, some)
    {
        var _loc2 = mc.hitMC.getBounds(scene);
        var _loc1 = some.__get___mc().hitMC.getBounds(scene);
        if (mc._x > some.__get___mc()._x && _loc2.xMin - pjam.fight.player.AiPlayer.NEAR_DIS <= _loc1.xMax)
        {
            return (true);
        } // end if
        if (mc._x < some.__get___mc()._x && _loc2.xMax + pjam.fight.player.AiPlayer.NEAR_DIS >= _loc1.xMin)
        {
            return (true);
        } // end if
        return (false);
    } // End of the function
    function aiHitJump()
    {
        if (Math.floor(Math.random() * HIT_JMP_PER) >= HIT_NON_PER)
        {
            return (true);
        }
        else
        {
            return (false);
        } // end else if
    } // End of the function
    var actMode = 0;
    var AI_ACT_MAX = 4;
    var ACT_MODE0 = {wait: 3, move: 35, jump: 45, attack: 60, magic: 85, defense: 95, special: 100};
    var ACT_MODE1 = {wait: 5, move: 20, jump: 30, attack: 40, magic: 50, defense: 60, special: 70};
    var ACT_MODE2 = {wait: 10, move: 40, jump: 45, attack: 50, magic: 55, defense: 60, special: 63};
    var ACT_MODE3 = {wait: 5, move: 30, jump: 35, attack: 60, magic: 70, defense: 80, special: 90};
    var WAIT_TIME = 200;
    static var NEAR_DIS = 15;
    var NEAR_NON_PER = 3;
    var NEAR_NXT_PER = 5;
    var RAN_NON_PER = 190;
    var RAN_NXT_PER = 200;
    var HIT_NON_PER = 5;
    var HIT_JMP_PER = 6;
} // End of Class
