class pjam.fight.TextEffect
{
    var root, scene, onEnterFrame, moveEnd, _alpha, removeMovieClip, _x;
    function TextEffect(root, scene)
    {
        this.root = root;
        this.scene = scene;
    } // End of the function
    function start(str, charMC, clrNum, mode)
    {
        var _loc9 = scene.getNextHighestDepth();
        var lineMC = scene.createEmptyMovieClip("lineMC" + _loc9, _loc9);
        var _loc5 = 0;
        for (var _loc2 = 0; _loc2 < str.length; ++_loc2)
        {
            var _loc4 = lineMC.attachMovie(BTM_MC, BTM_MC + _loc2, lineMC.getNextHighestDepth());
            var _loc3 = lineMC.attachMovie(TOP_MC, TOP_MC + _loc2, lineMC.getNextHighestDepth());
            _loc3.gotoAndStop(str.charCodeAt(_loc2));
            _loc4.gotoAndStop(str.charCodeAt(_loc2));
            _loc3._visible = false;
            _loc4._visible = false;
            var _loc6 = new Color(_loc4);
            _loc6.setRGB(clrNum);
            _loc3._x = _loc5;
            _loc4._x = _loc5;
            _loc5 = _loc5 + (_loc3._width + 1);
        } // end of for
        if (mode == pjam.fight.TextEffect.DAMAGE_MODE)
        {
            lineMC._x = charMC._x - Math.floor(lineMC._width / 2);
            lineMC._y = Math.floor(charMC._y - charMC._height - 10);
        }
        else if (mode == pjam.fight.TextEffect.MONEY_MODE)
        {
            lineMC._x = charMC._x - lineMC._width;
            lineMC._y = charMC._y;
        } // end else if
        var sc = this;
        var num = -1;
        var count = 0;
        lineMC.onEnterFrame = function ()
        {
            this[sc.TOP_MC + count].moveEnd = function ()
            {
                if (++count >= str.length)
                {
                    sc.eraze(lineMC);
                } // end if
            };
            if (mode == pjam.fight.TextEffect.DAMAGE_MODE)
            {
                sc.move(this, ++num);
            }
            else if (mode == pjam.fight.TextEffect.MONEY_MODE)
            {
                sc.money(this, ++num);
            } // end else if
        };
    } // End of the function
    function move(lineMC, num)
    {
        var sc = this;
        var vec = -1;
        var topMC = lineMC[TOP_MC + num];
        var btmMC = lineMC[BTM_MC + num];
        var step = 0;
        var speed = FIRST_SPEED;
        var first = topMC._y;
        topMC._visible = true;
        btmMC._visible = true;
        topMC.onEnterFrame = function ()
        {
            topMC._y = topMC._y + vec * speed;
            btmMC._y = btmMC._y + vec * speed;
            speed = speed * (++step < sc.STEP_MAX ? (sc.SPEED_DOWN) : (sc.SPEED_UP));
            if (step >= sc.STEP_MAX)
            {
                vec = 1;
            } // end if
            if (step < sc.STEP_MAX)
            {
                return;
            } // end if
            if (topMC._y < first)
            {
                return;
            } // end if
            topMC._y = first;
            btmMC._y = first;
            delete this.onEnterFrame;
            this.moveEnd();
        };
    } // End of the function
    function money(lineMC, num)
    {
        var _loc7 = this;
        var _loc6 = -1;
        var _loc2 = lineMC[TOP_MC + num];
        var _loc3 = lineMC[BTM_MC + num];
        _loc2._visible = true;
        _loc3._visible = true;
        var step = 0;
        var max = 10;
        _loc2.onEnterFrame = function ()
        {
            if (++step >= max)
            {
                this.moveEnd();
            } // end if
        };
    } // End of the function
    function eraze(lineMC)
    {
        lineMC.onEnterFrame = function ()
        {
            _alpha = _alpha - 30;
            if (_alpha <= 0)
            {
                this.removeMovieClip();
            } // end if
        };
    } // End of the function
    function combo(num, pnum)
    {
        var str = num.toString() + "COMBO!";
        var _loc9 = scene.getNextHighestDepth();
        var _loc6 = scene.createEmptyMovieClip("comboMC" + _loc9, _loc9);
        var _loc7 = 0;
        for (var _loc3 = 0; _loc3 < str.length; ++_loc3)
        {
            var _loc5 = _loc6.attachMovie(BTM_MC, BTM_MC + _loc3, _loc6.getNextHighestDepth());
            var _loc4 = _loc6.attachMovie(TOP_MC, TOP_MC + _loc3, _loc6.getNextHighestDepth());
            _loc4.gotoAndStop(str.charCodeAt(_loc3));
            _loc5.gotoAndStop(str.charCodeAt(_loc3));
            _loc4._alpha = 0;
            _loc5._alpha = 0;
            var _loc8 = new Color(_loc5);
            _loc8.setRGB(16763904);
            _loc4._x = _loc7;
            _loc5._x = _loc7;
            _loc7 = _loc7 + (_loc4._width + 1);
        } // end of for
        _loc6._x = scene["mc" + pnum]._x;
        _loc6._y = scene["mc" + pnum]._y;
        var sc = this;
        var numC = -1;
        var count = 0;
        _loc6.onEnterFrame = function ()
        {
            this[sc.TOP_MC + count].moveEnd = function ()
            {
                ++count;
            };
            if (++numC < str.length)
            {
                sc.comboDisp(this, numC);
            } // end if
            if (count < str.length)
            {
                return;
            } // end if
            delete this.onEnterFrame;
            _global.setTimeout(function (mc)
            {
                mc.onEnterFrame = function ()
                {
                    _x = _x + 3;
                    _alpha = _alpha - 10;
                    if (_alpha <= 0)
                    {
                        this.removeMovieClip();
                    } // end if
                };
            }, 600, this);
        };
    } // End of the function
    function comboDisp(lineMC, num)
    {
        var _loc4 = this;
        var topMC = lineMC[TOP_MC + num];
        var btmMC = lineMC[BTM_MC + num];
        topMC.onEnterFrame = function ()
        {
            topMC._alpha = topMC._alpha + 10;
            btmMC._alpha = btmMC._alpha + 10;
            if (topMC._alpha < 100)
            {
                return;
            } // end if
            delete this.onEnterFrame;
            this.moveEnd();
        };
    } // End of the function
    var FIRST_SPEED = 4;
    var SPEED_UP = 1.050000;
    var SPEED_DOWN = 0.800000;
    var STEP_MAX = 3;
    var TOP_MC = "fontTopMC";
    var BTM_MC = "fontBtmMC";
    static var DAMAGE_MODE = 1;
    static var MONEY_MODE = 2;
} // End of Class
