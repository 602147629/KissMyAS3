class pjam.fight.StageEffect
{
    var root, scene, _x, _y, removeMovieClip, _alpha;
    function StageEffect(root)
    {
        this.root = root;
        scene = root.stageMC.fightMC.backMC;
    } // End of the function
    function start()
    {
        var _loc2 = Math.floor(Math.random() * scene._totalframes) + 1;
        scene.gotoAndStop(_loc2);
        if (_loc2 >= STAGE3)
        {
            this.room();
        }
        else if (_loc2 >= STAGE2)
        {
            this.city();
        }
        else
        {
            this.forest1(_loc2);
        } // end else if
    } // End of the function
    function forest1(kind)
    {
        if (kind == 4)
        {
            this.forest2();
            return;
        } // end if
        var sc = this;
        scene.onEnterFrame = function ()
        {
            if (Math.floor(Math.random() * sc.LEAF_NUM) != 0)
            {
                return;
            } // end if
            var _loc3 = sc.scene.getNextHighestDepth();
            var _loc2 = sc.scene.attachMovie("leafMC" + kind, "leafMC" + _loc3, _loc3);
            _loc2._x = Math.floor(Math.random() * sc.scene._width - 60);
            _loc2._y = -_loc2._height;
            var x = Math.floor(Math.random() * 3) + 1;
            var y = Math.floor(Math.random() * 2) + 1;
            _loc2.onEnterFrame = function ()
            {
                _x = _x + x;
                _y = _y + y;
                if (_y > sc.STAGE_HEIGHT)
                {
                    this.removeMovieClip();
                } // end if
            };
        };
    } // End of the function
    function forest2()
    {
        var sc = this;
        scene.onEnterFrame = function ()
        {
            if (Math.floor(Math.random() * sc.POW_NUM) != 0)
            {
                return;
            } // end if
            var _loc3 = sc.scene.getNextHighestDepth();
            var _loc2 = sc.scene.attachMovie("powMC1", "powMC" + _loc3, _loc3);
            _loc2._x = Math.floor(Math.random() * sc.scene._width);
            _loc2._y = Math.floor(Math.random() * sc.scene._height + 40);
            var y = Math.floor(Math.random() * 1) + 1;
            var first = _loc2._y;
            _loc2.onEnterFrame = function ()
            {
                _y = _y - y;
                if (_y > first - 20)
                {
                    return;
                } // end if
                if ((_alpha = _alpha - 10) <= 0)
                {
                    this.removeMovieClip();
                } // end if
            };
        };
    } // End of the function
    function city()
    {
        var sc = this;
        scene.onEnterFrame = function ()
        {
            if (Math.floor(Math.random() * sc.SNOW_NUM) != 0)
            {
                return;
            } // end if
            var _loc3 = sc.scene.getNextHighestDepth();
            var _loc2 = sc.scene.attachMovie("snowMC1", "snowMC" + _loc3, _loc3);
            _loc2._x = Math.floor(Math.random() * sc.scene._width);
            var _loc4 = Math.floor(Math.random() * 30) + 100;
            _loc2._xscale = _loc4;
            _loc2._yscale = _loc4;
            var y = 1;
            _loc2.onEnterFrame = function ()
            {
                _y = _y + y;
                if (_y > sc.STAGE_HEIGHT)
                {
                    this.removeMovieClip();
                } // end if
            };
        };
    } // End of the function
    function room()
    {
    } // End of the function
    var STAGE1 = 4;
    var STAGE2 = 5;
    var STAGE3 = 6;
    var STAGE_HEIGHT = 114;
    var LEAF_NUM = 5;
    var POW_NUM = 10;
    var SNOW_NUM = 15;
} // End of Class
