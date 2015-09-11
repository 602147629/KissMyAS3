class pjam.fight.player.Move
{
    var mc, scene, area, pnum, moveMC, onEnterFrame;
    function Move(mc, scene, area, pnum)
    {
        this.mc = mc;
        this.scene = scene;
        this.area = area;
        this.pnum = pnum;
    } // End of the function
    function checkMoveState()
    {
        return (moveMC.onEnterFrame != undefined ? (true) : (false));
    } // End of the function
    function destroy()
    {
        moveEndFlg = true;
        moveMC.removeMovieClip();
    } // End of the function
    function main(vec, speed)
    {
        moveEndFlg = false;
        mc.gotoAndStop("run" + pjam.fight.player.Player.getVecStr(vec));
        var step = 0;
        this.createMoveMC();
        var sc = this;
        moveMC.onEnterFrame = function ()
        {
            if (sc.moveEndFlg == true)
            {
                sc.moveEndFunc(vec);
                return;
            } // end if
            sc.mc._x = sc.mc._x + speed * vec;
            if (pjam.fight.player.Player.checkArea(sc.mc.hitMC, sc.scene, sc.area) == true)
            {
                step = sc.STEP_MAX;
                sc.mc._x = sc.mc._x - speed * vec;
            } // end if
            if (++step < sc.STEP_MAX)
            {
                return;
            } // end if
            sc.moveEndFunc(vec);
        };
    } // End of the function
    function moveMouse(vec, speed)
    {
        moveEndFlg = false;
        var _loc3 = mc.hitMC.getBounds(scene);
        if (_loc3.xMin <= scene._xmouse && scene._xmouse <= _loc3.xMax)
        {
            return;
        } // end if
        mc.gotoAndStop("run" + pjam.fight.player.Player.getVecStr(vec));
        this.createMoveMC();
        var sc = this;
        moveMC.onEnterFrame = function ()
        {
            if (sc.moveEndFlg == true)
            {
                sc.moveEndFunc(vec);
                return;
            } // end if
            sc.mc._x = sc.mc._x + speed * vec;
            if (pjam.fight.player.Player.setAreaPosition(sc.mc, sc.scene, sc.area) == true)
            {
                sc.moveEndFunc(vec);
                return;
            } // end if
            var _loc1 = sc.mc.hitMC.getBounds(sc.scene);
            if (vec == 1 && _loc1.xMax < sc.scene._xmouse)
            {
                return;
            } // end if
            if (vec == -1 && _loc1.xMin > sc.scene._xmouse)
            {
                return;
            } // end if
            sc.moveEndFunc(vec);
        };
    } // End of the function
    function hitBack(step, vec)
    {
        moveEndFlg = false;
        var sc = this;
        var back = 0;
        this.createMoveMC();
        moveMC.onEnterFrame = function ()
        {
            if (sc.moveEndFlg == true)
            {
                delete this.onEnterFrame;
                return;
            } // end if
            sc.mc._x = sc.mc._x + pjam.fight.player.Damage.BACK_SPEED * -vec;
            if (++back >= step)
            {
                delete this.onEnterFrame;
            } // end if
        };
    } // End of the function
    function aiMove(vec, speed, some)
    {
        moveEndFlg = false;
        mc.gotoAndStop("run" + pjam.fight.player.Player.getVecStr(vec));
        var bns = mc.hitMC.getBounds(scene);
        var point = vec == 1 ? (Math.floor(Math.random() * (area.xMax - bns.xMax)) + bns.xMax) : (Math.floor(Math.random() * (bns.xMin - area.xMin)) + area.xMin);
        if (point > area.xMax)
        {
            point = area.xMax;
        } // end if
        if (point < area.xMin)
        {
            point = area.xMin;
        } // end if
        this.createMoveMC();
        var sc = this;
        moveMC.onEnterFrame = function ()
        {
            if (sc.moveEndFlg == true)
            {
                return;
            } // end if
            sc.mc._x = sc.mc._x + speed * vec;
            if (sc.mc._y == sc.area.yMax && pjam.fight.player.AiPlayer.aiCheckNear(sc.mc, sc.scene, some) == true)
            {
                sc.moveEndFunc(vec);
                sc.aiMoveEnd();
                return;
            } // end if
            var _loc1 = sc.mc.hitMC.getBounds(sc.scene);
            if (vec == 1 && _loc1.xMax < point)
            {
                return;
            } // end if
            if (vec == -1 && _loc1.xMin > point)
            {
                return;
            } // end if
            if (vec == 1 && bns.xMax >= point)
            {
                sc.mc._x = point - Math.floor(sc.mc.hitMC._width / 2);
            }
            else if (vec == -1 && bns.xMin <= point)
            {
                sc.mc._x = point + Math.floor(sc.mc.hitMC._width / 2);
            } // end else if
            sc.moveEndFunc(vec);
            sc.aiMoveEnd();
        };
    } // End of the function
    function moveEndFunc(vec)
    {
        delete moveMC.onEnterFrame;
        mc.gotoAndStop("wait" + pjam.fight.player.Player.getVecStr(vec));
    } // End of the function
    function createMoveMC()
    {
        moveMC.removeMovieClip();
        moveMC = scene.createEmptyMovieClip("moveMC" + pnum, scene.getNextHighestDepth());
    } // End of the function
    var moveEndFlg = false;
    var STEP_MAX = 12;
} // End of Class
