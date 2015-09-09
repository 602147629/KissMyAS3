class pjam.fight.player.Jump
{
    var mc, scene, area, _x, _y, onEnterFrame;
    function Jump(mc, scene, area)
    {
        this.mc = mc;
        this.scene = scene;
        this.area = area;
    } // End of the function
    function destroy()
    {
        aerialJump = 0;
        delete mc.onEnterFrame;
    } // End of the function
    function checkJump(num)
    {
        return (aerialJump >= num ? (false) : (true));
    } // End of the function
    function changeVec()
    {
        changeVecFlg = true;
    } // End of the function
    function main(speed, vec, flg)
    {
        ++aerialJump;
        var step = 0;
        var jnum = pjam.fight.player.Jump.FIRST_JUMP;
        if (flg == true)
        {
            mc.gotoAndStop("run" + pjam.fight.player.Player.getVecStr(vec));
        }
        else
        {
            mc.gotoAndStop("wait" + pjam.fight.player.Player.getVecStr(vec));
        } // end else if
        var sc = this;
        var _loc2 = false;
        mc.onEnterFrame = function ()
        {
            if (sc.changeVecFlg == true)
            {
                sc.changeVecFlg = false;
                vec = vec * -1;
            } // end if
            if (flg == true)
            {
                _x = _x + speed * vec;
            } // end if
            if (pjam.fight.player.Player.setAreaPosition(this, sc.scene, sc.area) == true)
            {
                flg = false;
            } // end if
            if (++step < pjam.fight.player.Jump.JUMP_MAX)
            {
                _y = _y - (jnum = jnum * pjam.fight.player.Jump.JUMP_UP);
            }
            else
            {
                _y = _y + (jnum = jnum * pjam.fight.player.Jump.JUMP_DOWN);
            } // end else if
            sc.aiActCheck();
            if (_y < sc.area.yMax)
            {
                return;
            } // end if
            sc.aerialJump = 0;
            _y = sc.area.yMax;
            delete this.onEnterFrame;
            sc.end();
        };
    } // End of the function
    static var FIRST_JUMP = 8;
    static var JUMP_UP = 0.800000;
    static var JUMP_DOWN = 1.200000;
    static var JUMP_MAX = 7;
    var aerialJump = 0;
    var changeVecFlg = false;
} // End of Class
