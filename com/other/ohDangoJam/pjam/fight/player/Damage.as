class pjam.fight.player.Damage
{
    var mc, scene, area, _x, _y, hitMC, end;
    function Damage(mc, scene, area)
    {
        this.mc = mc;
        this.scene = scene;
        this.area = area;
    } // End of the function
    function destroy()
    {
        damageEndFlg = true;
        delete mc.onEnterFrame;
    } // End of the function
    function hitBack(vec, hit)
    {
        ++comboNum;
        var sc = this;
        var step = 0;
        var _loc2 = false;
        mc.onEnterFrame = function ()
        {
            if (sc.damageEndFlg == true)
            {
                return;
            } // end if
            if (pjam.fight.player.Player.setAreaPosition(this, sc.scene, sc.area) == true)
            {
                sc.hitBackMy(sc["BACK_" + hit] - step);
            }
            else
            {
                _x = _x + pjam.fight.player.Damage.BACK_SPEED * -vec;
            } // end else if
            if (++step >= sc["BACK_" + hit])
            {
                sc.damageEnd("wait", vec);
            } // end if
        };
    } // End of the function
    function aerial(vec)
    {
        ++comboNum;
        mc.mc.gotoAndPlay(1);
        var sc = this;
        var step = 0;
        var jnum = FIRST_AERIAL;
        mc.onEnterFrame = function ()
        {
            if (++step < sc.AERIAL_MAX)
            {
                _y = _y - (jnum = jnum * sc.AERIAL_UP);
            }
            else
            {
                _y = _y + (jnum = jnum * sc.AERIAL_DOWN);
            } // end else if
            if (_y < sc.area.yMax)
            {
                return;
            } // end if
            if (sc.damageEndFlg == false)
            {
                sc.damageEnd("wait", vec);
            } // end if
        };
    } // End of the function
    function hitAway(vec)
    {
        ++comboNum;
        ++reAerialNum;
        var sc = this;
        var _loc2 = 0;
        mc.onEnterFrame = function ()
        {
            _y = _y + sc.AWAY_DOWN_SPEED;
            if (pjam.fight.player.Player.checkArea(hitMC, sc.scene, sc.area) == false)
            {
                _x = _x - vec * sc.AWAY_MOVE_SPEED;
            } // end if
            if (_y < sc.area.yMax)
            {
                return;
            } // end if
            if (sc.damageEndFlg == false)
            {
                sc.damageEnd("ko", vec);
            } // end if
        };
    } // End of the function
    function reAerial(vec)
    {
        ++comboNum;
        ++reAerialNum;
        var sc = this;
        var step = 0;
        var hitNum = reAerialNum > 3 ? (3) : (reAerialNum);
        var jnum = this["FIRST_RE_AERIAL" + hitNum];
        mc.onEnterFrame = function ()
        {
            if (pjam.fight.player.Player.checkArea(hitMC, sc.scene, sc.area) == false)
            {
                _x = _x - vec * sc.RE_AERIAL_MOVE;
            } // end if
            var _loc2 = sc["RE_AERIAL_MAX" + hitNum];
            if (++step < _loc2)
            {
                _y = _y - (jnum = jnum * sc.RE_AERIAL_UP);
            }
            else
            {
                _y = _y + (jnum = jnum * sc.RE_AERIAL_DOWN);
            } // end else if
            if (_y < sc.area.yMax)
            {
                return;
            } // end if
            if (sc.damageEndFlg == false)
            {
                sc.damageEnd("wait", vec);
            } // end if
        };
    } // End of the function
    function ko(vec)
    {
        ++comboNum;
        var sc = this;
        var step = 0;
        var jnum = pjam.fight.player.Jump.FIRST_JUMP;
        mc.onEnterFrame = function ()
        {
            if (pjam.fight.player.Player.checkArea(hitMC, sc.scene, sc.area) == false)
            {
                _x = _x - vec * sc.RE_AERIAL_MOVE;
            } // end if
            if (++step < pjam.fight.player.Jump.JUMP_MAX)
            {
                _y = _y - (jnum = jnum * pjam.fight.player.Jump.JUMP_UP);
            }
            else
            {
                _y = _y + (jnum = jnum * pjam.fight.player.Jump.JUMP_DOWN);
            } // end else if
            if (_y < sc.area.yMax)
            {
                return;
            } // end if
            sc.damageEnd("ko", vec);
        };
    } // End of the function
    function damageEnd(frame, vec)
    {
        mc._y = area.yMax;
        delete mc.onEnterFrame;
        mc.gotoAndStop(frame + pjam.fight.player.Player.getVecStr(vec));
        this.end(comboNum);
        comboNum = 0;
        reAerialNum = 0;
    } // End of the function
    var damageEndFlg = false;
    static var BACK_SPEED = 2;
    var BACK_S = 3;
    var BACK_M = 4;
    var BACK_H = 6;
    var FIRST_AERIAL = 25;
    var AERIAL_UP = 0.700000;
    var AERIAL_DOWN = 1.400000;
    var AERIAL_MAX = 7;
    var FIRST_AWAY = 25;
    var AWAY_MOVE_SPEED = 6;
    var AWAY_DOWN_SPEED = 6;
    var AWAY_MAX = 14;
    var FIRST_RE_AERIAL1 = 10;
    var FIRST_RE_AERIAL2 = 8;
    var FIRST_RE_AERIAL3 = 7;
    var RE_AERIAL_MOVE = 4;
    var RE_AERIAL_UP = 0.700000;
    var RE_AERIAL_DOWN = 1.400000;
    var RE_AERIAL_MAX1 = 6;
    var RE_AERIAL_MAX2 = 5;
    var RE_AERIAL_MAX3 = 3;
    var comboNum = 0;
    var reAerialNum = 0;
} // End of Class
