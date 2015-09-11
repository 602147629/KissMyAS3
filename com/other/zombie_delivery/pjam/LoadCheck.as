class pjam.LoadCheck
{
    var root, scene, _framesloaded, onEnterFrame, _currentframe, _totalframes, getBytesLoaded, getBytesTotal, _alpha;
    function LoadCheck(root)
    {
        this.root = root;
        scene = root.loadingMC;
    } // End of the function
    function open()
    {
        var sc = this;
        root.onEnterFrame = function ()
        {
            if (_framesloaded < sc.FIRST_NUM)
            {
                return;
            } // end if
            sc.root.gotoAndStop("open");
            delete this.onEnterFrame;
            sc.root.openFirstMC.onEnterFrame = function ()
            {
                if (_currentframe < _totalframes)
                {
                    return;
                } // end if
                delete this.onEnterFrame;
                sc.root.onEnterFrame = function ()
                {
                    if (_framesloaded < sc.OPEN_NUM)
                    {
                        return;
                    } // end if
                    delete this.onEnterFrame;
                    sc.openEnd();
                };
            };
            sc.root.loadingMC.barMC._visible = false;
        };
    } // End of the function
    function main()
    {
        root.gotoAndStop("load");
        root.btn.useHandCursor = false;
        scene.barMC._visible = true;
        var sc = this;
        root.onEnterFrame = function ()
        {
            var _loc2 = this.getBytesLoaded() * 100 / this.getBytesTotal();
            sc.scene.barMC._width = _loc2 * sc.scene.barMaxMC._width / 100;
            if (_loc2 >= 100)
            {
                delete this.onEnterFrame;
                sc.end();
            } // end if
        };
    } // End of the function
    function end()
    {
        scene.nextFrame();
        var sc = this;
        root.btn.onPress = function ()
        {
            sc.feedOut();
        };
    } // End of the function
    function feedOut()
    {
        var _loc2 = new Sound();
        _loc2.attachSound("startSound");
        _loc2.start();
        var sc = this;
        root.openMC.onEnterFrame = function ()
        {
            sc.root.loadingMC._alpha = sc.root.loadingMC._alpha - 5;
            if ((_alpha = _alpha - 5) > 0)
            {
                return;
            } // end if
            delete this.onEnterFrame;
            sc.loadEnd();
        };
    } // End of the function
    var FIRST_NUM = 11;
    var OPEN_NUM = 16;
} // End of Class
